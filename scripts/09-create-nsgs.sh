#!/bin/bash
# Create NSGs for the spoke subnets with least-privilege rules
# Each NSG only allows the traffic actually needed for the workload

RG_NAME="rg-cronzo-prod-westeu"
LOCATION="westeurope"
TAGS="Environment=Lab Owner=Lionel-Edoukou Project=Cronzo-Foundation CostCenter=Learning"
HUB_RANGE="10.0.0.0/16"

# --------- WEB NSG ---------

# Create the NSG for the web subnet
az network nsg create \
  --resource-group "${RG_NAME}" \
  --name "nsg-web" \
  --location "${LOCATION}" \
  --tags ${TAGS}

# Allow SSH from the hub VNet only (Bastion will use this)
az network nsg rule create \
  --resource-group "${RG_NAME}" \
  --nsg-name "nsg-web" \
  --name "Allow-SSH-From-Hub" \
  --priority 100 \
  --direction Inbound \
  --access Allow \
  --protocol Tcp \
  --source-address-prefixes "${HUB_RANGE}" \
  --destination-port-ranges 22 \
  --description "Allow SSH only from the hub VNet (for Bastion)"

# Attach NSG to the web subnet
az network vnet subnet update \
  --resource-group "${RG_NAME}" \
  --vnet-name "vnet-web-prod-westeu-001" \
  --name "snet-web" \
  --network-security-group "nsg-web"

# --------- MGMT NSG ---------

# Create the NSG for the management subnet
az network nsg create \
  --resource-group "${RG_NAME}" \
  --name "nsg-mgmt" \
  --location "${LOCATION}" \
  --tags ${TAGS}

# Allow RDP from the hub VNet only (Bastion will use this)
az network nsg rule create \
  --resource-group "${RG_NAME}" \
  --nsg-name "nsg-mgmt" \
  --name "Allow-RDP-From-Hub" \
  --priority 100 \
  --direction Inbound \
  --access Allow \
  --protocol Tcp \
  --source-address-prefixes "${HUB_RANGE}" \
  --destination-port-ranges 3389 \
  --description "Allow RDP only from the hub VNet (for Bastion)"

# Attach NSG to the mgmt subnet
az network vnet subnet update \
  --resource-group "${RG_NAME}" \
  --vnet-name "vnet-mgmt-prod-westeu-001" \
  --name "snet-mgmt" \
  --network-security-group "nsg-mgmt"

echo "Done — both NSGs created and attached to their subnets."