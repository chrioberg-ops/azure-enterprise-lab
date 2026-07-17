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

## Recovery Point Validation

The available recovery points for DC01 were listed through Azure CLI.

A recovery point was successfully found with the following properties:

| Property | Value |
|---|---|
| Protected VM | vm-dc01 |
| Recovery point available | Yes |
| Recovery point type | AppConsistent |
| Recovery point time | 2026-07-17 06:40 UTC |

An application-consistent recovery point helps preserve the state of applications and services during backup.

A full restore was not performed because it would create additional Azure resources and cost. The recovery point was instead verified as available for restoration.

## Recovery Point Test Result

**PASS**
