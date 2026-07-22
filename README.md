# Azure Enterprise Lab

## Project Overview

Azure Enterprise Lab is a vocational graduation project focused on designing, implementing, securing, testing, automating, monitoring and documenting a realistic enterprise IT environment in Microsoft Azure.

The project is based on a fictional company named **Nordic IT Solutions AB**, a Stockholm-based IT consulting company with approximately 50 employees working both on-site and remotely.

The purpose of the project is to demonstrate practical skills relevant to a junior system administrator or network technician role. The environment is designed as a realistic small-business lab rather than a certification exercise or a Microsoft Learn walkthrough.

---

## Business Scenario

Nordic IT Solutions AB is expanding and requires a centrally managed IT environment that can support:

- Centralized user and computer administration
- Secure authentication and access control
- Windows Server administration
- Network segmentation
- Department-based file access
- Remote administration
- Group Policy
- Monitoring and alerting
- Backup and recovery
- PowerShell automation
- Future Microsoft Entra ID and Intune integration

The company has approximately 50 employees divided into the following departments:

- IT
- HR
- Finance
- Sales
- Management
- Consultants

The company uses a hybrid working model. Employees work both from the Stockholm office and remotely.

---

## Project Goal

The goal of this project is to investigate how Microsoft Azure and Microsoft enterprise technologies can be used to build, secure, automate and administer a modern IT environment.

The final environment should demonstrate:

- Secure Azure infrastructure
- Centralized identity management
- Structured network design
- Department-based access control
- Domain-joined Windows clients
- Group Policy management
- File services
- Monitoring and alerting
- Backup and recovery
- PowerShell automation
- Technical testing and documentation

---

## Learning Objectives

The project demonstrates practical knowledge in:

- Microsoft Azure administration
- Azure networking
- Windows Server administration
- Active Directory Domain Services
- DNS
- Organizational Units
- User and group administration
- AGDLP access control
- Group Policy
- File server administration
- NTFS and SMB permissions
- Security hardening
- Azure Backup
- Azure Monitor
- Log Analytics
- PowerShell automation
- Troubleshooting
- Git and GitHub
- Technical documentation

---

## Current Project Status

The core Azure and Windows Server environment has been implemented and tested.

Estimated overall completion:

```text
Approximately 70–75%
```

The main remaining work consists of:

- Final screenshots and evidence review
- Architecture diagram
- Network diagram
- UML sequence diagram
- Final documentation review
- Lessons learned
- Final school report
- Presentation material

Microsoft Entra ID and Microsoft Intune were investigated but could not be implemented because the available account lacked the required tenant ownership, administrative roles and licenses.

---

# Environment Overview

## Azure Resource Group

All Azure resources are organized in:

```text
rg-nordicit-lab
```

The resource group makes it easier to manage:

- Resources
- Permissions
- Monitoring
- Costs
- Cleanup after the project

---

## Azure Region

The environment is deployed in a Swedish Azure region.

The region was selected to provide:

- Low latency for users in Sweden
- Clear geographic placement
- A realistic regional design for a Stockholm-based company

---

## Virtual Network

The Azure virtual network is:

```text
vn-nordicit-lab
```

Address space:

```text
10.0.0.0/16
```

The virtual network provides private communication between Azure resources.

---

## Subnet Design

The network is divided into three subnets:

| Subnet | Address range | Purpose |
|---|---:|---|
| Server-Subnet | `10.0.0.0/24` | Domain controller and server resources |
| Client-Subnet | `10.0.1.0/24` | Domain-joined Windows clients |
| Management-Subnet | `10.0.2.0/24` | Administrative and management resources |

The purpose of segmentation is to separate servers, clients and management traffic.

This improves:

- Security
- Network control
- Troubleshooting
- Future scalability
- Least-privilege network access

---

## Network Security Groups

The following Network Security Groups were created:

```text
nsg-server-subnet
nsg-client-subnet
nsg-management-subnet
```

The NSGs are used to control inbound and outbound traffic between subnets and external networks.

Security decisions include:

