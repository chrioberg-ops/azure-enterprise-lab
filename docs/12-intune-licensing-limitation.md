# Microsoft Intune and Entra ID Licensing Limitation

## Overview

The original project plan included Microsoft Entra ID and Microsoft Intune as part of the hybrid identity and device-management solution for Nordic IT Solutions.

The intended design was to synchronize the Active Directory domain `corp.nordicit.local` with Microsoft Entra ID and manage Windows devices through Microsoft Intune.

During implementation, the available tenant, account roles and licenses were investigated. The result showed that the current Azure account could manage Azure infrastructure resources but did not have the required Microsoft Entra or Intune permissions and licenses.

Because of this, the practical Intune implementation could not be completed in the available tenant.

---

## Current Tenant and Account Situation

The Azure subscription is connected to a Microsoft Entra tenant named `Standardkatalog`.

The account used for the project is represented in the tenant as an external Microsoft Entra B2B account. This was confirmed by:

- The user principal name containing `#EXT#`
- The account being marked as external
- No licenses being assigned to the account

The account could manage Azure resources such as:

- Virtual machines
- Virtual networks
- Network Security Groups
- Recovery Services Vault
- Azure Monitor
- Log Analytics Workspace

However, Azure subscription permissions and Microsoft Entra tenant permissions are separate authorization systems.

Access to an Azure subscription does not automatically provide permission to:

- Administer Microsoft Entra ID
- Assign Microsoft 365 or Intune licenses
- Configure Microsoft Intune
- Enroll devices into Intune
- Configure automatic MDM enrollment
- Create internal tenant users
- Create additional workforce tenants

---

## Intune Administration Test

The Microsoft Intune admin center was opened using the current account.

The Tenant Status page returned:

```text
Error code: 401
Details: No Permission
```

This confirmed that the account did not have permission to administer Microsoft Intune in the connected tenant.

## Licensing Limitation

Microsoft Intune requires an appropriate license and an account with the necessary tenant roles.

The available external B2B account had:

- No assigned Microsoft 365 or Intune license
- No Intune administrative role
- No authority to assign tenant licenses
- No authority to create internal workforce users

## Project Decision

A simulated or misleading Intune implementation was not included.

Instead, the limitation was documented as a real-world dependency involving:

- Tenant ownership
- Microsoft Entra roles
- Microsoft Intune licensing
- Device enrollment authority

## Evidence

### External B2B Account

The project account is represented as an external B2B user in the connected Microsoft Entra tenant.

![External B2B Account](../evidence/09-intune-limitation/01-external-b2b-account.png)

### No Assigned Licenses

No Microsoft 365 or Intune licenses were assigned to the account.

![No Assigned Licenses](../evidence/09-intune-limitation/02-no-assigned-licenses.png)

### Intune Permission Error

The Microsoft Intune admin center returned a 401 permission error.

![Intune No Permission](../evidence/09-intune-limitation/03-intune-no-permission.png)

### License Access Denied

The account could not access or assign the licenses required for Intune.

![License Access Denied](../evidence/09-intune-limitation/04-license-access-denied.png)

### Workforce Tenant Requirement

A proper implementation would require access to a workforce tenant with appropriate roles and licenses.

![Workforce Tenant Requirement](../evidence/09-intune-limitation/05-workforce-tenant-license-requirement.png)

## Result

**NOT IMPLEMENTED — DOCUMENTED LIMITATION**

The technical design remains valid, but practical implementation was blocked by tenant permissions and licensing rather than by an infrastructure configuration failure.
