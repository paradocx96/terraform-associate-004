# 07 - Glossary

| Term | Meaning |
|---|---|
| **Infrastructure as Code (IaC)** | Managing infrastructure through versioned, machine-readable definition files instead of manual steps |
| **Declarative** | Describe the desired end state; the tool decides how to reach it |
| **Idempotent** | Applying the same configuration repeatedly yields the same result and no extra changes |
| **HCL** | HashiCorp Configuration Language - Terraform's configuration syntax |
| **Provider** | Plugin that lets Terraform manage a platform's resources via its API |
| **Resource** | Infrastructure object Terraform manages (`resource` block) |
| **Data source** | Read-only lookup of existing information (`data` block) |
| **State** | Record mapping configuration to real resources and their attributes |
| **Backend** | Where state is stored (and where operations run, for some backends) |
| **Remote state** | State stored in a shared remote backend |
| **State locking** | Preventing concurrent operations from corrupting state |
| **Drift** | Real infrastructure differs from state/config due to out-of-band changes |
| **Refresh** | Reading real infrastructure to update state's view of attributes |
| **Plan** | Computed set of changes needed to reach the desired state |
| **Apply** | Executing a plan against real infrastructure |
| **Dependency graph** | Directed graph Terraform builds to order and parallelise operations |
| **Implicit dependency** | Created by referencing another resource's attribute |
| **Explicit dependency** | Declared with `depends_on` |
| **Module** | Container for multiple resources used together; a directory of `.tf` files |
| **Root module** | The configuration in the working directory where you run Terraform |
| **Child module** | A module called by another module via a `module` block |
| **Registry** | Public Terraform Registry for providers and modules (registry.terraform.io) |
| **Lock file** | `.terraform.lock.hcl` - records chosen provider versions and checksums |
| **Workspace (CLI)** | Named state instance within the same backend and configuration |
| **Workspace (HCP Terraform)** | Full environment: config, variables, state, run history, permissions |
| **Project (HCP Terraform)** | Container grouping workspaces for organisation and access control |
| **Variable set** | Reusable group of variables applied to many workspaces/projects |
| **Run trigger** | Starts a run in one workspace when another workspace applies |
| **Sentinel** | HashiCorp's policy-as-code framework |
| **OPA** | Open Policy Agent - alternative policy engine supported in HCP Terraform |
| **Terraform Enterprise** | Self-hosted version of HCP Terraform |
| **HCP Terraform** | HashiCorp-managed SaaS (formerly Terraform Cloud) |
| **Sensitive value** | Redacted in CLI output; still stored in state |
| **Ephemeral value** | Exists only during a run; not stored in state or plan |
| **Write-only argument** | Resource argument whose value is sent to the provider but never stored in state/plan |
| **Precondition / Postcondition** | Lifecycle checks before/after a resource, data source or output is evaluated |
| **Check block** | Standalone assertion that warns but doesn't block |
| **Immutable infrastructure** | Replace resources rather than modifying in place |
| **Configuration drift** | See Drift |
| **Provisioner** | Run scripts on a resource (last resort; not recommended for routine use) |
