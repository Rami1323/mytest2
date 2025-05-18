#!/bin/bash

base_dir="aws_resource_csv_output_$(date +%F)"
mkdir -p "$base_dir"

check() {
  echo "Generating: $1"
  eval "$2" > "$base_dir/$3.csv" 2>&1
}

check "Stopped EC2 Instances with Name tag" \
"aws ec2 describe-instances --filters Name=instance-state-name,Values=stopped --query 'Reservations[].Instances[].[InstanceId,State.Name,Tags[?Key==\`Name\`] | [0].Value]' --output csv" \
"stopped_ec2_instances"

check "Stopped EC2 Instance IDs only" \
"aws ec2 describe-instances --filters Name=instance-state-name,Values=stopped --query 'Reservations[].Instances[].InstanceId' --output csv" \
"stopped_instance_ids"

check "Unused Elastic IPs" \
"aws ec2 describe-addresses --query 'Addresses[?AssociationId==null].[PublicIp,AllocationId]' --output csv" \
"unused_elastic_ips"

check "CloudWatch Dashboards" \
"aws cloudwatch list-dashboards --output csv" \
"cloudwatch_dashboards"

check "Unused Security Groups" \
"aws ec2 describe-security-groups --query 'SecurityGroups[?length(IpPermissions)==`0` && length(IpPermissionsEgress)==`0`].[GroupId,GroupName,VpcId]' --output csv" \
"unused_security_groups"

check "IAM Roles" \
"aws iam list-roles --query 'Roles[*].[RoleName,Arn,CreateDate]' --output csv" \
"iam_roles"

check "IAM Policies Local" \
"aws iam list-policies --scope Local --query 'Policies[*].[PolicyName,Arn,CreateDate]' --output csv" \
"iam_policies_local"

check "VPC Endpoints" \
"aws ec2 describe-vpc-endpoints --query 'VpcEndpoints[*].[VpcEndpointId,VpcId,ServiceName,VpcEndpointType,State]' --output csv" \
"vpc_endpoints"

check "Step Functions" \
"aws stepfunctions list-state-machines --query 'stateMachines[*].[name,stateMachineArn,creationDate]' --output csv" \
"step_functions"

check "Snapshots owned" \
"aws ec2 describe-snapshots --owner-ids self --query 'Snapshots[*].[SnapshotId,VolumeId,StartTime,State]' --output csv" \
"snapshots_owned"

check "CodePipelines" \
"aws codepipeline list-pipelines --query 'pipelines[*].[name,version]' --output csv" \
"codepipelines"

check "EventBridge Rules" \
"aws events list-rules --query 'Rules[*].[Name,Arn,EventPattern,State]' --output csv" \
"eventbridge_rules"

zip_file="${base_dir}.zip"
zip -r "$zip_file" "$base_dir" > /dev/null

echo "All CSV output saved and zipped into: $zip_file"
