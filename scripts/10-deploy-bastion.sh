#!/bin/bash
# Deploy Azure Bastion into the hub VNet for secure VM access
# This takes 5-10 minutes - Azure spins up dedicated infrastructure

RG_NAME="rg-cronzo-prod-westeu"
LOCATION="westeurope"
HUB_VNET="vnet-hub-prod-westeu-001"
TAGS="Environment=Lab Owner=Lionel-Edoukou Project=Cronzo-Foundation CostCenter=Learning"
HUB_VNET="vnet-hub-prod-westeu-001"

# Step 1: Create a public IP for Bastion
# Bastion requires Standard SKU + Static allocation
az network public-ip create \
  --resource-group "${RG_NAME}" \
  --name "pip-bastion-prod-westeu-001" \
  --location "${LOCATION}" \
  --sku Standard \
  --allocation-method Static \
  --tags ${TAGS}

# Step 2: Deploy the Bastion service
# This is the slow part - 5 to 10 minutes
az network bastion create \
  --resource-group "${RG_NAME}" \
  --name "bas-hub-prod-westeu-001" \
  --location "${LOCATION}" \
  --public-ip-address "pip-bastion-prod-westeu-001" \
  --vnet-name "${HUB_VNET}" \
  --sku Basic \
  --tags ${TAGS}

echo "Done — Bastion deployed and ready."