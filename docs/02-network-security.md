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

Additional Active Directory ports will be added when the domain controller and Windows client are deployed.

## Validation

The following checks were performed:

- All three Network Security Groups were created successfully.
- Each NSG was associated with the correct subnet.
- RDP access was limited to the management subnet.
- DNS access was allowed from the client subnet.
- No general inbound RDP rule from the internet was created.

## Evidence

- `evidence/cli/04-network-security-groups.json`
- `evidence/cli/05-server-nsg-rules.json`
- `evidence/cli/06-subnet-nsg-associations.json`

## Result

**PASS**

The subnet-level Network Security Groups were created and associated successfully.