- Restricted RDP access
- Private communication between CLIENT01 and DC01
- Removal of direct public RDP access to DC01
- Separate rules for client, server and management networks

---

## Virtual Machines

### Domain Controller

| Property | Value |
|---|---|
| Azure resource name | `vm-dc01` |
| Windows computer name | `DC01` |
| Private IP address | `10.0.0.4` |
| Public IP address | None |
| Subnet | Server-Subnet |
| Main roles | AD DS, DNS and lab file services |

DC01 has no public IP address.

This reduces exposure to internet-based attacks and prevents direct public RDP access.

### Windows Client

| Property | Value |
|---|---|
| Azure resource name | `vm-client01` |
| Windows computer name | `CLIENT01` |
| Private IP address | `10.0.1.4` |
| Subnet | Client-Subnet |
| Main roles | Domain-joined client and temporary jump host |

CLIENT01 is used to test:

- Domain join
- DNS
- Domain authentication
- Group Policy
- File access
- Internal Remote Desktop

---

## Administrative Access Path

Administrative access follows this design:

```text
Administrator laptop
        |
        | RDP over the internet
        v
CLIENT01
        |
        | Internal RDP over the Azure VNet
        v
DC01
```

The internal RDP connection from CLIENT01 to DC01 uses:

```text
10.0.0.4
```

This design is more secure than exposing the domain controller directly to the internet.

---

# Active Directory Domain Services

## Domain

The Active Directory domain is:

```text
corp.nordicit.local
```

NetBIOS name:

```text
NORDICIT
```

DC01 provides:

- Active Directory Domain Services
- DNS
- Global Catalog
- Group Policy management
- Centralized authentication

---

## DNS

CLIENT01 uses the domain controller as its DNS server:

```text
10.0.0.4
```

This is required so that the client can locate:

- The Active Directory domain
- Domain controllers
- LDAP services
- Kerberos services
- Internal DNS records

DNS was tested before and after the domain join.

---

## Organizational Unit Structure

The main Organizational Unit is:

```text
OU=Nordic IT Solutions
```

The following OUs were created:

```text
IT
HR
Finance
Sales
Management
Consultants
Users
Computers
Servers
```

The OU structure is used to:

- Organize users and computers
- Separate departments
- Support Group Policy targeting
- Improve administration
- Prepare the environment for future expansion

---

## Test Users

The following test users were created:

| User | Username | Department | Job title |
|---|---|---|---|
| Anna Andersson | `anna.andersson` | IT | IT Administrator |
| Erik Eriksson | `erik.eriksson` | HR | HR Administrator |
| Sara Svensson | `sara.svensson` | Finance | Finance Administrator |
| Johan Johansson | `johan.johansson` | Sales | Sales Representative |
| Maria Nilsson | `maria.nilsson` | Management | Manager |
| David Karlsson | `david.karlsson` | Consultants | Consultant |

The users are:

- Enabled
- Located in the correct department OU
- Assigned the correct department attribute
- Assigned the correct job title
- Added to the correct department group

---

## Security Groups

Global department groups:

```text
GG-IT
GG-HR
GG-Finance
GG-Sales
GG-Management
GG-Consultants
```

Domain-local permission groups:

```text
DL-IT-Modify
DL-HR-Modify
DL-Finance-Modify
DL-Sales-Modify
DL-Management-Modify
DL-Consultants-Modify
```

Remote Desktop group:

```text
GG-Remote-Desktop-Users
```

---

## AGDLP Permission Model

The project uses the AGDLP model:

```text
Accounts
    ↓
Global Groups
    ↓
Domain Local Groups
    ↓
Permissions
```

Example:

```text
Erik Eriksson
    ↓
GG-HR
    ↓
DL-HR-Modify
    ↓
HR$ file share
```

This design avoids assigning permissions directly to individual users.

Benefits include:

- Easier administration
- Better scalability
- Clearer auditing
- Simplified troubleshooting
- Reduced risk of inconsistent permissions

---

# Windows Client and Domain Join

CLIENT01 was configured to use DC01 as its DNS server and was joined to:

```text
corp.nordicit.local
```

