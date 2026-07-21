# Microsoft Intune and Entra ID Licensing Limitation

## Overview

The original project plan included Microsoft Entra ID and Microsoft Intune as part of the hybrid identity and device-management solution for Nordic IT Solutions.

The intended design was to synchronize the Active Directory domain `corp.nordicit.local` with Microsoft Entra ID and manage Windows devices through Microsoft Intune.

During implementation, the available tenant, account roles and licenses were investigated. The result showed that the current Azure account could manage Azure infrastructure resources, but did not have the required Microsoft Entra or Intune permissions and licenses.

Because of this, the practical Intune implementation could not be completed in the available tenant.

---

## Current tenant and account situation

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

## Intune administration test

The Microsoft Intune admin center was opened using the current account.

The Tenant Status page returned:

```text
Error code: 401
Details: No Permission

