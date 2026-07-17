# Troubleshooting Log

## TS-001 – VM Size Capacity Restriction

**Problem:** `Standard_B2s` could not be deployed in Sweden Central.

**Error:** `SkuNotAvailable`

**Cause:** Azure reported a regional capacity restriction for the selected VM size.

**Attempted resolution:** `Standard_B2ms` was selected, but the same capacity restriction occurred.

**Final resolution:** `Standard_D2s_v5` was selected and deployed successfully.

**Result:** RESOLVED

---

## TS-002 – Active Directory PowerShell Module Missing

**Problem:** The `New-ADGroup` command was not recognized.

**Cause:** The Active Directory PowerShell module was not available in the current Windows Server installation.

**Resolution:**

    Install-WindowsFeature RSAT-AD-PowerShell
    Import-Module ActiveDirectory

The installation was verified with:

    Get-Command New-ADGroup

**Result:** RESOLVED

---

## TS-003 – Existing Active Directory User Accounts

**Problem:** `New-ADUser` returned the error:

    The specified account already exists

**Cause:** The user accounts had already been partially created during an earlier execution.

**Resolution:**

- Existing users were identified with `Get-ADUser`.
- Passwords were reset.
- The accounts were enabled.
- Group memberships were verified.

**Result:** RESOLVED

---

## TS-004 – Active Directory Users Were Disabled

**Problem:** All department test users showed `Enabled = False`.

**Cause:** The accounts existed but had not been fully activated after the earlier creation attempt.

**Resolution:**

    Set-ADAccountPassword
    Enable-ADAccount
    Set-ADUser -ChangePasswordAtLogon $true

The users were then verified as enabled and not locked out.

**Result:** RESOLVED

---

## TS-005 – Domain User Denied Remote Desktop Logon

**Problem:** The HR test user received the following error:

    The connection was denied because the user account is not authorized for remote login.

**Cause:** The domain user did not have permission to sign in through Remote Desktop on CLIENT01.

**Resolution:**

- Created the security group `GG-Remote-Desktop-Users`.
- Added `erik.eriksson` to the group.
- Added the domain group to the local `Remote Desktop Users` group on CLIENT01.
- Opened a new Remote Desktop session.

**Result:** RESOLVED

---

## TS-006 – Password Change Required Before First Logon

**Problem:** The HR test account was required to change its password before the first Remote Desktop sign-in.

**Cause:** The account property `ChangePasswordAtLogon` was enabled.

**Resolution:**

- Reset the user's password.
- Temporarily disabled the first-logon password change requirement for the test.
- Verified that the account was enabled and the password was not expired.

**Result:** RESOLVED

---

## TS-007 – Administrative Credentials Rejected in UAC

**Problem:** CLIENT01 rejected the local administrator credentials in the existing Remote Desktop session.

**Cause:** The existing session was still running under the domain user's context, and the account name was initially entered in an incorrect format.

**Resolution:**

- Used the local account format `CLIENT01\clientadmin`.
- Opened a new Remote Desktop session as the local administrator.
- Started PowerShell with administrative privileges.

**Result:** RESOLVED

---

## TS-008 – Incorrect RDP Destination Address

**Problem:** Remote Desktop could not initially connect to DC01.

**Cause:** The administrator's public source IP address was entered as the destination instead of the VM's public IP address.

**Resolution:** The correct Azure VM public IP address was used as the RDP destination.

**Result:** RESOLVED

---

## TS-009 – Azure CLI Security Type Typo

**Problem:** VM creation failed because the value below was invalid:

    TrustedLaunc

**Cause:** The final letter was missing from the security type.

**Resolution:** The deployment command was corrected to use:

    --security-type TrustedLaunch

**Result:** RESOLVED

---

## TS-010 – Deprecated Azure CLI Command

**Problem:** `az vm list-sizes` displayed a deprecation warning.

**Cause:** Microsoft is replacing the command with `az vm list-skus`.

**Resolution:** Future VM-size checks were changed to use `az vm list-skus`.

**Result:** RESOLVED

---

## TS-011 – Recovery Services Provider Not Registered

**Problem:** Creation of the Recovery Services vault failed with `MissingSubscriptionRegistration`.

**Cause:** The `Microsoft.RecoveryServices` resource provider was not registered for the subscription.

**Resolution:**

    az provider register --namespace Microsoft.RecoveryServices --wait

The provider status was verified as `Registered`, after which the vault was created successfully.

**Result:** RESOLVED

---

## TS-012 – Invalid Azure Monitor Event Stream

**Problem:** Creation of the Data Collection Rule failed with `InvalidOutputTable`.

**Cause:** The stream `Microsoft-WindowsEvent` attempted to send data to a table that was not available in the Log Analytics workspace.

**Resolution:** The event stream was changed to:

    Microsoft-Event

This caused standard Windows events to be stored in the `Event` table.

**Result:** RESOLVED

---

## TS-013 – Azure Monitor Data Initially Missing

**Problem:** Heartbeat, Event and Perf queries initially returned no results.

**Cause:** Azure Monitor Agent and the Data Collection Rule required additional time before configuration and data ingestion completed.

**Investigation:**

- Verified system-assigned managed identity.
- Verified Azure Monitor Agent extension status.
- Verified DCR creation and association.
- Checked agent processes and local configuration.
- Waited for Azure Monitor ingestion to complete.

**Final result:**

- Heartbeat records received.
- Windows events received.
- Performance counters received.

**Result:** RESOLVED
