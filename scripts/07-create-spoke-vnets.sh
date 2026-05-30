#!/bin/bash
# Create the 2 spoke VNets - one for web workloads, one for management
# Each spoke will host a VM later in Day 2

RG_NAME="rg-cronzo-prod-eastus"
LOCATION="eastus"
TAGS="Environment=Lab Owner=Lionel-Edoukou Project=Cronzo-Foundation CostCenter=Learning"

# Spoke 1 - Web (will host Ubuntu + NGINX)
az network vnet create \
  --resource-group "${RG_NAME}" \
  --name "vnet-web-prod-eastus-001" \
  --location "${LOCATION}" \
  --address-prefixes "10.1.0.0/16" \
  --subnet-name "snet-web" \
  --subnet-prefixes "10.1.1.0/24" \
  --tags ${TAGS}

# Spoke 2 - Management (will host Windows Server)
az network vnet create \
  --resource-group "${RG_NAME}" \
  --name "vnet-mgmt-prod-eastus-001" \
  --location "${LOCATION}" \
  --address-prefixes "10.2.0.0/16" \
  --subnet-name "snet-mgmt" \
  --subnet-prefixes "10.2.1.0/24" \
  --tags ${TAGS}

echo "Done — both spoke VNets created."