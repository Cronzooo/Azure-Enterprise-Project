// ===========================================================================
// Hub VNet - Bicep template
// Defines the central hub VNet with Bastion + shared services subnets
// Equivalent to scripts/06-create-hub-vnet.sh but declarative
// ===========================================================================

@description('Azure region for the VNet')
param location string = 'westeurope'

@description('Name of the hub VNet')
param vnetName string = 'vnet-hub-prod-westeu-001'

@description('Tags applied to all resources')
param tags object = {
  Environment: 'Lab'
  Owner: 'Lionel-Edoukou'
  Project: 'Cronzo-Foundation'
  CostCenter: 'Learning'
}

// The hub VNet with two subnets defined inline
resource hubVnet 'Microsoft.Network/virtualNetworks@2023-09-01' = {
  name: vnetName
  location: location
  tags: tags
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.0.0.0/16'
      ]
    }
    subnets: [
      {
        name: 'AzureBastionSubnet'
        properties: {
          addressPrefix: '10.0.1.0/26'
        }
      }
      {
        name: 'snet-shared-services'
        properties: {
          addressPrefix: '10.0.2.0/24'
        }
      }
    ]
  }
}

// Outputs - things this template "returns" for other templates to use
output vnetId string = hubVnet.id
output vnetName string = hubVnet.name
