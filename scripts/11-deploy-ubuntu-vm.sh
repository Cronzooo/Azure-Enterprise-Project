#!/bin/bash
# Deploy an Ubuntu 22.04 LTS VM in the web spoke
# This VM will run NGINX web server
# No public IP - access only through Bastion

RG_NAME="rg-cronzo-prod-westeu"
LOCATION="westeurope"
VM_NAME="vm-web-prod-westeu-001"
VNET="vnet-web-prod-westeu-001"
SUBNET="snet-web"
ADMIN_USER="cronzoadmin"
TAGS="Environment=Lab Owner=Lionel-Edoukou Project=Cronzo-Foundation CostCenter=Learning"

az vm create \
  --resource-group "${RG_NAME}" \
  --name "${VM_NAME}" \
  --location "${LOCATION}" \
  --image "Ubuntu2204" \
  --size "Standard_D2s_v6" \
  --vnet-name "${VNET}" \
  --subnet "${SUBNET}" \
  --admin-username "${ADMIN_USER}" \
  --generate-ssh-keys \
  --public-ip-address "" \
  --nsg "" \
  --tags ${TAGS}

echo "Done — Ubuntu VM deployed. SSH keys saved to ~/.ssh/"