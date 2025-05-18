#!/bin/bash

base_dir="aws_resource_csv_output_$(date +%F)"
mkdir -p "$base_dir"

check() {
  echo "Generating: $1"
  "${@:3}" --output text | tr "\t" "," > "$base_dir/$2.csv" 2>&1
}

check "Stopped EC2 Instances with Name tag" "stopped_ec2_instances" \
aws ec2 describe-instances --filters Name=instance-state-name,Values=stopped \
--query "Reservations[].Instances[].[InstanceId,State.Name,Tags[?Key=='Name']|[0].Value]"

check "Stopped EC2 Instance IDs only" "stopped_instance_ids" \
aws ec2 describe-instances --filters Name=instance-state-name,Values=stopped \
--query "Reservations[].Instances[].InstanceId"

check "Unused Elastic IPs" "unused_elastic_ips" \
aws ec2 describe-addresses \
--query "Addresses[?AssociationId==null].[PublicIp,AllocationId]"

check "CloudWatch Dashboards" "cloudwatch_dashboards" \
aws cloudwatch list-dashboards

check "Unused Security Groups" "unused_security_groups" \
aws ec2 describe-security-groups \
--query "SecurityGroups[?length(IpPermissions)==\`0\` && length(IpPermissionsEgress)==\`0\`].[GroupId,GroupName,VpcId]"

check "IAM Roles" "iam_roles" \
aws iam list-roles \
--query "Roles[*].[RoleName,Arn,CreateDate]"

check "IAM Policies Local" "iam_policies_local" \
aws iam list-policies --scope Local \
--query "Policies[*].[PolicyName,Arn,CreateDate]"

check "VPC Endpoints" "vpc_endpoints" \
aws ec2 describe-vpc-endpoints \
--query "VpcEndpoints[*].[VpcEndpointId,VpcId,ServiceName,VpcEndpointType,State]"

check "Step Functions" "step_functions" \
aws stepfunctions list-state-machines \
--query "stateMachines[*].[name,stateMachineArn,creationDate]"

check "Snapshots owned" "snapshots_owned" \
aws ec2 describe-snapshots --owner-ids self \
--query "Snapshots[*].[SnapshotId,VolumeId,StartTime,State]"

check "CodePipelines" "codepipelines" \
aws codepipeline list-pipelines \
--query "pipelines[*].[name,version]"

check "EventBridge Rules" "eventbridge_rules" \
aws events list-rules \
--query "Rules[*].[Name,Arn,EventPattern,State]"

zip_file="${base_dir}.zip"
zip -r "$zip_file" "$base_dir" > /dev/null

echo "All CSV output saved and zipped into: $zip_file"
