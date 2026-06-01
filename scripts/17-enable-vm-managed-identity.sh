#!/bin/bash
# Enable a system-assigned managed identity on the Ubuntu web VM
# This gives the VM an Azure-managed identity it can use to access other services
# No passwords, no key files - Azure handles all the authentication

set -e

RG_NAME="rg-cronzo-prod-westeu"
VM_NAME="vm-web-prod-westeu-001"

echo "Enabling system-assigned managed identity on ${VM_NAME}..."

az vm identity assign \
  --resource-group "${RG_NAME}" \
  --name "${VM_NAME}"

echo ""
echo "Done — managed identity enabled on ${VM_NAME}"
echo ""
echo "Identity details:"
az vm show \
  --resource-group "${RG_NAME}" \
  --name "${VM_NAME}" \
  --query "identity" -o table