# Domain 8 — HCP Terraform

**Objectives:** 8a Use HCP Terraform to create infrastructure · 8b Collaboration and governance · 8c Workspaces and projects · 8d CLI integration

**Estimated study time:** 5–6 hours · **Lab:** [Lab 07](../../labs/lab-07-hcp-terraform/README.md)
**Practice:** [`practice/08-hcp-terraform.md`](../../practice/08-hcp-terraform.md)

---

## What is HCP Terraform?

HashiCorp's managed platform (formerly **Terraform Cloud**) that runs Terraform for teams: remote state, remote runs, access control, policy, a private registry, and more. **Terraform Enterprise** is the self-hosted equivalent.

Core hierarchy:

```
Organization
 └── Project(s)
      └── Workspace(s)  ← state, variables, runs, settings
```

## 8a. Using HCP Terraform to create infrastructure

### Workspaces

An HCP Terraform **workspace** is a full environment for one configuration instance: it holds the configuration (via VCS/CLI/API), **variables**, **state** (with versions/history), **run history**, **permissions**, and **settings**.

> Not the same as **CLI workspaces** (`terraform workspace ...`), which are just multiple state files under one backend/configuration.

### Three workflows

| Workflow | How runs start |
|---|---|
| **VCS-driven** | Commit/PR to a connected repo triggers plan (speculative on PRs) and apply |
| **CLI-driven** | `terraform plan/apply` locally with the `cloud` block; execution happens remotely |
| **API-driven** | Your tooling calls the HCP Terraform API |

### Runs

- **Remote operations:** plan/apply run on HCP Terraform infrastructure, not your laptop; output streams back to your CLI.
- Run stages: *plan → (cost estimation) → (policy check) → apply (manual or auto-approve)*.
- **Speculative plans** show proposed changes (e.g., on pull requests) but can't be applied.
- Remote state: stored, encrypted, versioned and **locked** automatically.

### Variables

- **Terraform variables** (input variables) and **environment variables** (e.g., cloud credentials).
- Can be marked **sensitive** (write-only in the UI/API).
- **Variable sets** apply reusable groups of variables to many workspaces/projects.

## 8b. Collaboration and governance features

| Feature | Purpose |
|---|---|
| **Teams & permissions** | Role-based access to organizations, projects, workspaces |
| **Private registry** | Share internal modules/providers with versioning |
| **Policy enforcement** | **Sentinel** and **OPA** policies evaluated between plan and apply (advisory / soft-mandatory / hard-mandatory enforcement levels for Sentinel) |
| **Cost estimation** | Estimate monthly cost changes before apply |
| **Run tasks** | Integrate third-party checks into runs |
| **Health assessments / drift detection** | Detect infrastructure drift and continuous validation (`check` blocks) |
| **Explorer** | Org-wide view of workspaces, providers, modules, versions |
| **Change requests** | Request changes to a workspace from other teams |
| **Dynamic provider credentials** | OIDC-based short-lived credentials to cloud providers |
| **Audit logging** | Track actions |
| **No-code provisioning** | Let consumers deploy registry modules without writing HCL |

Terraform Enterprise adds self-hosting, air-gapped installs and enterprise controls.

### Execution modes, versions and tokens

- **Execution mode** per workspace: **Remote** (runs on HCP Terraform), **Local** (runs on your machine; HCP Terraform only stores state), **Agent** (runs on your own agents inside your network).
- Each workspace has its **Terraform version** setting; upgrade it deliberately (tutorial "Upgrade Terraform version in HCP Terraform").
- **API token types:** user, team, and organization tokens. `terraform login` creates a user token.
- **Auto-apply** on a workspace skips manual confirmation; leave it off for production unless policy-controlled.

### Team permissions

- **Teams** are groups of users; grant them access to organizations, projects and workspaces.
- Fixed workspace permission levels: **Read, Plan, Write, Admin** (plus custom permissions). Use least privilege.

### Sharing data between workspaces

- **Run triggers** chain runs (source workspace apply → downstream run).
- The **`terraform_remote_state`** data source reads another workspace's **outputs** (the source workspace must allow remote state sharing). Alternative: the `tfe_outputs` data source from the `tfe` provider.

### Policy enforcement levels

- **Sentinel:** advisory, soft-mandatory (overridable), hard-mandatory.
- **OPA:** advisory and mandatory.

## 8c. Organising workspaces and projects

- **Projects** group workspaces so you can manage **access (team permissions)** and settings for related workspaces, and share variable sets across them.
- Common patterns: one workspace per environment per component (e.g., `network-prod`, `app-prod`, `app-staging`); one project per team or application.
- **Run triggers:** when workspace A finishes an apply, automatically queue a run in workspace B (e.g., network → application).
- **Variable sets:** attach to the organization, specific projects, or specific workspaces.
- Tags help organise/filter workspaces.

## 8d. Configuring HCP Terraform integration

### Authenticate

```bash
terraform login        # opens a browser, stores a user API token locally
```

### Connect a configuration — the `cloud` block

```hcl
terraform {
  cloud {
    organization = "my-org"

    workspaces {
      name = "app-prod"          # single workspace
      # OR: tags = ["app"]       # multiple workspaces selected via tags
      # OR: project = "my-project"
    }
  }
}
```

Then `terraform init` → the CLI connects to HCP Terraform. Runs now execute remotely.

### Migrating existing state

Add the `cloud` block and run `terraform init`; Terraform offers to copy local/remote state to HCP Terraform.

- The older `backend "remote"` also exists but **`cloud` is the recommended way**.
- Provider credentials must be set in the workspace (variables/dynamic credentials) because the run happens remotely.

## Exam traps

- HCP Terraform workspace ≠ CLI workspace.
- Projects organise workspaces and **scope permissions/variable sets**.
- Policy checks (Sentinel/OPA) run **after plan, before apply**.
- With remote execution, local environment variables/credentials are **not** automatically used — configure them in the workspace.
- `cloud` block is for HCP Terraform / Terraform Enterprise; `backend` blocks are for other backends.
- Variable sets are the way to share variables across workspaces.
- HCP Terraform provides remote state storage with locking and versioning.

## Self-check

1. List the three run workflows.
2. What does a run trigger do?
3. Where do Sentinel/OPA policies run in the run lifecycle?
4. What command authenticates the CLI?
5. How do projects differ from workspaces?

## Further reading

- <https://developer.hashicorp.com/terraform/cloud-docs>
- <https://developer.hashicorp.com/terraform/cloud-docs/projects>
- <https://developer.hashicorp.com/terraform/cloud-docs/workspaces/settings/run-triggers>
- <https://developer.hashicorp.com/terraform/cli/cloud>
