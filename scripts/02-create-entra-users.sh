#!/bin/bash
# Create 3 Entra ID users for the Cronzo Inc project
# Each user represents a different real-world role

TENANT_DOMAIN="archieanferneegmail.onmicrosoft.com"
TEMP_PASSWORD="CronzoTemp123!"

# User 1 - Alex Admin (Cloud Admin role)
az ad user create \
  --display-name "Alex Admin" \
  --user-principal-name "alex.admin@${TENANT_DOMAIN}" \
  --password "${TEMP_PASSWORD}" \
  --force-change-password-next-sign-in true

# User 2 - Jordan Web (Web Ops role)
az ad user create \
  --display-name "Jordan Web" \
  --user-principal-name "jordan.web@${TENANT_DOMAIN}" \
  --password "${TEMP_PASSWORD}" \
  --force-change-password-next-sign-in true

# User 3 - Riley Sec (Security Ops role)
az ad user create \
  --display-name "Riley Sec" \
  --user-principal-name "riley.sec@${TENANT_DOMAIN}" \
  --password "${TEMP_PASSWORD}" \
  --force-change-password-next-sign-in true