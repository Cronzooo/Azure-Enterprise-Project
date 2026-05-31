#!/bin/bash
# Create the main resource group for Cronzo Inc Azure Foundation
# Usage: bash scripts/01-create-resource-group.sh

az group create \
  --name rg-cronzo-prod-westeu \
  --location westeurope \
  --tags Environment=Lab Owner="Lionel Edoukou" Project=Cronzo-Foundation CostCenter=Learning