# Design Decisions and Lessons Learned

## Region migration: East US → West Europe (Day 2)

**Problem:** Standard_B2s VMs were unavailable in East US due to capacity restrictions on the free trial. After trying Standard_B1s, Standard_B2ms, Standard_D2s_v3, and Standard_B2as_v2 with the same SkuNotAvailable error, decided to migrate the entire deployment to West Europe.

**How:** Because the entire foundation was scripted in CLI, the migration took ~20 minutes:
1. Deleted the East US resource group (`az group delete`)
2. Updated the LOCATION variable in all region-specific scripts from `eastus` to `westeurope`
3. Updated resource names from `*-eastus-*` to `*-westeu-*`
4. Re-ran scripts 1, 5, 6, 7, 8, 9, 10 in order

**West Europe outcome:** B-series still constrained. Used `az vm list-skus` to query available sizes, settled on `Standard_D2s_v6` which deployed successfully.

**Lesson:** This is exactly why infrastructure is scripted. A click-ops approach would have taken hours to redo manually. Scripts made it a 20-minute fix.

**Interview talking point:** Plan for capacity issues. In production, Bicep templates would have fallback size logic.


## Windows VM 15-character name limit (Day 2)

**Problem:** Tried to deploy Windows VM with name `vm-mgmt-prod-westeu-001` (22 characters). Got InvalidParameter error: "Windows computer name cannot be more than 15 characters long."

**Why:** Windows enforces a 15-character limit on computer names — a legacy from the 1990s NetBIOS protocol. Linux doesn't have this constraint, which is why the Ubuntu VM with the same naming pattern worked fine.

**Fix:** Added `--computer-name "vm-mgmt-we-01"` (13 chars) to give Windows a short internal hostname while keeping the longer Azure resource name aligned with our naming convention.

**Lesson:** When designing for hybrid (Linux + Windows) cloud environments, the OS imposes its own naming constraints that go beyond what the cloud provider requires. Worth catching at the design stage, not deploy time.

## Day 4: Log Analytics alert rule deferred to portal

**Problem:** Tried creating a scheduled query alert rule with `az monitor scheduled-query create`. The CLI extension's parser fails on KQL queries that contain pipes (`|`), quotes (`"`), and special characters - core to any real KQL query.

**Decision:** Deferred alert rule creation to the portal. In production, most engineers create scheduled query alerts via portal or ARM/Bicep templates rather than CLI - the CLI syntax is fragile.

**Result preserved:** Working KQL queries (`AzureDiagnostics | where ResourceType == "VAULTS"`) and audit data captured via Log Analytics workspace - the underlying observability skill is the value, not the alert wrapper.

**Interview talking point:** "I built a Log Analytics workspace, configured diagnostic settings on Key Vault and Bastion, and queried real audit data with KQL. I can show actual SecretGet, SecretList, and Authentication events I generated, with timestamps, result types, and source IPs."