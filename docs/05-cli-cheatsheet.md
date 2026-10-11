# 05 — CLI Cheat Sheet

## Core workflow

| Command | Notes |
|---|---|
| `terraform init` | Installs providers/modules, configures backend, writes `.terraform.lock.hcl`. Safe to re-run. |
| `terraform init -upgrade` | Upgrade providers/modules to newest versions allowed by constraints. |
| `terraform init -backend=false` | Init without configuring backend (used for `validate` in CI). |
| `terraform init -migrate-state` | Move state when backend config changes. |
| `terraform init -reconfigure` | Reconfigure backend, ignoring existing config/state. |
| `terraform init -backend-config=FILE` | Partial backend configuration. |
| `terraform validate` | Static syntax/consistency check. |
| `terraform fmt` | Format files in current dir. `-recursive`, `-check` (non-zero exit if changes needed), `-diff`. |
| `terraform plan` | Dry run. `-out=FILE` saves a plan. |
| `terraform plan -destroy` | Preview destroy. |
| `terraform plan -refresh-only` | Preview state-only drift reconciliation. |
| `terraform plan -generate-config-out=FILE` | Generate config for `import` blocks. |
| `terraform apply` | Apply with approval prompt. |
| `terraform apply FILE` | Apply a saved plan (no prompt). |
| `terraform apply -auto-approve` | Skip prompt. |
| `terraform apply -refresh-only` | Update state to match reality; no infra changes. |
| `terraform apply -replace=ADDR` | Recreate a specific resource (replaces `taint`). |
| `terraform apply -destroy` / `terraform destroy` | Destroy managed infrastructure. |

## Common flags (plan / apply / destroy)

| Flag | Purpose |
|---|---|
| `-var 'name=value'` | Set a variable |
| `-var-file=FILE` | Load variable values from a file |
| `-target=ADDR` | Limit to a resource (exceptional use) |
| `-lock=false` | Disable state locking (risky) |
| `-lock-timeout=DURATION` | Wait for lock |
| `-refresh=false` | Skip refresh |
| `-parallelism=N` | Concurrent operations (default 10) |

## Inspect

| Command | Notes |
|---|---|
| `terraform show` | Show state (or `show FILE` for a saved plan). `-json` for machines. |
| `terraform output` | All outputs; `terraform output NAME`; `-json`; `-raw` |
| `terraform providers` | Provider requirements tree |
| `terraform graph` | DOT graph of dependencies |
| `terraform console` | Interactive expression evaluator |
| `terraform version` | CLI + provider versions |
| `terraform get` | Download modules (init does this too) |

## State

| Command | Notes |
|---|---|
| `terraform state list` | Resource addresses in state |
| `terraform state show ADDR` | Attributes of one resource |
| `terraform state mv SRC DEST` | Rename/move in state (prefer `moved` blocks) |
| `terraform state rm ADDR` | Stop managing without destroying (prefer `removed` blocks) |
| `terraform state pull` / `push` | Download / upload raw state |
| `terraform force-unlock LOCK_ID` | Remove a stuck lock |

## Import

| Command / block | Notes |
|---|---|
| `terraform import ADDR ID` | Legacy CLI import: state only, you must write config |
| `import { to = ADDR  id = "..." }` | Config-driven import; shown in plan; works with `-generate-config-out` |

## Workspaces (CLI)

`terraform workspace list | show | new NAME | select NAME | delete NAME`

CLI workspaces share the same configuration and backend but keep separate state. Referenced as `terraform.workspace`.

## HCP Terraform

| Command | Notes |
|---|---|
| `terraform login` | Stores API token locally (`credentials.tfrc.json`) |
| `terraform logout` | Removes it |
| `cloud { ... }` block | Connects configuration to an HCP Terraform workspace |

## Environment variables

| Variable | Purpose |
|---|---|
| `TF_VAR_name` | Set input variable `name` |
| `TF_LOG` | `TRACE`, `DEBUG`, `INFO`, `WARN`, `ERROR` (TRACE = most verbose) |
| `TF_LOG_PATH` | Write logs to a file |
| `TF_LOG_CORE` / `TF_LOG_PROVIDER` | Log levels per component |
| `TF_IN_AUTOMATION` | Adjusts output for CI |
| `TF_INPUT=0` | Disable interactive prompts |
| `TF_CLI_ARGS`, `TF_CLI_ARGS_plan` | Default CLI arguments |
| `TF_WORKSPACE` | Select workspace |
| `TF_DATA_DIR` | Change `.terraform` location |

## Files and folders

| Path | Commit to Git? |
|---|---|
| `*.tf`, `*.tfvars` (non-secret) | Yes (tfvars with secrets: **no**) |
| `.terraform.lock.hcl` | **Yes** |
| `.terraform/` | No |
| `terraform.tfstate`, `*.tfstate.backup` | **No** (contains secrets) |
| `crash.log` | No |
| `*.auto.tfvars` | Depends — never if secret |

## Variable precedence (lowest → highest)

1. Variable `default`
2. Environment variables `TF_VAR_*`
3. `terraform.tfvars`
4. `terraform.tfvars.json`
5. `*.auto.tfvars` / `*.auto.tfvars.json` (alphabetical order)
6. `-var` and `-var-file` on the command line (in the order given; later wins)

(In HCP Terraform, workspace variables and variable sets also feed values; CLI/variables set in the workspace follow its own rules.)
