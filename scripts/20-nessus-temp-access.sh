#!/bin/bash
# Temporarily expose Nessus web UI for initial setup
# Creates a public IP, attaches it to the web VM, opens port 8834
# CLEANUP after Nessus setup is complete - this is not for production

set -e

RG_NAME="rg-cronzo-prod-westeu"
LOCATION="westeurope"
VM_NAME="vm-web-prod-westeu-001"
NIC_NAME="${VM_NAME}VMNic"
NSG_NAME="nsg-web"
HOME_IP="73.212.144.138"
TAGS="Environment=Lab Owner=Lionel-Edoukou Project=Cronzo-Foundation CostCenter=Learning"

echo "Creating temporary public IP for Nessus setup..."

# Step 1: Create a Standard public IP
az network public-ip create \
  --resource-group "${RG_NAME}" \
  --name "pip-temp-nessus" \
  --location "${LOCATION}" \
  --sku Standard \
  --allocation-method Static \
  --tags ${TAGS}

# Step 2: Attach it to the VM's network card
echo "Attaching public IP to ${VM_NAME}..."
az network nic ip-config update \
  --resource-group "${RG_NAME}" \
  --nic-name "${NIC_NAME}" \
  --name "ipconfig${VM_NAME}" \
  --public-ip-address "pip-temp-nessus"

# Step 3: Add NSG rule allowing 8834 from your home IP only
echo "Adding NSG rule for port 8834 from ${HOME_IP}..."
az network nsg rule create \
  --resource-group "${RG_NAME}" \
  --nsg-name "${NSG_NAME}" \
  --name "Allow-Nessus-Temp" \
  --priority 200 \
  --direction Inbound \
  --access Allow \
  --protocol Tcp \
  --source-address-prefixes "${HOME_IP}" \
  --destination-port-ranges 8834 \
  --description "TEMPORARY - Nessus UI access for initial setup"

echo ""
echo "Done. Your temporary public IP is:"
az network public-ip show \
  --resource-group "${RG_NAME}" \
  --name "pip-temp-nessus" \
  --query "ipAddress" -o tsv

echo ""
echo "Access Nessus at: https://<that-ip-above>:8834"
echo ""
echo "REMEMBER: Run scripts/21-cleanup-nessus-temp-access.sh when done!"