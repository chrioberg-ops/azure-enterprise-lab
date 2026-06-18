device# Azure Enterprise Lab

## Project Overview

Azure Enterprise Lab is a vocational graduation project focused on designing, implementing, securing, and documenting a modern enterprise IT environment using Microsoft Azure and Microsoft server technologies.

The project is based on a fictional company called **Nordic IT Solutions AB**, a growing IT consulting company with approximately 50 employees working both on-site and remotely.

The purpose of the project is to demonstrate practical knowledge in cloud infrastructure, identity management, server administration, device management, security, automation, monitoring, backup, and technical documentation.

The project will simulate how a system administrator can build and manage a secure enterprise environment that supports both office-based users and remote employees.

---

## Business Scenario

Nordic IT Solutions AB is expanding and needs a modern IT environment that can support centralized administration, secure user access, device management, monitoring, backup, and remote work.

The company currently needs a scalable infrastructure where users, computers, servers, security policies, and administrative tasks can be managed in a structured way.

As the System Administrator, the task is to design and implement a secure Azure-based enterprise lab environment that reflects how a small or medium-sized company could manage its IT infrastructure.

The environment must support:

* Centralized user and computer management
* Secure authentication and access control
* Remote work capabilities
* Windows Server administration
* Active Directory management
* Microsoft Entra ID integration
* Device management with Microsoft Intune
* Network segmentation and security rules
* Monitoring and logging
* Backup and recovery procedures
* Automation of common administrative tasks

---

## Project Goal

The goal of this project is to investigate how Microsoft Azure and Microsoft enterprise technologies can be used to build, secure, automate, and administer a modern IT environment.

The project will show how cloud infrastructure, identity management, device management, security policies, monitoring, and backup can work together in a realistic business scenario.

The final result should be a documented enterprise lab environment that demonstrates practical skills relevant to a network technician or junior system administrator role.

---

## Learning Objectives

The project aims to demonstrate knowledge and practical skills in the following areas:

* Microsoft Azure administration
* Windows Server administration
* Active Directory Domain Services
* Microsoft Entra ID
* Microsoft Intune
* Group Policy management
* Network design and segmentation
* Identity and access management
* Security hardening
* PowerShell automation
* Azure monitoring and logging
* Backup and recovery
* Technical documentation
* Troubleshooting and evaluation

---

## Project Scope

The project will include the design, implementation, configuration, testing, and documentation of an enterprise IT environment.

The implementation will include:

* Azure Resource Groups
* Azure Virtual Networks
* Subnets
* Network Security Groups
* Windows Server virtual machines
* Active Directory Domain Services
* Organizational Units
* Users and groups
* Group Policy Objects
* Active Directory security hardening
* Password and account lockout policies
* Role-based access control
* Microsoft Entra ID
* Microsoft Intune
* Windows device management
* Compliance policies
* PowerShell automation
* Azure Monitor
* Log collection
* Azure Backup
* Recovery testing
* Final technical documentation

The project will focus on practical implementation and documentation rather than production-scale deployment.

---

## Technologies Used

The following technologies and tools will be used in the project:

* Microsoft Azure
* Azure Resource Groups
* Azure Virtual Networks
* Network Security Groups
* Windows Server
* Active Directory Domain Services
* Microsoft Entra ID
* Microsoft Intune
* Group Policy Management
* PowerShell
* Azure Monitor
* Azure Backup
* GitHub
* Draw.io or similar diagram tool
* Markdown documentation

---

## Environment Design

The lab environment will be built in Microsoft Azure and designed to represent a small enterprise network.

The environment will include:

* One Azure Resource Group for organizing project resources
* One Virtual Network for the lab environment
* Separate subnets for servers and clients
* Network Security Groups to control inbound and outbound traffic
* A Windows Server virtual machine used as a domain controller
* Active Directory Domain Services for centralized identity management
* Test users, groups, and computers
* Group Policies for security and configuration
* Microsoft Intune for endpoint and compliance management
* Azure Monitor for monitoring and logs
* Azure Backup for backup and recovery testing

---

## Network Design

The network will be designed to separate different parts of the environment and improve security.

The network design will include:

* A Virtual Network in Azure
* A server subnet for domain controllers and server resources
* A client subnet for test clients
* Network Security Groups for traffic control
* Restricted Remote Desktop access
* Clear IP address planning
* Documentation of network layout and security rules

The purpose of the network design is to show how Azure networking can be used to create a structured and secure enterprise environment.

---

## Active Directory Design

Active Directory Domain Services will be used to centrally manage users, computers, groups, and policies.

