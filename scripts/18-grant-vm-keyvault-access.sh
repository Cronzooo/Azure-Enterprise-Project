#!/bin/bash
# Grant the Ubuntu VM's managed identity permission to read secrets from Key Vault
# Role: Key Vault Secrets User (read only, cannot create or delete)
# This follows least privilege - the VM only needs to read, not manage

set -e

RG_NAME="rg-cronzo-prod-westeu"
VM_NAME="vm-web-prod-westeu-001"
KV_NAME="kv-cronzo-westeu-bcaf"

# Get the VM's managed identity principal ID
VM_IDENTITY_ID=$(az vm show \
  --resource-group "${RG_NAME}" \
  --name "${VM_NAME}" \
  --query "identity.principalId" -o tsv)

echo "VM identity ID: ${VM_IDENTITY_ID}"

# Build the Key Vault scope path
SUBSCRIPTION_ID=$(az account show --query id -o tsv)
KV_SCOPE="/subscriptions/${SUBSCRIPTION_ID}/resourceGroups/${RG_NAME}/providers/Microsoft.KeyVault/vaults/${KV_NAME}"

echo "Granting Key Vault Secrets User role..."

az role assignment create \
  --assignee-object-id "${VM_IDENTITY_ID}" \
  --assignee-principal-type ServicePrincipal \
  --role "Key Vault Secrets User" \
  --scope "${KV_SCOPE}"

echo ""
echo "Done — ${VM_NAME} can now read secrets from ${KV_NAME}"