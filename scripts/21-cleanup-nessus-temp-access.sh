#!/bin/bash
# Clean up the temporary Nessus UI access setup
# Removes public IP and NSG rule created in script 20

set -e

RG_NAME="rg-cronzo-prod-westeu"
VM_NAME="vm-web-prod-westeu-001"
NIC_NAME="${VM_NAME}VMNic"
NSG_NAME="nsg-web"

echo "Detaching public IP from VM NIC..."
az network nic ip-config update \
  --resource-group "${RG_NAME}" \
  --nic-name "${NIC_NAME}" \
  --name "ipconfig${VM_NAME}" \
  --remove publicIPAddress

echo "Deleting public IP resource..."
az network public-ip delete \
  --resource-group "${RG_NAME}" \
  --name "pip-temp-nessus"

echo "Removing NSG rule for port 8834..."
az network nsg rule delete \
  --resource-group "${RG_NAME}" \
  --nsg-name "${NSG_NAME}" \
  --name "Allow-Nessus-Temp"

echo ""
echo "Done — temporary Nessus access removed. VM is back to private-only."