The Active Directory structure will include Organizational Units for different types of objects. This makes the environment easier to manage and allows Group Policies to be applied in a controlled way.

Example Organizational Units:

* Users
* Computers
* Servers
* Administrators
* Service Accounts
* Groups

Users and groups will be created based on the fictional company structure of Nordic IT Solutions AB.

Example departments:

* IT
* Management
* Finance
* Sales
* Support
* Consultants

Security groups will be used to control access based on roles and responsibilities.

---

## Active Directory Security

Security will be an important part of the Active Directory configuration.

The Active Directory environment will be configured using basic security principles that are common in real enterprise environments.

The security configuration will include:

* Separate standard user accounts and administrator accounts
* Least privilege access for users and administrators
* Role-based security groups
* Strong password policy
* Account lockout policy
* Restricted Remote Desktop access
* Limited local administrator permissions
* Group Policy security settings
* Disabled guest accounts
* Documentation of privileged accounts
* Review of group memberships
* Separation between normal users and administrative users
* Clear naming standards for users, groups, and computers

The purpose of these settings is to reduce unnecessary access, improve account security, and make the environment easier to manage and audit.

---

## Group Policy

Group Policy will be used to manage security and configuration settings for users and computers in the Active Directory domain.

Group Policies may include:

* Password policy
* Account lockout policy
* Windows Firewall settings
* Desktop and user restrictions
* Drive mapping
* Security settings for Windows clients
* Remote Desktop restrictions
* Local administrator restrictions
* Automatic screen lock
* Basic hardening of Windows settings

The Group Policy configuration will be documented and tested to confirm that the correct settings are applied to the correct users and computers.

---

## Microsoft Entra ID

Microsoft Entra ID will be included to demonstrate cloud-based identity management.

The project will describe how Entra ID can be used together with Microsoft cloud services to manage users, authentication, and access.

The Entra ID section will include:

* Overview of Entra ID
* User and group management
* Identity security concepts
* Multi-factor authentication concept
* Relationship between Active Directory and Entra ID
* Cloud identity management documentation

If possible within the lab environment, selected identity features will be tested and documented.

---

## Microsoft Intune

Microsoft Intune will be used to demonstrate modern device management.

The Intune section will focus on how organizations can manage Windows devices, apply compliance settings, and improve endpoint security.

The Intune configuration may include:

* Device enrollment
* Compliance policies
* Configuration profiles
* Security baselines
* Windows update settings
* Endpoint protection settings
* Device inventory
* Documentation of managed devices

The purpose of this part is to show how cloud-based device management can support both office-based and remote users.

---

## PowerShell Automation

PowerShell will be used to automate common administrative tasks.

Automation is important because it reduces manual work, improves consistency, and lowers the risk of human error. PowerShell scripts can help administrators perform repetitive tasks more efficiently and reliably.

Possible PowerShell tasks include:

* Creating users
* Creating groups
* Creating Organizational Units
* Adding users to groups
* Exporting user or group information
* Checking system information
* Basic server administration tasks
* Documentation support

Scripts will be stored in the `scripts/` folder and documented so that their purpose and usage are clear.

---

## Monitoring and Logging

Azure Monitor will be used to demonstrate monitoring and logging in the Azure environment.

Monitoring is important because administrators need visibility into system health, performance, and possible problems.

The monitoring section may include:

* Azure Monitor overview
* Monitoring virtual machines
* Reviewing activity logs
* Checking performance metrics
* Basic alerting concepts
* Log collection
* Documentation of monitoring results

The goal is to show how monitoring can help detect issues and support troubleshooting.

---

## Backup and Recovery

Azure Backup will be used to demonstrate backup and recovery procedures.

Backup is important because systems can fail, data can be deleted, and users can somehow break things that should not be breakable. Such is the eternal curse of IT.

The backup section will include:

* Azure Backup configuration
* Backup policy documentation
* Backup of selected virtual machines
* Recovery Services Vault
* Test restore procedure
* Documentation of recovery results

The purpose is to show that backup is not complete until recovery has been tested.

---

## Security Focus

Security will be included throughout the project, not treated as a separate afterthought.

Security areas in the project include:

* Network Security Groups
* Restricted management access
* Active Directory hardening
* Least privilege access
* Password and account lockout policies
* Role-based access control
* Group Policy security settings
* Device compliance policies
* Monitoring and logging
* Backup and recovery
* Documentation of security decisions

The project will show how basic security controls can be applied in an enterprise-style Azure environment.

---

## Project Roadmap

### Phase 1 – Planning

* Define business requirements
* Define project goals
* Create company scenario
* Design initial network architecture
* Plan documentation structure
* Create GitHub repository

