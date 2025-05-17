Objective
To enhance GCP infrastructure security, governance, and operational efficiency by auditing and optimizing existing configurations and enforcing best practices across identity, networking, and monitoring.

Project Name: GCP Cloud Infrastructure Security Enhancement & Standardization
Project Owner: [To be filled by user]
Duration: Q4 2025 to Q4 2026
Scope: Standardizing GCP infrastructure with secure access, naming conventions, controlled environments, and centralized identity and policy enforcement.
________________________________________
1. Overview
This initiative focuses on modernizing and securing the GCP infrastructure. It includes the standardization of resource naming, access control, logging, and implementing best practices for firewall and identity management.
________________________________________
2. Milestones and Deliverables
Q4 2025:
•	Assessment Phase
o	Capture current GCP state: projects, users, firewall rules, and IAM policies.
o	Identify gaps in naming conventions, identity management, and logging.
o	Document current vs. target state.
•	Cost Analysis
o	Analyze existing resources and usage.
o	Recommend optimization to reduce costs.
Q1 2026:
•	Naming Convention Implementation
o	Define and apply consistent project/folder/resource naming standards.
o	Apply naming convention to all existing and new projects.
•	Firewall & IP Management
o	Review and restructure firewall rules.
o	Assign fixed IPs to controlled environments (Dev, QA, Prod).
o	Document ingress/egress policies.
Q2 2026:
•	Centralized Identity and Access Management
o	Integrate GCP IAM with centralized AD/SSO.
o	Define least privilege roles and implement access review policies.
o	Apply RBAC to GCP folders and resources.
•	Policy Enforcement
o	Develop organization policies for resource creation (e.g., labels, tags).
o	Prevent direct IAM changes at project level.
Q3 2026:
•	Logging & Monitoring
o	Ensure all logs are forwarded to Splunk.
o	Enable audit logs across all projects.
o	Define alert policies for critical events.
•	Security Integration
o	Integrate GCP with Wiz.io for security posture management.
o	Enable vulnerability detection and remediation workflows.
Q4 2026:
•	Final Review and Handoff
o	Validate the implemented changes against the target state.
o	Handoff documentation, SOPs, and access control list to ops team.
________________________________________
3. Dependencies
•	Approval of project naming standards.
•	Centralized Identity Management system access (e.g., Azure AD).
•	Splunk access for log verification.
•	Firewall rule export and approval for changes.
________________________________________
4. Recommendations
•	Revisit and revise network architecture if required (Hub-and-Spoke model).
•	Enforce mandatory tagging policies.
•	Apply VPC Service Controls for high-risk services.
•	Enable security command center and cloud DLP.
________________________________________
5. Security Objectives
•	Enforce Least Privilege principle across all services.
•	Protect access using IAM Conditions and MFA.
•	Implement policy constraints (e.g., disallow public IP).
•	Enable secure image policies for compute.
•	Apply encryption policies for storage and secrets.
________________________________________
6. Benefits
•	Enhanced Security: Reduced attack surface and improved threat response.
•	Operational Efficiency: Easier resource discovery and automation.
•	Governance: Policy and access controls applied consistently.
•	Compliance: Supports HIPAA, GDPR, and internal audit readiness.
________________________________________
7. Key Tools and Integrations
•	Splunk: For centralized logging and monitoring.
•	Wiz.io: Security posture and vulnerability scanning.
•	GCP IAM: Role-based access control.
•	Cloud Monitoring & Logging: Native GCP observability tools.
________________________________________
8. Team Roles
•	Cloud Architect: Define target architecture, security enforcement.
•	IAM Engineer: Implement access control, directory sync.
•	DevOps: Apply CI/CD pipelines for policy and firewall rules.
•	Security Analyst: Integrate Wiz.io and analyze vulnerability trends.
________________________________________

Hi RJ,

The Kronos Data Hub project is currently on hold due to environment renaming updates initiated by UKG. As part of the renaming of the Pro WFM regions, the application tenant originally labeled “UAT” is now being updated to “DEV.” This change has impacted the Data Hub and associated SFTP connections.

