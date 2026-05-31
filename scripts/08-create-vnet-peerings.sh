#!/bin/bash
# Create VNet peerings to connect hub to each spoke (both directions)
# Without peering, the VNets cannot talk to each other

RG_NAME="rg-cronzo-prod-westeu"
HUB="vnet-hub-prod-westeu-001"
WEB="vnet-web-prod-westeu-001"
MGMT="vnet-mgmt-prod-westeu-001"

# Peering 1: Hub -> Web spoke
az network vnet peering create \
  --resource-group "${RG_NAME}" \
  --name "peer-hub-to-web" \
  --vnet-name "${HUB}" \
  --remote-vnet "${WEB}" \
  --allow-vnet-access

# Peering 2: Web spoke -> Hub
az network vnet peering create \
  --resource-group "${RG_NAME}" \
  --name "peer-web-to-hub" \
  --vnet-name "${WEB}" \
  --remote-vnet "${HUB}" \
  --allow-vnet-access

# Peering 3: Hub -> Mgmt spoke
az network vnet peering create \
  --resource-group "${RG_NAME}" \
  --name "peer-hub-to-mgmt" \
  --vnet-name "${HUB}" \
  --remote-vnet "${MGMT}" \
  --allow-vnet-access

# Peering 4: Mgmt spoke -> Hub
az network vnet peering create \
  --resource-group "${RG_NAME}" \
  --name "peer-mgmt-to-hub" \
  --vnet-name "${MGMT}" \
  --remote-vnet "${HUB}" \
  --allow-vnet-access

echo "Done — all 4 peerings created."