### Phase 2 – Azure Infrastructure

* Create Azure Resource Group
* Create Virtual Network
* Create subnets
* Configure Network Security Groups
* Deploy Windows Server virtual machine
* Document Azure resources
* Take screenshots of important configuration steps

### Phase 3 – Identity Management

* Deploy Active Directory Domain Services
* Configure the domain controller
* Create the Active Directory domain
* Create Organizational Units
* Create users and groups
* Create administrator accounts
* Configure role-based access
* Apply least privilege principles
* Document the Active Directory structure

### Phase 4 – Group Policy and AD Security

* Configure password policy
* Configure account lockout policy
* Configure Windows Firewall settings
* Restrict Remote Desktop access
* Apply user and computer policies
* Test Group Policy application
* Document all Group Policy settings
* Review basic Active Directory security settings

### Phase 5 – Microsoft Entra ID and Intune

* Configure Microsoft Entra ID basics
* Create or review cloud users and groups
* Configure Intune basics
* Enroll Windows device if possible
* Create compliance policies
* Create configuration profiles
* Document device management settings

### Phase 6 – PowerShell Automation

* Create PowerShell scripts for administration
* Automate user or group creation
* Automate reporting tasks
* Test scripts in the lab environment
* Document script purpose and usage

### Phase 7 – Monitoring and Backup

* Configure Azure Monitor
* Review activity logs and metrics
* Configure Azure Backup
* Create backup policy
* Run backup test
* Test recovery procedure
* Document monitoring and recovery results

### Phase 8 – Final Documentation and Evaluation

* Complete all documentation
* Add screenshots
* Review project goals
* Write lessons learned
* Evaluate what worked well
* Describe problems and solutions
* Suggest future improvements
* Prepare final submission

---

## Current Progress

* [x] Project Planning
* [ ] Azure Infrastructure
* [ ] Network Design
* [ ] Windows Server Deployment
* [ ] Active Directory
* [ ] Active Directory Security
* [ ] Group Policy
* [ ] Microsoft Entra ID
* [ ] Microsoft Intune
* [ ] PowerShell Automation
* [ ] Monitoring
* [ ] Backup and Recovery
* [ ] Final Documentation

---

## Repository Structure

```text
azure-enterprise-lab/

├── README.md
├── docs/
│   ├── 01-project-plan.md
│   ├── 02-company-scenario.md
│   ├── 03-network-design.md
│   ├── 04-active-directory.md
│   ├── 05-active-directory-security.md
│   ├── 06-group-policy.md
│   ├── 07-entra-id.md
│   ├── 08-intune.md
│   ├── 09-automation.md
│   ├── 10-monitoring.md
│   ├── 11-backup.md
│   ├── 12-security-hardening.md
│   └── 13-lessons-learned.md
│
├── diagrams/
│   └── network-diagram.drawio
│
├── screenshots/
│
└── scripts/
```

---

## Documentation Plan

The documentation will describe both what was configured and why it was configured.

Each major part of the project will include:

* Purpose
* Configuration steps
* Screenshots
* Explanation of important settings
* Testing
* Results
* Problems and solutions
* Security considerations

This approach helps demonstrate practical knowledge and provides clear documentation of the implementation, testing, and configuration decisions made throughout the project.

---

## Expected Result

At the end of the project, the lab should include a working and documented Azure enterprise environment with:

* Azure infrastructure
* Virtual network design
* Windows Server virtual machine
* Active Directory domain
* Users, groups, and Organizational Units
* Group Policies
* Basic Active Directory security hardening
* Microsoft Entra ID documentation
* Microsoft Intune configuration or design
* PowerShell automation scripts
* Monitoring configuration
* Backup and recovery testing
* Screenshots and final documentation

The final project should demonstrate that the environment has been planned, implemented, secured, tested, and evaluated.

---

## Limitations

This project is a lab environment and not a full production environment.

Some features may be simplified due to licensing, cost, time, or access limitations.

The focus is on demonstrating understanding and practical ability, not building a complete enterprise system for real production use.

---

## Future Improvements

Possible future improvements include:

* Hybrid identity with Microsoft Entra Connect
* Multi-factor authentication enforcement
* Conditional Access policies
* More advanced Intune security baselines
* Defender for Endpoint integration
* More advanced PowerShell automation
* More detailed logging and alerting
* Additional backup scenarios
* Disaster recovery planning
* Cost analysis for Azure resources
* Infrastructure as Code using Terraform or Bicep

---

## Author

Christoffer Öberg

Vocational Education – Network Technician

2026
