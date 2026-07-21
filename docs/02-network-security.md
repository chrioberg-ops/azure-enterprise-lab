# Network Security Design

## Purpose

Network Security Groups are used to control traffic between the subnets in the Nordic IT Solutions Azure environment.

The goal is to reduce unnecessary network access and separate server, client and management traffic.

## Network Security Groups

| NSG | Associated subnet | Purpose |
|---|---|---|
| nsg-server-subnet | Server-Subnet | Protects Windows Server, Active Directory, DNS and file services |
| nsg-client-subnet | Client-Subnet | Protects Windows client resources |
| nsg-management-subnet | Management-Subnet | Protects administrative resources |

## Server Subnet Rules

### Allow RDP from Management Subnet

| Property | Value |
|---|---|
| Rule name | Allow-RDP-From-Management |
| Priority | 100 |
| Protocol | TCP |
| Source | 10.0.2.0/24 |
| Destination | 10.0.0.0/24 |
| Destination port | 3389 |
| Action | Allow |

This rule allows administrative systems in the management subnet to connect to servers using Remote Desktop.

RDP is not opened directly from the entire internet.

### Allow DNS from Client Subnet

| Property | Value |
|---|---|
| Rule names | Allow-DNS-From-Clients-UDP and Allow-DNS-From-Clients-TCP |
| Priorities | 110 and 120 |
| Protocols | UDP and TCP |
| Source | 10.0.1.0/24 |
| Destination | 10.0.0.0/24 |
| Destination port | 53 |
| Action | Allow |

These rules allow client devices to use the DNS service hosted in the server subnet.

Both UDP and TCP are allowed because DNS normally uses UDP but can also require TCP.

## Default NSG Rules

Azure automatically includes default NSG rules.

These rules allow traffic inside the virtual network, allow Azure load balancer traffic and deny other inbound traffic.

Custom rules are evaluated before the default rules because they use lower priority numbers.

## Security Considerations

The current configuration follows the principle of least privilege by only allowing traffic that is currently required.

Required Active Directory communication is supported between CLIENT01 and DC01 through the Azure virtual network.

## Validation

The following checks were performed:

- All three Network Security Groups were created successfully.
- Each NSG was associated with the correct subnet.
- Internal RDP access to DC01 was limited to CLIENT01 and the management subnet.
- DNS access was allowed from the client subnet.
- No general inbound RDP rule from the internet was created.

## Evidence

### Server NSG Rules

The server subnet is protected by `nsg-server-subnet`.

The inbound rules allow only the traffic required for administration, DNS, Active Directory and client communication.

![Server NSG Rules](../evidence/02-network-security/01-server-nsg-rules.png)

### Client NSG Rules

The client subnet is protected by `nsg-client-subnet`.

Remote Desktop access to CLIENT01 is limited to specific public source IP addresses using `/32` restrictions.

![Client NSG Rules](../evidence/02-network-security/02-client-nsg-rules.png)

### Internal RDP to DC01

The rule `Allow-RDP-From-CLIENT01` allows internal Remote Desktop traffic from CLIENT01 at `10.0.1.4/32` to DC01 at `10.0.0.4` on TCP port `3389`.

![Internal RDP Rule](../evidence/02-network-security/03-internal-rdp-rule.png)

### Restricted Public RDP to CLIENT01

Public Remote Desktop access to CLIENT01 is restricted to a specific public source IP address with a `/32` prefix.

This is more secure than allowing RDP from any internet address.

![CLIENT01 RDP Source Restriction](../evidence/02-network-security/04-client-rdp-source-restriction.png)

### DC01 Has No Public IP

DC01 only uses the private IP address `10.0.0.4`.

The virtual machine has no public IP address and cannot be reached directly from the internet.

![DC01 No Public IP](../evidence/02-network-security/05-dc01-no-public-ip.png)

## Result

**PASS**

The subnet-level Network Security Groups were created and associated successfully.

