# Azure Backup

## Purpose

Azure Backup protects the domain controller VM against accidental deletion, corruption and configuration failure.

## Configuration

| Property | Value |
|---|---|
| Recovery Services vault | rsv-nordicit-lab |
| Region | Sweden Central |
| Protected VM | vm-dc01 |
| Storage redundancy | Locally Redundant |
| Soft delete | Enabled |
| Backup policy | DefaultPolicy |

## Validation

The first manual backup completed successfully.

| Check | Result |
|---|---|
| Protection state | Protected |
| Health status | Passed |
| Last backup status | Completed |
| Recovery point created | Yes |

## Result

**PASS**

DC01 is protected by Azure Backup and has a completed recovery point.