The client was used to verify:

- Domain discovery
- DNS resolution
- Domain join
- Domain user login
- Group Policy application
- File share access
- Internal RDP connectivity

---

# Group Policy

A Group Policy Object named:

```text
Client Security Baseline
```

was created and linked to the computer OU.

Configured settings include:

- Windows Defender Firewall enabled
- Machine inactivity timeout set to 900 seconds
- Centralized computer security settings

The policy was validated using tools such as:

```powershell
gpupdate /force
gpresult
```

The results confirmed that the policy was applied to CLIENT01.

---

# File Services

## Department Folders

The main file share location is:

```text
C:\CompanyShares
```

Department folders:

```text
C:\CompanyShares\IT
C:\CompanyShares\HR
C:\CompanyShares\Finance
C:\CompanyShares\Sales
C:\CompanyShares\Management
C:\CompanyShares\Consultants
```

---

## Hidden SMB Shares

The folders are shared using hidden share names:

```text
IT$
HR$
Finance$
Sales$
Management$
Consultants$
```

Example path:

```text
\\DC01\HR$
```

The dollar sign hides the share from normal network browsing, although it does not replace proper permissions.

---

## NTFS Permissions

Each department folder uses the following permission model:

```text
NT AUTHORITY\SYSTEM           Full Control
BUILTIN\Administrators        Full Control
NORDICIT\DL-Department-Modify Modify
```

Example:

```text
NORDICIT\DL-HR-Modify
```

has NTFS Modify access to:

```text
C:\CompanyShares\HR
```

---

## SMB Permissions

Each department permission group has SMB Change access to its department share.

Example:

```text
NORDICIT\DL-HR-Modify
```

has Change access to:

```text
HR$
```

Effective access is determined by the combination of SMB and NTFS permissions.

---

## Access-Based Enumeration

All department shares use:

```text
FolderEnumerationMode: AccessBased
```

Access-Based Enumeration helps hide files and folders that a user does not have permission to access.

---

## Offline Caching

All department shares use:

```text
CachingMode: None
```

Offline caching was disabled to avoid uncontrolled offline copies of department data in the lab design.

---

## File Access Testing

Access testing confirmed that:

- An HR user could access the HR share
- The HR user could create and modify files
- A Finance user was denied access to the HR share
- The AGDLP permission model worked as intended
- NTFS and SMB permissions were correctly combined

---

# Azure Backup

A Recovery Services Vault was created:

```text
rsv-nordicit-lab
```

Backup configuration includes:

- Locally Redundant Storage
- Soft Delete enabled
- Protection for `vm-dc01`
- Successful initial backup
- Application-consistent recovery point

The backup validation confirmed that DC01 was protected and that a recovery point was available.

A full restore test has not yet been completed and is documented as a future improvement.

---

# Azure Monitor and Log Analytics

A Log Analytics Workspace was created:

```text
law-nordicit-lab
```

Configuration includes:

```text
Retention: 30 days
Pricing tier: PerGB2018
```

Azure Monitor Agent was installed on DC01.

A Data Collection Rule was created:

```text
dcr-dc01-monitoring
```

Collected data includes:

- Heartbeat
- Windows Event Logs
- Performance counters

The following data types were verified in Log Analytics:

```text
Heartbeat
Event
Perf
```

---

## Alerting

A CPU alert was created:

```text
alert-dc01-high-cpu
```

The alert demonstrates how Azure Monitor can be used to detect performance problems.

In a production environment, alerts would normally be connected to an Action Group for:

- Email
- SMS
- Webhooks
- IT service management systems

---

# Security Hardening

Security was included throughout the project.

Implemented controls include:

- Removal of the public IP address from DC01
- Restricted RDP access
- Private communication between CLIENT01 and DC01
- Network segmentation
- Network Security Groups
- Windows Firewall through Group Policy
- Department-based access control
- AGDLP permissions
- Hidden SMB shares
- Access-Based Enumeration
- Disabled offline caching
- Azure Backup
- Azure Monitor
- Centralized identity management

The project uses multiple security layers instead of relying on a single control.

