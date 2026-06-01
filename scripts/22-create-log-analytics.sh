#!/bin/bash
# Create Log Analytics workspace for centralized logging
# This is where all diagnostic logs from Azure resources will flow

set -e

RG_NAME="rg-cronzo-prod-westeu"
LOCATION="westeurope"
WORKSPACE_NAME="log-cronzo-prod-westeu"
TAGS="Environment=Lab Owner=Lionel-Edoukou Project=Cronzo-Foundation CostCenter=Learning"

echo "Creating Log Analytics workspace: ${WORKSPACE_NAME}"

az monitor log-analytics workspace create \
  --resource-group "${RG_NAME}" \
  --workspace-name "${WORKSPACE_NAME}" \
  --location "${LOCATION}" \
  --sku "PerGB2018" \
  --retention-time 30 \
  --tags ${TAGS}

echo ""
echo "Done — Log Analytics workspace created."
echo "Workspace ID:"
az monitor log-analytics workspace show \
  --resource-group "${RG_NAME}" \
  --workspace-name "${WORKSPACE_NAME}" \
  --query "customerId" -o tsv