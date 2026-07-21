
### `docs/10-diagrams.md`

```markdown
# Project Diagrams

## Overview

The project includes diagrams to explain the technical design and communication flow of the Azure enterprise environment.

The final documentation will include:

- Network diagram
- System architecture diagram
- UML sequence diagram

## Network Diagram

The network diagram should show:

- Resource group `rg-nordicit-lab`
- Virtual network `vn-nordicit-lab`
- Address space `10.0.0.0/16`
- Server-Subnet `10.0.0.0/24`
- Client-Subnet `10.0.1.0/24`
- Management-Subnet `10.0.2.0/24`
- DC01 at `10.0.0.4`
- CLIENT01 at `10.0.1.4`
- Network Security Groups
- Public RDP access to CLIENT01
- Internal RDP access from CLIENT01 to DC01
- DNS traffic from CLIENT01 to DC01
- No public IP address on DC01

## System Architecture Diagram

The architecture diagram should show:

- Administrator laptop
- Azure subscription
- Resource group
- Virtual network
- Domain controller
- Windows client
- Active Directory
- DNS
- Group Policy
- File shares
- Azure Backup
- Azure Monitor
- Log Analytics Workspace
- PowerShell automation
- GitHub documentation

## UML Sequence Diagram

The UML sequence diagram should describe a typical process such as:

1. Administrator connects to CLIENT01 using RDP.
2. CLIENT01 connects internally to DC01.
3. A domain user signs in.
4. CLIENT01 sends DNS requests to DC01.
5. Active Directory validates the user.
6. Group Policy is applied.
7. The user requests access to a department file share.
8. Security groups and NTFS permissions are evaluated.
9. Access is either allowed or denied.
10. Monitoring data is sent to Azure Monitor.

## Status

The final diagrams are still in progress and will be added during the final documentation phase.
