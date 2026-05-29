#!/bin/bash
# Create 3 Entra ID groups representing real-world job roles
# Each group will later get a different RBAC role

# Group 1 - Cloud Admins (broad access)
az ad group create \
  --display-name "Cronzo-Cloud-Admins" \
  --mail-nickname "cronzo-cloud-admins"

# Group 2 - Web Ops (manages VMs only)
az ad group create \
  --display-name "Cronzo-Web-Ops" \
  --mail-nickname "cronzo-web-ops"

# Group 3 - Security Ops (read-only)
az ad group create \
  --display-name "Cronzo-Security-Ops" \
  --mail-nickname "cronzo-security-ops"