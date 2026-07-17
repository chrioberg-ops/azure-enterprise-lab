# Current Project Status

## Overall Status

The technical implementation of the Azure Enterprise Lab is largely complete.

The environment currently includes a functioning Azure network, Windows domain, domain-joined client, department file services, Group Policy, monitoring, backup and security hardening.

## Implemented Environment

| Component | Status |
|---|---|
| Azure Resource Group | Complete |
| Virtual Network | Complete |
| Three subnets | Complete |
| Network Security Groups | Complete |
| Windows Server DC01 | Complete |
| Active Directory Domain Services | Complete |
| DNS | Complete |
| Organizational Units | Complete |
| Users and security groups | Complete |
| Windows 11 CLIENT01 | Complete |
| Domain join | Complete |
| Department file shares | Complete |
| AGDLP permissions | Complete |
| Group Policy | Complete |
| Azure Backup | Complete |
| Recovery point validation | Complete |
| Azure Monitor | Complete |
| Log Analytics | Complete |
| CPU metric alert | Complete |
| DC01 network hardening | Complete |

## Verified Tests

- CLIENT01 resolves the Active Directory domain through DC01.
- LDAP and SMB connectivity work between the client and server subnets.
- A department user can access the correct file share.
- The same user is denied access to another department's share.
- The client receives the Client Security Baseline GPO.
- Azure Backup completed successfully.
- An application-consistent recovery point exists.
- Azure Monitor receives heartbeat, event and performance data.
- DC01 can be administered privately from CLIENT01.
- DC01 no longer has a public IP address.

## Remaining Work

The main remaining work is documentation rather than core infrastructure:

- Create reusable PowerShell scripts.
- Produce final network and architecture diagrams.
- Capture clean screenshots.
- Review all evidence files.
- Complete the school report.
- Prepare the presentation.
- Decide whether Entra ID and Intune can be demonstrated with the available licensing.

## Estimated Completion

- Technical implementation: approximately 90 percent
- Technical documentation: approximately 70 percent
- Diagrams and screenshots: approximately 25 percent
- Final school submission: approximately 35 percent
