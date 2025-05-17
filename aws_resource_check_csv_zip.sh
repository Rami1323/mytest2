#!/bin/bash

base_dir="aws_resource_csv_output_$(date +%F)"
mkdir -p "$base_dir"

check() {
  echo "Generating: $1"
  eval "$2" > "$base_dir/$3.csv" 2>&1
}

check "Unattached EBS Volumes" "aws ec2 describe-volumes --filters Name=status,Values=available --query 'Volumes[*].[VolumeId,Size,AvailabilityZone,State,Tags[?Key==\'Name\']|[0].Value]' --output text" "unattached_ebs_volumes"

check "Stopped EC2 Instances with Name tag" "aws ec2 describe-instances --filters Name=instance-state-name,Values=stopped --query 'Reservations[].Instances[].[InstanceId,State.Name,Tags[?Key==\'Name\']|[0].Value]' --output text" "stopped_ec2_instances"

check "Stopped EC2 Instance IDs only" "aws ec2 describe-instances --filters Name=instance-state-name,Values=stopped --query 'Reservations[].Instances[].InstanceId' --output text" "stopped_instance_ids"

check "Unused Elastic IPs" "aws ec2 describe-addresses --query 'Addresses[?AssociationId==null].[PublicIp,AllocationId]' --output text" "unused_elastic_ips"

check "CloudWatch Dashboards" "aws cloudwatch list-dashboards --output text" "cloudwatch_dashboards"

check "Unused Security Groups" "aws ec2 describe-security-groups --query 'SecurityGroups[?length(IpPermissions)==\`0\` && length(IpPermissionsEgress)==\`0\`]' --output text" "unused_security_groups"

check "IAM Roles" "aws iam list-roles --output text" "iam_roles"

check "IAM Policies Local" "aws iam list-policies --scope Local --output text" "iam_policies_local"

check "VPC Endpoints" "aws ec2 describe-vpc-endpoints --output text" "vpc_endpoints"

check "Step Functions" "aws stepfunctions list-state-machines --output text" "step_functions"

check "Snapshots owned" "aws ec2 describe-snapshots --owner-ids self --output text" "snapshots_owned"

check "CodePipelines" "aws codepipeline list-pipelines --output text" "codepipelines"

check "EventBridge Rules" "aws events list-rules --output text" "eventbridge_rules"

zip_file="${base_dir}.zip"
zip -r "$zip_file" "$base_dir" > /dev/null

echo "All CSV output saved and zipped into: $zip_file"
