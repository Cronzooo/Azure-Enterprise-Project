# Cronzo Inc — Secure Azure Cloud Foundation

A complete, production-style Azure cloud environment built CLI-first. Hub-and-spoke network topology, Azure Bastion for secure VM access, Key Vault with managed identities for secrets, Nessus vulnerability scanning, Log Analytics observability, and infrastructure-as-code via Bicep.

**Author:** Lionel Edoukou
**Region:** West Europe


---

## Architecture
![Cronzo Network Architecture](diagrams/Networking%20Diagram.png)

*High-level network topology — hub VNet with two isolated spokes, all VM access through Azure Bastion.*
Hub-and-spoke topology with workload isolation:HUB VNet (10.0.0.0/16)
    ┌──────────────────────────────────────────┐
    │  AzureBastionSubnet (10.0.1.0/26)        │
    │     └── Azure Bastion (browser-based     │
    │           SSH/RDP, no public IPs on VMs) │
    │                                          │
    │  snet-shared-services (10.0.2.0/24)      │
    │     └── (planned: dedicated scanner VM)  │
    └──────────────────────────────────────────┘
          ↕ peering              ↕ peering
          ↓                      ↓---

## Tech stack

| Layer | Technology |
|---|---|
| Identity | Microsoft Entra ID (users, groups, RBAC) |
| Networking | Azure VNets, peering, NSGs, Azure Bastion |
| Compute | Ubuntu 22.04 (NGINX), Windows Server 2022 |
| Secrets | Azure Key Vault + managed identities |
| Monitoring | Log Analytics + KQL queries, Microsoft Defender for Cloud |
| Security scanning | Nessus Essentials (Tenable) |
| Infrastructure-as-Code | Bicep (declarative) + Azure CLI bash scripts (imperative) |
| Source control | Git + GitHub |

---

## What this project demonstrates

- **Hub-and-spoke network design** with proper subnet planning and least-privilege NSGs
- **Identity-first security**: Entra ID users → groups → RBAC at resource group scope
- **Zero public exposure**: No public IPs on workload VMs; all access through Bastion
- **Secrets management**: Centralized Key Vault, managed identity authentication, RBAC-controlled access. Verified end-to-end by having a VM fetch a secret using only its managed identity (no credentials in code)
- **Vulnerability scanning**: Real Nessus scan executed against the Ubuntu VM, generating a vulnerability report (3 Medium + 77 informational findings across 2 targets)
- **Observability with KQL**: Diagnostic settings on Key Vault and Bastion ship logs to Log Analytics; KQL queries return real audit data (SecretGet, SecretList, Authentication events with timestamps and source IPs)
- **Infrastructure-as-Code**: One workload (hub VNet) re-expressed as a Bicep template; `az deployment group what-if` used for drift detection against the live environment
- **Documented decision-making**: Every workaround and constraint captured in `docs/decisions.md` (East US → West Europe migration, Windows 15-char NetBIOS limit, free trial vCPU quota, Nessus Essentials export limitation)

---

## Repository structure---

## Day-by-day summary

### Day 1 — Identity, naming, RBAC
Created the resource group with tagging strategy. Provisioned 3 Entra ID users (alex.admin, jordan.web, riley.sec) and 3 groups (Cronzo-Cloud-Admins, Cronzo-Web-Ops, Cronzo-Security-Ops). Assigned least-privilege RBAC at resource group scope.

### Day 2 — Network and compute
Built hub + 2 spokes with peerings. Added NSGs enforcing least privilege. Deployed Azure Bastion. Deployed Ubuntu (NGINX) and Windows Server VMs with no public IPs. Hit and resolved East US capacity exhaustion by migrating the entire stack to West Europe — the value of IaC made the migration a 20-minute job.

### Day 3 — Security and observability
Created Key Vault and moved the Windows admin password out of source control into encrypted storage. Enabled managed identity on the web VM and granted Key Vault Secrets User role. Verified end-to-end secretless authentication. Installed Nessus Essentials on the Ubuntu VM and executed a real network scan against the web spoke. Deployed Log Analytics workspace, configured diagnostic settings on Key Vault and Bastion, queried real audit data with KQL.

### Day 4 — IaC, documentation, tear down
Converted the hub VNet to Bicep. Used `az deployment group what-if` to demonstrate drift detection against the live environment. Polished documentation. Tore down all resources before free trial expiration.

---

## Lessons learned

See [docs/decisions.md](docs/decisions.md) for full write-ups. Highlights:

- **East US → West Europe migration**: Hit `SkuNotAvailable` errors across multiple SKU families during VM deployment. Decided to migrate the entire deployment. Because everything was scripted, the migration took ~20 minutes (change one variable, rerun in order).
- **Windows 15-character NetBIOS naming limit**: Discovered Windows VMs reject computer names longer than 15 characters (Linux doesn't have this limit). Worked around with `--computer-name` while keeping the longer Azure resource name aligned with the project's naming convention.
- **Free trial vCPU quota**: Hit the 4-vCPU regional limit when trying to deploy a third VM for Nessus. Pivoted to installing Nessus on the existing Ubuntu VM and documented the trade-off.
- **Nessus Essentials cannot export reports**: Tenable changed their licensing — PDF export is now Pro-only. Captured the artifact as screenshots instead.
- **CLI fragility for scheduled query alerts**: `az monitor scheduled-query create` has a fragile parser that fails on standard KQL queries. Deferred alert rule to the portal/Bicep — the KQL queries themselves are the underlying skill.

---

## Visual evidence

Screenshots captured during the live deployment, before tear down:

| Capture | What it shows |
|---|---|
| ![](reports/Defender%20for%20cloud.png) | Microsoft Defender for Cloud Recommendations view for the Cronzo subscription |
| ![](reports/SC%20KQL%20analytics.png) | KQL query results showing real Key Vault audit events |
| ![](reports/Sc%20KQL%201.webp) | Log Analytics workspace query - Key Vault SecretGet events |
| ![](reports/Sc%20KQL%202.webp) | Log Analytics workspace query - additional audit data |

## Next steps

If continuing this project:
- Convert remaining bash scripts to Bicep modules
- Add a GitHub Actions workflow to deploy Bicep on push to `main` using a service principal
- Enable Microsoft Defender for Cloud paid plans for runtime threat detection
- Add Azure Firewall to the hub for outbound traffic inspection
- Integrate Microsoft Sentinel for SIEM/SOAR on top of Log Analytics

---

## Architecture diagram

A visual hub-and-spoke diagram is referenced in [diagrams/](diagrams/) and embedded in the comprehensive project PDF.
