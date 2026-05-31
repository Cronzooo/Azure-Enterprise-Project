#!/bin/bash
# Grant the current user permission to manage secrets in Key Vault
# Without this, we cannot add or read secrets even though we created the vault

set -e

KV_NAME="kv-cronzo-westeu-bcaf"
RG_NAME="rg-cronzo-prod-westeu"

# Get the current user's object ID
USER_ID=$(az ad signed-in-user show --query id -o tsv)

# Build the full scope path to the Key Vault
SUBSCRIPTION_ID=$(az account show --query id -o tsv)
SCOPE="/subscriptions/${SUBSCRIPTION_ID}/resourceGroups/${RG_NAME}/providers/Microsoft.KeyVault/vaults/${KV_NAME}"

echo "Granting Key Vault Secrets Officer role to current user..."

az role assignment create \
  --assignee-object-id "${USER_ID}" \
  --assignee-principal-type User \
  --role "Key Vault Secrets Officer" \
  --scope "${SCOPE}"

echo "Done — you can now read/write/delete secrets in ${KV_NAME}"