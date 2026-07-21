# Lessons Learned

## Overview

This project provided practical experience in designing and managing an Azure-based Windows enterprise environment.

The work included planning, deployment, troubleshooting, security, testing, automation and documentation.

## Azure Networking

One important lesson was that subnet planning must be completed before deploying resources.

Address conflicts can occur when subnet ranges overlap or when existing resources already use an address range.

The project also demonstrated why servers, clients and management resources should be separated into different subnets.

## DNS and Active Directory

Active Directory depends heavily on DNS.

The Windows client could not reliably locate the domain until its DNS settings pointed to the domain controller.

This demonstrated that domain join problems are often DNS problems rather than Active Directory problems.

## Remote Administration

Removing the public IP address from DC01 improved security but also changed the administration workflow.

The environment required a jump-host approach:

```text
Administrator laptop
        ↓
CLIENT01
        ↓
DC01
