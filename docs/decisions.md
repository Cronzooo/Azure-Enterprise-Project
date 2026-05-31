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