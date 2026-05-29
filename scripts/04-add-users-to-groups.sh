#!/bin/bash
# Add each user to their matching group
# Membership is the bridge between identity and permissions

TENANT_DOMAIN="archieanferneegmail.onmicrosoft.com"

# Look up user IDs by their login email
ALEX_ID=$(az ad user show --id "alex.admin@${TENANT_DOMAIN}" --query id -o tsv)
JORDAN_ID=$(az ad user show --id "jordan.web@${TENANT_DOMAIN}" --query id -o tsv)
RILEY_ID=$(az ad user show --id "riley.sec@${TENANT_DOMAIN}" --query id -o tsv)

# Add Alex to Cloud Admins
az ad group member add \
  --group "Cronzo-Cloud-Admins" \
  --member-id "${ALEX_ID}"

# Add Jordan to Web Ops
az ad group member add \
  --group "Cronzo-Web-Ops" \
  --member-id "${JORDAN_ID}"

# Add Riley to Security Ops
az ad group member add \
  --group "Cronzo-Security-Ops" \
  --member-id "${RILEY_ID}"

echo "Done — all 3 users added to their groups."