# Cronzo Azure Foundation

Enterprise-pattern Azure foundation built CLI-first over Memorial Day weekend 2026.

## Architecture
Hub-and-spoke topology with centralized identity, security tooling, and shared services. Built and torn down for portfolio purposes. Deployed via Azure CLI scripts; will be converted to Bicep on Day 4.

## Progress

### Day 1 — Foundation (done)
- [x] GitHub repo initialized with structured folders
- [x] Naming and tagging strategy documented
- [x] Resource group created via CLI script
- [x] 3 Entra ID users created (Cloud Admin, Web Op, Security)
- [x] 3 Entra ID groups created with users assigned
- [x] RBAC roles assigned with least-privilege scope

### Day 2 — Network + Compute (in progress)
- [ ] Hub VNet (10.0.0.0/16) with subnets
- [ ] 2 Spoke VNets (10.1.0.0/16 web, 10.2.0.0/16 mgmt)
- [ ] VNet peering hub-to-spokes
- [ ] NSGs with least-privilege rules
- [ ] Azure Bastion for secure VM access
- [ ] Ubuntu VM with NGINX (web server)
- [ ] Windows Server VM (management server)

### Day 3 — Security + Observability
- [ ] Key Vault and managed identities
- [ ] Nessus vulnerability scanner
- [ ] Log Analytics workspace
- [ ] KQL queries and alert rules

### Day 4 — IaC + Documentation
- [ ] Convert manual deployments to Bicep
- [ ] GitHub Actions deployment workflow
- [ ] Full README, architecture diagram, lessons learned
- [ ] Tear down resources

## Folder structure
- bicep/ — Infrastructure as Code templates
- scripts/ — Azure CLI automation
- docs/ — Design decisions, naming, RBAC notes
- diagrams/ — Architecture diagrams
- reports/ — Vulnerability scan reports

## Naming and tagging
See docs/naming-and-tagging.md for the full convention.
Enterprise-pattern Azure foundation for Cronzo Inc — hub-spoke networking, identity, security, monitoring, and IaC.