UKG is in the process of updating the Data Hub environment and connection mappings accordingly (e.g., mta-dev-dhub.npr.mykronos.com). Once these updates are completed, including the application of correct admin access and service account permissions, we will be able to proceed with the GCP configuration and related activities.

Appreciate your patience and understanding.

Best regards,
Harshini


https://drive.google.com/file/d/1hPbHwTHuIJiKZ51KlSNU0h-VoEw7zi1F/view?usp=sharing

https://viewer.diagrams.net/?tags=%7B%7D&lightbox=1&highlight=0000ff&edit=_blank&layers=1&nav=1&dark=auto#G1hPbHwTHuIJiKZ51KlSNU0h-VoEw7zi1F


Key Milestones (for this period)
Key Milestones	Target Completion Date	% Complete	Comments
Kickoff & Overview Meeting with Tunnel View Systems	[Enter Date]	100%	Current system and flow explained by Tunnel View team.
Design & Cost Estimation Preparation	[Enter Date]	40%	Initial draft in progress; awaiting compute & storage requirements.
Minimum Compute & Storage Requirement Gathering	[Enter Date]	10%	Pending inputs from Tunnel View team.
Network Diagram Design Draft	[Enter Date]	30%	Will be completed before next team discussion.
Review Pending Concerns with Team	[Next Meeting Date]	0%	Will be discussed in upcoming meeting.

🟢 Highlights (enter this in the “Highlights” section of the template)
Conducted a detailed overview meeting with Tunnel View Systems; gained insights into current application flow and architecture.

Initiated design planning and resource cost estimation.

Waiting on minimum compute and storage requirements to finalize design and cost.

Planning to have the draft of the network design diagram ready before the next sync-up.

Identified a few technical and integration concerns – to be discussed in the next meeting.


aws ec2 describe-instances \
  --filters "Name=instance-state-name,Values=stopped" \
  --query "Reservations[*].Instances[*].[InstanceId,InstanceType,PlatformDetails]" \
  --output json | jq -r '.[][] | @csv' > ec2_instances.csv


  ================================
  Hi [Team/Project Owner],

I have a few concerns and clarifications regarding the Tunnel View project architecture. To help us plan and provision the infrastructure appropriately, could you please provide detailed responses to the following points:

1. Storage Requirements
What is the minimum required blob storage size?

Do you require direct access to Blob Storage for any applications or users?

2. Virtual Machine (VM) Specifications
What is the expected VM capacity (vCPUs, RAM, disk)?

How many VMs will be required initially?

Do you require High Availability (HA) setup or scaling?

Are there any specific software tools that need to be installed on the VMs?

3. Data Ingestion and Processing
How frequently is data uploaded to the system?

How often is data processed?

Is data processed in real-time, near real-time, or batch mode?

4. Database Requirements
Do you need a database (e.g., PostgreSQL)?

If yes, what kind of data will be stored?

What is the estimated size and IOPS requirement?

5. Caching Layer
Do you need a caching mechanism (e.g., Redis, Memcached)?

If yes, what will be cached, and how frequently is it accessed?

6. Access Patterns
How will users or applications access processed data?

Through an API, portal, direct file access, etc.?

 VM availability — does the virtual machine need to be running all the time, or is it enough for it to start only when a specific job or task needs to run?





 ==================================

 Scope:
Tunnel View Modernization is a critical initiative to enhance the MTA's in-house application responsible for capturing and analyzing subway infrastructure visuals using onboard Ladybug Camera Systems. These cameras generate raw video (PGR) and telemetry logs (LDS), which are securely transferred from on-premises to Azure using SFTP endpoints or VPN/ExpressRoute connections.

The solution leverages Azure-native services — including Azure Blob Storage, File Storage (via Private Endpoints), Azure Functions, VM Scale Sets, ArcPy scripting, SQL Databases, and Power BI — to build a secure and scalable data processing pipeline. The system ensures all resources are isolated using Azure VNets, subnets with NSGs, private DNS zones, and RBAC policies. Monitoring and threat protection are enabled via Azure Monitor and Defender for Cloud.

Desired Outcome:
To design and implement a secure, scalable, and automated pipeline that captures, transfers, processes, and analyzes transit video and telemetry data in real time and historically. This includes:

