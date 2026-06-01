#!/bin/bash
# Add secrets to Key Vault for use by deployment scripts
# This replaces hardcoded passwords in scripts

set -e

KV_NAME="kv-cronzo-westeu-bcaf"

# Require the password to be passed as an environment variable
# Usage: WINDOWS_VM_PASSWORD='YourPassword!' bash scripts/16-add-secrets-to-keyvault.sh
if [ -z "${WINDOWS_VM_PASSWORD}" ]; then
  echo "ERROR: WINDOWS_VM_PASSWORD environment variable not set"
  exit 1
fi


echo "Adding Windows VM admin password to Key Vault..."

az keyvault secret set \
--vault-name "${KV_NAME}" \
 --value "${WINDOWS_VM_PASSWORD}" \
  --name "windows-vm-admin-password" \
  --description "Admin password for vm-mgmt-prod-westeu-001" \
  > /dev/null

echo "Done — secret 'windows-vm-admin-password' stored in ${KV_NAME}"
echo ""
echo "Verify with: az keyvault secret show --vault-name ${KV_NAME} --name windows-vm-admin-password --query value -o tsv"