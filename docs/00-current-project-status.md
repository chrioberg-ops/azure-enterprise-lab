# Current Project Status

## Overall Status

The technical implementation of the Azure Enterprise Lab is complete for the available Azure subscription and tenant access.

The environment includes a functioning Azure network, Windows domain, domain-joined client, department file services, Group Policy, Azure Backup, Azure Monitor, security hardening and PowerShell automation.

Microsoft Entra ID and Microsoft Intune were investigated but could not be implemented because the available account is an external B2B user without the required tenant roles or licenses.

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
| PowerShell automation | Complete |
| Network diagram | Complete |
| System architecture diagram | Complete |
| UML sequence diagram | Complete |
| Microsoft Entra ID and Intune | Not implemented – documented limitation |

## Verified Tests

- CLIENT01 resolves the Active Directory domain through DC01.
- LDAP and SMB connectivity work between the client and server subnets.
- A department user can access the correct file share.
- The same user is denied access to another department's share.
- CLIENT01 receives the Client Security Baseline GPO.
- Azure Backup completed successfully.
- An application-consistent recovery point exists.
- Azure Monitor receives heartbeat, event and performance data.
- DC01 can be administered privately from CLIENT01.
- DC01 no longer has a public IP address.
- PowerShell scripts can be run repeatedly without creating duplicate objects.

## Remaining Work

The remaining work is focused on final documentation and submission:

- Capture the remaining Azure Backup evidence screenshots.
- Capture the remaining Azure Monitor evidence screenshots.
- Capture PowerShell automation evidence screenshots.
- Capture Intune and licensing-limitation evidence screenshots.
- Review all evidence links and filenames.
- Complete the final school report.
- Prepare the presentation.

## Estimated Completion

- Technical implementation: 100 percent for the available environment
- Technical documentation: approximately 85 percent
- Diagrams: 100 percent
- Screenshots and evidence: approximately 65 percent
- Final school submission: approximately 70 percent
