#!/bin/bash
# Send logs from key resources to the Log Analytics workspace
# This makes them queryable via KQL

set -e

RG_NAME="rg-cronzo-prod-westeu"
WORKSPACE_NAME="log-cronzo-prod-westeu"
KV_NAME="kv-cronzo-westeu-bcaf"
BASTION_NAME="bas-hub-prod-westeu-001"

# Get workspace resource ID (full path)
WORKSPACE_ID=$(az monitor log-analytics workspace show \
  --resource-group "${RG_NAME}" \
  --workspace-name "${WORKSPACE_NAME}" \
  --query id -o tsv)

echo "Workspace resource ID: ${WORKSPACE_ID}"
echo ""

# Get Key Vault resource ID
KV_ID=$(az keyvault show --name "${KV_NAME}" --query id -o tsv)

# Get Bastion resource ID
BASTION_ID=$(az network bastion show \
  --resource-group "${RG_NAME}" \
  --name "${BASTION_NAME}" \
  --query id -o tsv)

# Enable diagnostic settings on Key Vault
echo "Configuring Key Vault diagnostic settings..."
az monitor diagnostic-settings create \
  --name "send-to-log-analytics" \
  --resource "${KV_ID}" \
  --workspace "${WORKSPACE_ID}" \
  --logs '[{"category":"AuditEvent","enabled":true},{"category":"AzurePolicyEvaluationDetails","enabled":true}]' \
  --metrics '[{"category":"AllMetrics","enabled":true}]'

# Enable diagnostic settings on Bastion
echo "Configuring Bastion diagnostic settings..."
az monitor diagnostic-settings create \
  --name "send-to-log-analytics" \
  --resource "${BASTION_ID}" \
  --workspace "${WORKSPACE_ID}" \
  --logs '[{"category":"BastionAuditLogs","enabled":true}]'

echo ""
echo "Done — Key Vault and Bastion are now shipping logs to Log Analytics."
echo "It takes 5-10 minutes for the first logs to appear."