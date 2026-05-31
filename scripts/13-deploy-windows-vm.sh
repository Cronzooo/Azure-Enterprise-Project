#!/bin/bash
# Deploy a Windows Server 2022 VM in the management spoke
# This VM is for management/admin work (PowerShell, RSAT tools)
# No public IP - access only through Bastion via RDP

RG_NAME="rg-cronzo-prod-westeu"
LOCATION="westeurope"
VM_NAME="vm-mgmt-prod-westeu-001"
VNET="vnet-mgmt-prod-westeu-001"
SUBNET="snet-mgmt"
ADMIN_USER="cronzoadmin"
ADMIN_PASSWORD="CronzoMgmtTemp2026!"
TAGS="Environment=Lab Owner=Lionel-Edoukou Project=Cronzo-Foundation CostCenter=Learning"

az vm create \
  --resource-group "${RG_NAME}" \
  --name "${VM_NAME}" \
  --location "${LOCATION}" \
  --image "Win2022Datacenter" \
  --size "Standard_D2s_v6" \
  --vnet-name "${VNET}" \
  --subnet "${SUBNET}" \
  --admin-username "${ADMIN_USER}" \
  --computer-name "vm-mgmt-we-01" \
  --admin-password "${ADMIN_PASSWORD}" \
  --public-ip-address "" \
  --nsg "" \
  --tags ${TAGS}

echo "Done — Windows VM deployed. Username: ${ADMIN_USER}"