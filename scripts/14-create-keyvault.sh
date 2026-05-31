#!/bin/bash
# Create Azure Key Vault for centralized secrets storage
# Key Vault names must be globally unique across all of Azure
# Adding a random suffix to handle the global uniqueness requirement

RG_NAME="rg-cronzo-prod-westeu"
LOCATION="westeurope"
TAGS="Environment=Lab Owner=Lionel-Edoukou Project=Cronzo-Foundation CostCenter=Learning"

# Generate a short random suffix for global uniqueness
SUFFIX=$(openssl rand -hex 2)
KV_NAME="kv-cronzo-westeu-${SUFFIX}"

echo "Creating Key Vault: ${KV_NAME}"

az keyvault create \
  --resource-group "${RG_NAME}" \
  --name "${KV_NAME}" \
  --location "${LOCATION}" \
  --sku standard \
  --enable-rbac-authorization true \
  --tags ${TAGS}

echo ""
echo "Done — Key Vault created: ${KV_NAME}"
echo "Save this name. You will need it for the next scripts."