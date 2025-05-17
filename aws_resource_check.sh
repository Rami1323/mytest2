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

check "Unattached EBS Volumes" "aws ec2 describe-volumes --filters Name=status,Values=available --query \"Volumes[*].[VolumeId,Size,AvailabilityZone,State,Tags[?Key=='Name']|[0].Value]\" --output table"

check "Stopped EC2 Instances (with Name tag)" "aws ec2 describe-instances --filters Name=instance-state-name,Values=stopped --query \"Reservations[].Instances[].[InstanceId,State.Name,Tags[?Key=='Name']|[0].Value]\" --output table"

check "Stopped EC2 Instance IDs only" "aws ec2 describe-instances --filters Name=instance-state-name,Values=stopped --query \"Reservations[].Instances[].InstanceId\" --output table"

check "Unused Elastic IPs" "aws ec2 describe-addresses --query \"Addresses[?AssociationId==null].[PublicIp,AllocationId]\" --output table"

check "CloudWatch Dashboards" "aws cloudwatch list-dashboards --output table"

check "Unused Security Groups" "aws ec2 describe-security-groups --query \"SecurityGroups[?length(IpPermissions)==\`0\` && length(IpPermissionsEgress)==\`0\`]" --output table"

check "IAM Roles" "aws iam list-roles --output table"

check "IAM Policies (Local)" "aws iam list-policies --scope Local --output table"

check "VPC Endpoints" "aws ec2 describe-vpc-endpoints --output table"

check "Step Functions" "aws stepfunctions list-state-machines --output table"

check "Snapshots (owned)" "aws ec2 describe-snapshots --owner-ids self --output table"

check "CodePipelines" "aws codepipeline list-pipelines --output table"

check "EventBridge Rules" "aws events list-rules --output table"

echo "" | tee -a "$output_file"
echo "Done. Output saved to $output_file" | tee -a "$output_file"
