#!/usr/bin/env bash

set -euo pipefail

RG="rg-nordicit-lab"
VNET="vn-nordicit-lab"

FAILED=0

check_subnet_nsg() {
    local subnet="$1"
    local expected_nsg="$2"

    actual_nsg=$(az network vnet subnet show \
        --resource-group "$RG" \
        --vnet-name "$VNET" \
        --name "$subnet" \
        --query "networkSecurityGroup.id" \
        --output tsv)

    if [[ "$actual_nsg" == *"/$expected_nsg" ]]; then
        echo "PASS: $subnet is associated with $expected_nsg"
    else
        echo "FAIL: $subnet is not associated with $expected_nsg"
        FAILED=1
    fi
}

check_rule() {
    local nsg="$1"
    local rule="$2"

    exists=$(az network nsg rule show \
        --resource-group "$RG" \
        --nsg-name "$nsg" \
        --name "$rule" \
        --query "provisioningState" \
        --output tsv 2>/dev/null || true)

    if [[ "$exists" == "Succeeded" ]]; then
        echo "PASS: Rule $rule exists in $nsg"
    else
        echo "FAIL: Rule $rule is missing from $nsg"
        FAILED=1
    fi
}

echo "Validating subnet associations..."
check_subnet_nsg "Server-Subnet" "nsg-server-subnet"
check_subnet_nsg "Client-Subnet" "nsg-client-subnet"
check_subnet_nsg "Management-Subnet" "nsg-management-subnet"

echo
echo "Validating server NSG rules..."
check_rule "nsg-server-subnet" "Allow-RDP-From-Management"
check_rule "nsg-server-subnet" "Allow-DNS-From-Clients-UDP"
check_rule "nsg-server-subnet" "Allow-DNS-From-Clients-TCP"

echo

if [[ "$FAILED" -eq 0 ]]; then
    echo "NETWORK VALIDATION RESULT: PASS"
    exit 0
else
    echo "NETWORK VALIDATION RESULT: FAIL"
    exit 1
fi
