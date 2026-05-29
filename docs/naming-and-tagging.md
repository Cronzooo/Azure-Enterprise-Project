# Naming and Tagging Strategy

## Why this matters
Without rules, a cloud account gets messy fast. Names tell you what a thing is. Tags tell you who owns it and why it exists. Together they make the cloud manageable.

## Naming pattern

Every resource follows this format:

`<resource-type>-<workload>-<environment>-<region>-<instance>`

### What each part means

| Part | Meaning | Example |
|---|---|---|
| resource-type | Short code for what kind of thing it is | `vm`, `vnet`, `kv`, `rg` |
| workload | What this thing is used for | `hub`, `web`, `mgmt` |
| environment | What stage it's in | `prod`, `dev`, `test` |
| region | Where it lives | `eastus`, `westus` |
| instance | Number, in case we have many | `001`, `002` |

### Resource type short codes

| Resource | Short code |
|---|---|
| Resource Group | `rg` |
| Virtual Network | `vnet` |
| Subnet | `snet` |
| Network Security Group | `nsg` |
| Virtual Machine | `vm` |
| Network Interface | `nic` |
| Public IP | `pip` |
| Key Vault | `kv` |
| Storage Account | `st` |
| Log Analytics Workspace | `log` |
| Bastion | `bas` |

### Real examples for this project

- `rg-cronzo-prod-eastus` — main resource group
- `vnet-hub-prod-eastus-001` — hub virtual network
- `vnet-web-prod-eastus-001` — web spoke
- `vnet-mgmt-prod-eastus-001` — management spoke
- `vm-web-prod-eastus-001` — Ubuntu web server
- `vm-mgmt-prod-eastus-001` — Windows management server
- `vm-nessus-prod-eastus-001` — Nessus scanner
- `kv-cronzo-prod-eastus-001` — Key Vault
- `bas-hub-prod-eastus-001` — Azure Bastion

## Tagging strategy

Every resource gets these 4 tags:

| Tag name | Tag value | What it's for |
|---|---|---|
| Environment | `Lab` | Tells us this is not real production |
| Owner | `Lionel Edoukou` | Who to contact about this resource |
| Project | `Cronzo-Foundation` | Groups all resources for this project |
| CostCenter | `Learning` | Used for billing reports |

## Storage account special rule

Storage account names must be all lowercase, no dashes, max 24 characters.
Example: `stcronzoprodeastus001`

## Key Vault special rule

Key Vault names must be globally unique across all of Azure. Add a short random suffix if needed.
Example: `kv-cronzo-prod-eastus-001-x7k`