# Windows Domain Environment

## Overview

A Windows domain environment was deployed for Nordic IT Solutions in Microsoft Azure.

The environment currently consists of:

| System | Purpose | Private IP |
|---|---|---|
| DC01 | Active Directory, DNS and file services | 10.0.0.4 |
| CLIENT01 | Domain-joined Windows 11 client | 10.0.1.4 |

## Active Directory

| Property | Value |
|---|---|
| Forest | corp.nordicit.local |
| Domain | corp.nordicit.local |
| NetBIOS name | NORDICIT |
| Domain controller | DC01 |
| Global Catalog | Enabled |
| DNS server | 10.0.0.4 |

The ADWS, DNS and NTDS services were verified as running automatically.

## Organizational Units

The following organizational structure was created:

- Nordic IT Solutions
  - IT
  - HR
  - Finance
  - Sales
  - Management
  - Consultants
  - Users
  - Computers
  - Servers

## Security Groups

Global department groups:

- GG-IT
- GG-HR
- GG-Finance
- GG-Sales
- GG-Management
- GG-Consultants

Domain-local file permission groups:

- DL-IT-Modify
- DL-HR-Modify
- DL-Finance-Modify
- DL-Sales-Modify
- DL-Management-Modify
- DL-Consultants-Modify

The permission design follows the AGDLP model:

User account → Global group → Domain-local group → Permission

## Test Users

One enabled test user was created for each department:

| User | Department | Group |
|---|---|---|
| Anna Andersson | IT | GG-IT |
| Erik Eriksson | HR | GG-HR |
| Sara Svensson | Finance | GG-Finance |
| Johan Johansson | Sales | GG-Sales |
| Maria Nilsson | Management | GG-Management |
| David Karlsson | Consultants | GG-Consultants |

## File Services

Hidden SMB shares were created for every department:

- `\\DC01\IT$`
- `\\DC01\HR$`
- `\\DC01\Finance$`
- `\\DC01\Sales$`
- `\\DC01\Management$`
- `\\DC01\Consultants$`

Access is assigned through the department security groups rather than directly to individual users.

## Domain Client

CLIENT01 was configured to use DC01 as its DNS server and joined to the domain.

Connectivity to the following services was verified:

- DNS
- LDAP on TCP 389
- SMB on TCP 445
- Active Directory domain discovery

## Group Policy

A Group Policy Object named `Client Security Baseline` was linked to the Computers OU.

The policy configures:

- Machine inactivity timeout: 900 seconds
- Windows Firewall enabled for the domain profile

`gpresult` confirmed that CLIENT01 received the policy from DC01.
