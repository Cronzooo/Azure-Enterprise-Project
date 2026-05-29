#!/bin/bash
# Assign RBAC roles to each group at the resource group scope
# This is where permissions actually get granted

RG_NAME="rg-cronzo-prod-eastus"
SUBSCRIPTION_ID=$(az account show --query id -o tsv)
SCOPE="/subscriptions/${SUBSCRIPTION_ID}/resourceGroups/${RG_NAME}"

# Look up group IDs
ADMINS_ID=$(az ad group show --group "Cronzo-Cloud-Admins" --query id -o tsv)
WEBOPS_ID=$(az ad group show --group "Cronzo-Web-Ops" --query id -o tsv)
SECOPS_ID=$(az ad group show --group "Cronzo-Security-Ops" --query id -o tsv)

# Cloud Admins -> Contributor on the resource group
az role assignment create \
  --assignee-object-id "${ADMINS_ID}" \
  --assignee-principal-type Group \
  --role "Contributor" \
  --scope "${SCOPE}"

# Web Ops -> Virtual Machine Contributor on the resource group
az role assignment create \
  --assignee-object-id "${WEBOPS_ID}" \
  --assignee-principal-type Group \
  --role "Virtual Machine Contributor" \
  --scope "${SCOPE}"

# Security Ops -> Reader on the resource group
az role assignment create \
  --assignee-object-id "${SECOPS_ID}" \
  --assignee-principal-type Group \
  --role "Reader" \
  --scope "${SCOPE}"

echo "Done — all 3 RBAC roles assigned."