Enabling private, encrypted transfer of onboard data to Azure.

Processing and transforming raw video and LDS logs into geospatially enriched outputs (JPG, CSV, OIC).

Storing processed outputs in secure Azure Blob and File storage for access by GIS platforms and dashboards.

Integrating analytics and monitoring tools (e.g., Power BI, ArcGIS Pro, Log Analytics) to support operational decision-making.

Minimizing manual intervention through automation and improving the reliability, security, and efficiency of data flows across the system.



aws ec2 describe-instances --filters Name=instance-state-name,Values=stopped --query "Reservations[].Instances[].[InstanceId,State.Name,Tags[?Key=='Name']|[0].Value]" --output table

aws ec2 describe-instances --filters Name=instance-state-name,Values=stopped --query "Reservations[].Instances[].InstanceId" --output text

aws ec2 describe-addresses --query "Addresses[?AssociationId==null].[PublicIp,AllocationId]" --output table


echo "Stopped EC2 Instances (with Name tag)"; aws ec2 describe-instances --filters Name=instance-state-name,Values=stopped --query "Reservations[].Instances[].[InstanceId,State.Name,Tags[?Key=='Name']|[0].Value]" --output table; \
echo "Stopped EC2 Instance IDs Only"; aws ec2 describe-instances --filters Name=instance-state-name,Values=stopped --query "Reservations[].Instances[].InstanceId" --output table; \
echo "Unused Elastic IPs"; aws ec2 describe-addresses --query "Addresses[?AssociationId==null].[PublicIp,AllocationId]" --output table




aws ec2 describe-volumes --filters Name=status,Values=available

aws ec2 describe-instances \
  --filters Name=instance-state-name,Values=stopped \
  --query "Reservations[*].Instances[*].[InstanceId,State.Name,Tags[?Key=='Name']|[0].Value]" \
  --output table

  aws ec2 describe-instances \
  --filters Name=instance-state-name,Values=stopped \
  --query "Reservations[*].Instances[*].InstanceId" \
  --output text

  aws ec2 describe-addresses \
  --query "Addresses[?AssociationId==null].[PublicIp,AllocationId]" \
  --output table

  




  ✅ Non-Disruptive AWS Resources List
1. Monitoring & Logging (Non-Critical by Default)
Resource Type	Notes
CloudWatch Dashboards	Deleting affects UI only, not actual monitoring or metrics
CloudWatch Alarms	Alerting stops, but services continue to run
CloudWatch Metric Filters	Logging continues; just filter/alerts lost
Log Groups (if empty)	Safe if not storing active logs
CloudTrail Trails (if not org-wide)	Disables auditing, but doesn't affect operations

2. Networking (Supporting/Stateless)
Resource Type	Notes
Security Groups (unused)	Deletion has no impact unless attached to a resource
NACLs (unused)	No impact if not associated with subnets
Route53 Hosted Zones (unused/test domains)	No impact if not in use
VPC Endpoints (not used)	Safe if not linked to running workloads

3. IAM & Access (Non-attached)
Resource Type	Notes
IAM Roles (unused)	No impact unless in use by a service
IAM Policies (not attached)	Safe to delete if not bound to any identity/resource
IAM Users (disabled)	Safe if not used for login/programmatic access

4. Automation / Orchestration
Resource Type	Notes
CloudFormation Stacks (test/dev)	Safe if not managing production resources
Step Functions (idle/test)	Safe unless actively orchestrating services
EventBridge Rules (disabled)	No impact unless tied to critical automation
CodeBuild Projects (unused)	Safe if not part of CI/CD pipeline
CodePipeline (not deployed)	Safe if not tied to a production release process

5. Elastic Load Balancer (Stateless)
Resource Type	Notes
ELBs (no targets or traffic)	Safe to delete if not routing production traffic
Target Groups (not registered)	Safe unless bound to an active ALB/NLB

6. EC2 Related Resources
Resource Type	Notes
Key Pairs (unused)	Can delete if not used to SSH into instances
Launch Templates (old/test)	Safe unless referenced by ASGs or new launches
Placement Groups (empty)	No disruption if no instance is using them
Snapshots (manual/test)	Non-critical unless tied to backups needed for restore


