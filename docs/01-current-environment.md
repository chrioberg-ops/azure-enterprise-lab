# Current Azure Environment

## Overview

This document describes the Azure resources that existed at the beginning of the Nordic IT Solutions enterprise lab.

## Subscription

The project uses an active Azure subscription managed through Azure CLI from WSL.

## Resource Group

| Property | Value |
|---|---|
| Name | rg-nordicit-lab |
| Region | Sweden Central |
| Purpose | Contains the Azure resources used by the enterprise lab |

## Virtual Network

| Property | Value |
|---|---|
| Name | vn-nordicit-lab |
| Address space | 10.0.0.0/16 |
| Region | Sweden Central |

## Subnets

| Subnet | Address range | Intended purpose |
|---|---|---|
| Server-Subnet | 10.0.0.0/24 | Windows Server, Active Directory, DNS and file services |
| Client-Subnet | 10.0.1.0/24 | Windows client devices |
| Management-Subnet | 10.0.2.0/24 | Administrative and management resources |

## Current Security State

No Network Security Groups were associated with the subnets during the initial inventory.

## Evidence

The exported Azure CLI configuration is stored in:

- `evidence/cli/01-resource-group.json`
- `evidence/cli/02-virtual-network.json`
- `evidence/cli/03-subnets.json`

An exported ARM template is stored in:

- `infra/exported/current-state-arm.json`

## Next Step

Create and associate Network Security Groups for the server, client and management subnets.
