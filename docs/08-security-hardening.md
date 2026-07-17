# Security Hardening

## Purpose

The initial lab deployment used temporary public RDP access to configure DC01.

After the internal administration path was verified, the direct internet exposure was removed.

## Internal Administration Path

Administrative access now follows this path:

`Administrator workstation → CLIENT01 → DC01`

CLIENT01 connects to DC01 over the private Azure network.

| Source | Destination | Protocol | Port |
|---|---|---|---|
| CLIENT01 – 10.0.1.4 | DC01 – 10.0.0.4 | TCP | 3389 |
| Management-Subnet – 10.0.2.0/24 | Server-Subnet – 10.0.0.0/24 | TCP | 3389 |

## Changes Implemented

- Verified private RDP from CLIENT01 to DC01.
- Removed the temporary home-IP RDP rule.
- Detached the public IP address from DC01.
- Deleted the unused `pip-dc01` resource.
- Retained the static private address `10.0.0.4`.

## Validation

| Check | Result |
|---|---|
| Private RDP from CLIENT01 | PASS |
| DC01 private IP retained | PASS |
| Public IP attached to DC01 | No |
| Temporary public RDP rule present | No |
| Public IP resource retained | No |

## Result

**PASS**

DC01 is no longer directly exposed to the internet through Remote Desktop.