---

# PowerShell Automation

Three idempotent PowerShell scripts were created.

Idempotent means that the scripts can be run repeatedly without creating duplicate objects or performing unnecessary changes.

---

## Active Directory Structure Script

File:

```text
scripts/powershell/New-NordicITActiveDirectoryStructure.ps1
```

The script manages:

- Main Organizational Unit
- Department OUs
- Users, Computers and Servers OUs
- Global security groups
- Domain-local permission groups
- AGDLP group nesting

Test result:

```text
TC-PS-001 – PASS
```

---

## Department File Share Script

File:

```text
scripts/powershell/New-NordicITDepartmentShares.ps1
```

The script manages:

- Department folders
- Hidden SMB shares
- NTFS permissions
- SMB permissions
- Access-Based Enumeration validation
- Offline caching configuration
- File server validation

Test result:

```text
TC-PS-002 – PASS
```

---

## Active Directory User Script

File:

```text
scripts/powershell/New-NordicITUsers.ps1
```

The script manages:

- User creation
- Account status
- OU placement
- Department attributes
- Job titles
- Department group memberships

Test result:

```text
TC-PS-003 – PASS
```

---

# Microsoft Entra ID and Intune Limitation

Microsoft Entra ID integration and Microsoft Intune were included in the original project scope.

During implementation, the tenant and account were investigated.

The investigation showed that:

- The Azure account was represented as an external B2B user
- The account user principal name contained `#EXT#`
- The account had no assigned Intune licenses
- The account lacked suitable Entra and Intune administrative roles
- The Intune Tenant Status page returned `401 – No Permission`
- Creating another Workforce tenant required additional paid licensing and tenant permissions

Azure subscription permissions, Microsoft Entra tenant roles and Microsoft Intune licensing are separate requirements.

The account could manage Azure infrastructure but could not administer the Microsoft Entra and Intune tenant.

Because of this, Intune was documented as a planned production extension but was not deployed.

Detailed documentation:

```text
docs/12-intune-licensing-limitation.md
```

---

## Planned Production Design for Entra ID and Intune

In a production environment, Nordic IT Solutions would use:

1. A company-controlled Microsoft Entra tenant
2. Internal administrator accounts
3. Least-privilege Entra and Intune roles
4. Valid Intune licenses
5. Microsoft Entra Connect Sync or Cloud Sync
6. User synchronization from Active Directory
7. Automatic Windows MDM enrollment
8. Intune compliance policies
9. Windows configuration profiles
10. Security baselines
11. Windows Update policies
12. Conditional Access where licensing permits

The existing users in:

```text
corp.nordicit.local
```

would be synchronized to the company-controlled tenant.

---

# Testing

Testing performed in the lab includes:

- Azure network connectivity
- DNS resolution
- Domain discovery
- Domain join
- Domain user authentication
- Internal RDP connectivity
- Group Policy application
- Authorized file share access
- Unauthorized file share denial
- NTFS permission validation
- SMB permission validation
- Access-Based Enumeration validation
- Backup completion
- Recovery point validation
- Azure Monitor Heartbeat
- Windows Event collection
- Performance data collection
- Active Directory automation testing
- File share automation testing
- User automation testing
- Repeated idempotency testing

Test results are documented in:

```text
docs/04-test-results.md
```

---

# Troubleshooting

The project included troubleshooting of:

- Azure subnet address conflicts
- DNS and domain join issues
- RDP access
- Network Security Group rules
- Public and private IP access
- Nested Remote Desktop sessions
- SMB and NTFS permissions
- Group membership validation
- PowerShell script idempotency
- Azure monitoring data collection
- Tenant and Intune permission errors

Troubleshooting steps and results are documented in:

```text
docs/05-troubleshooting.md
```

---

# Repository Structure

