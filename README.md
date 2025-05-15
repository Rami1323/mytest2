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
