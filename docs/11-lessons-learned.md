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
```

This design reduced the direct internet exposure of the domain controller while preserving administrative access over the private Azure network.

## File Services and Permissions

The AGDLP model made it easier to separate user membership from resource permissions.

Permissions were assigned to domain-local groups instead of directly to individual users. This produced a more scalable and maintainable access-control design.

Testing both authorized and unauthorized access was important. A working file share is not enough unless users are also prevented from accessing resources belonging to other departments.

## Group Policy

Group Policy provided a centralized way to configure security settings on domain-joined clients.

The project demonstrated the importance of linking a GPO to the correct OU and validating the result with `gpresult`.

## Azure Backup and Monitoring

A successful backup job is not enough by itself. The recovery point must also be verified.

Azure Monitor required time before heartbeat, event and performance data appeared in Log Analytics. This showed that cloud monitoring configuration may not produce immediate results.

## Automation

The PowerShell scripts were designed to be idempotent.

Repeated execution validated the existing configuration without creating duplicate users, groups, folders or shares.

This made the scripts safer to use and easier to maintain than commands that assume the environment is always empty.

## Tenant and Licensing Dependencies

Azure subscription access does not automatically provide Microsoft Entra ID or Microsoft Intune administrative permissions.

The Intune part of the original design could not be implemented because the available account was an external B2B user without the required tenant roles and licenses.

Documenting this limitation was more accurate than presenting a simulated implementation as completed work.

## Final Reflection

The project demonstrated that a functioning enterprise environment requires more than deploying virtual machines.

Networking, DNS, identity, permissions, security, backup, monitoring, testing, automation and documentation must work together as one system.