```text
azure-enterprise-lab/
├── README.md
├── docs/
│   ├── 00-current-project-status.md
│   ├── 01-project-plan.md
│   ├── 03-domain-environment.md
│   ├── 04-test-results.md
│   ├── 05-troubleshooting.md
│   ├── 06-azure-backup.md
│   ├── 07-azure-monitor.md
│   ├── 08-security-hardening.md
│   └── 12-intune-licensing-limitation.md
├── diagrams/
├── evidence/
└── scripts/
    └── powershell/
        ├── New-NordicITActiveDirectoryStructure.ps1
        ├── New-NordicITDepartmentShares.ps1
        └── New-NordicITUsers.ps1
```

The structure may be adjusted during the final documentation phase.

---

# Project Roadmap

## Phase 1 – Planning

Completed:

- Business scenario
- Project goals
- Initial architecture planning
- GitHub repository
- Documentation structure

## Phase 2 – Azure Infrastructure

Completed:

- Resource group
- Virtual network
- Subnets
- Network Security Groups
- Windows Server VM
- Windows client VM

## Phase 3 – Active Directory

Completed:

- AD DS installation
- Domain creation
- DNS
- OU structure
- Users
- Groups
- AGDLP model
- Domain join

## Phase 4 – Security and Group Policy

Completed:

- Group Policy baseline
- Windows Firewall policy
- Machine inactivity timeout
- Restricted RDP
- Removal of public IP from DC01
- File access control

## Phase 5 – File Services

Completed:

- Department folders
- SMB shares
- NTFS permissions
- SMB permissions
- Access testing
- Access-Based Enumeration
- Caching configuration

## Phase 6 – PowerShell Automation

Completed:

- AD structure automation
- File share automation
- User automation
- Idempotency testing

## Phase 7 – Monitoring and Backup

Completed:

- Recovery Services Vault
- Backup policy
- Initial backup
- Recovery point validation
- Log Analytics
- Azure Monitor Agent
- Data Collection Rule
- Heartbeat, Event and Perf validation
- CPU alert

## Phase 8 – Entra ID and Intune

Investigated but not implemented because of:

- External B2B account
- Missing tenant-level roles
- Missing Intune licenses
- Tenant creation restrictions

## Phase 9 – Final Delivery

In progress:

- Final screenshots
- Evidence review
- Architecture diagram
- Network diagram
- UML sequence diagram
- Lessons learned
- Final report
- Presentation

---

# Known Limitations

This is a lab environment and not a complete production deployment.

Known limitations include:

- One domain controller
- File services hosted on the domain controller
- No redundant DNS server
- No second domain controller
- No production VPN implementation
- No Entra Connect synchronization
- No Intune enrollment
- No Conditional Access
- No complete disaster recovery environment
- No full backup restore test
- Limited number of users and devices
- Temporary use of CLIENT01 as a jump host

These limitations were accepted because of:

- Project scope
- Cost
- Licensing
- Available time
- Tenant access restrictions

---

# Future Improvements

Possible future improvements include:

- Deploying a second domain controller
- Deploying a dedicated file server
- Implementing Azure VPN Gateway
- Implementing Microsoft Entra Connect or Cloud Sync
- Enrolling clients in Microsoft Intune
- Enforcing multi-factor authentication
- Implementing Conditional Access
- Integrating Microsoft Defender for Endpoint
- Adding more monitoring alerts
- Testing a complete VM restore
- Creating a disaster recovery plan
- Performing Azure cost analysis
- Implementing Infrastructure as Code with Bicep or Terraform
- Adding automated reporting scripts

---

# Documentation Approach

Each major project area is documented with:

- Purpose
- Design decisions
- Configuration
- Testing
- Results
- Problems and solutions
- Security considerations
- Future improvements

This approach demonstrates both practical implementation and understanding of why each component was used.

---

# Expected Final Result

The final project should contain:

- A working Azure network
- A Windows Server domain controller
- A domain-joined Windows client
- Active Directory users, groups and OUs
- Department file shares
- Group Policy
- Security hardening
- Azure Backup
- Azure Monitor
- PowerShell automation
- Testing and troubleshooting documentation
- Architecture and network diagrams
- Final screenshots and evidence
- Final project evaluation
- Presentation material

---

# Author

**Christoffer Öberg**

Vocational Education – Network Technician

2026

