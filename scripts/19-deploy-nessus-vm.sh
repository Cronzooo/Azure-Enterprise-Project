#!/bin/bash
# Deploy Ubuntu VM in the hub to run Nessus Essentials vulnerability scanner
# Lives in snet-shared-services subnet for centralized security tooling
# No public IP - access only through Bastion

set -e

RG_NAME="rg-cronzo-prod-westeu"
LOCATION="westeurope"
VM_NAME="vm-nessus-prod-westeu"
VNET="vnet-hub-prod-westeu-001"
SUBNET="snet-shared-services"
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

echo "Done — Nessus VM deployed. SSH keys reused from your previous Ubuntu deploy."