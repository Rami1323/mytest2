#!/bin/bash

output_file="aws_resource_check_$(date +%F).log"
echo "AWS Resource Check - $(date)" | tee "$output_file"
echo "--------------------------------------" | tee -a "$output_file"

check() {
  echo "" | tee -a "$output_file"
  echo "Checking: $1" | tee -a "$output_file"
  echo "Command: $2" >> "$output_file"
  eval "$2" 2>&1 | tee -a "$output_file"
}

check "Unattached EBS Volumes" "aws ec2 describe-volumes --filters Name=status,Values=available --query 'Volumes[*].[VolumeId,Size,AvailabilityZone,State,Tags[?Key==\'Name\']|[0].Value]' --output text"

check "Stopped EC2 Instances with Name tag" "aws ec2 describe-instances --filters Name=instance-state-name,Values=stopped --query 'Reservations[].Instances[].[InstanceId,State.Name,Tags[?Key==\'Name\']|[0].Value]' --output text"

check "Stopped EC2 Instance IDs only" "aws ec2 describe-instances --filters Name=instance-state-name,Values=stopped --query 'Reservations[].Instances[].InstanceId' --output text"

check "Unused Elastic IPs" "aws ec2 describe-addresses --query 'Addresses[?AssociationId==null].[PublicIp,AllocationId]' --output text"

check "CloudWatch Dashboards" "aws cloudwatch list-dashboards --output text"

check "Unused Security Groups" "aws ec2 describe-security-groups --query 'SecurityGroups[?length(IpPermissions)==\`0\` && length(IpPermissionsEgress)==\`0\`]' --output text"

check "IAM Roles" "aws iam list-roles --output text"

check "IAM Policies Local" "aws iam list-policies --scope Local --output text"

check "VPC Endpoints" "aws ec2 describe-vpc-endpoints --output text"

check "Step Functions" "aws stepfunctions list-state-machines --output text"

check "Snapshots owned" "aws ec2 describe-snapshots --owner-ids self --output text"

check "CodePipelines" "aws codepipeline list-pipelines --output text"

check "EventBridge Rules" "aws events list-rules --output text"

echo "" | tee -a "$output_file"
echo "Done. Output saved to $output_file" | tee -a "$output_file"
