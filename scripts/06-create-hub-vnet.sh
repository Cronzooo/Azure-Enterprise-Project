#!/bin/bash
# Create the hub VNet with subnets for Bastion and shared services
# The hub is the central network where admin access and shared tooling live

RG_NAME="rg-cronzo-prod-eastus"
LOCATION="eastus"
TAGS="Environment=Lab Owner=Lionel-Edoukou Project=Cronzo-Foundation CostCenter=Learning"

# Create the hub VNet with one subnet to start
az network vnet create \
  --resource-group "${RG_NAME}" \
  --name "vnet-hub-prod-eastus-001" \
  --location "${LOCATION}" \
  --address-prefixes "10.0.0.0/16" \
  --subnet-name "AzureBastionSubnet" \
  --subnet-prefixes "10.0.1.0/26" \
  --tags ${TAGS}

# Add the shared services subnet
az network vnet subnet create \
  --resource-group "${RG_NAME}" \
  --vnet-name "vnet-hub-prod-eastus-001" \
  --name "snet-shared-services" \
  --address-prefixes "10.0.2.0/24"

echo "Done — hub VNet created with 2 subnets."