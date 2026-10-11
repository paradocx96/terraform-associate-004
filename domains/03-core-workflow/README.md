# Domain 3 — Core Terraform Workflow

**Objectives:** 3a Workflow · 3b init · 3c validate · 3d plan · 3e apply · 3f destroy · 3g fmt

**Estimated study time:** 5–6 hours · **Lab:** [Lab 01](../../labs/lab-01-hello-terraform/README.md)
**Practice:** [`practice/03-core-workflow.md`](../../practice/03-core-workflow.md)

---

## 3a. The workflow

```
Write  →  Init  →  (Validate / Fmt)  →  Plan  →  Apply  →  (Destroy when finished)
```

| Stage | What you do | Command |
|---|---|---|
| Write | Author `.tf` files | editor |
| Init | Prepare the working directory | `terraform init` |
| Plan | Preview changes | `terraform plan` |
| Apply | Execute changes | `terraform apply` |
| Destroy | Remove everything managed | `terraform destroy` |

Team variations: configs live in Git, plans run in CI on pull requests, applies run after approval — or via HCP Terraform.

## 3b. `terraform init`

Run first in any new or changed working directory. It:

- Installs **providers** and downloads **modules**
- Initialises the **backend** (state storage)
- Creates/updates `.terraform.lock.hcl`

Safe to run repeatedly (idempotent). Re-run when you: add a provider, add/change a module source or version, change backend configuration.

Useful flags: `-upgrade`, `-reconfigure`, `-migrate-state`, `-backend=false`, `-backend-config=...`.

## 3c. `terraform validate`

Checks the configuration is **syntactically valid and internally consistent** (types, references, required arguments).

- Does **not** access remote services or state.
- Needs providers/modules initialised (`terraform init` or `init -backend=false`).
- Does **not** guarantee the apply will succeed (e.g., a bucket name already taken).

## 3d. `terraform plan`

Creates an **execution plan**: compares configuration ↔ state ↔ refreshed real infrastructure, then shows creates (`+`), updates in place (`~`), destroys (`-`), replacements (`-/+`).

- **Never changes infrastructure.**
- `-out=tfplan` saves the plan so `apply` runs *exactly* that.
- `-destroy` previews destroy; `-refresh-only` previews state-only reconciliation; `-var`, `-var-file`, `-target`, `-replace=ADDR`.
- Dependencies come from the **resource graph** (implicit via references, explicit via `depends_on`).

Plan symbols:

| Symbol | Meaning |
|---|---|
| `+` | create |
| `-` | destroy |
| `~` | update in place |
| `-/+` | destroy and recreate (replace) |
| `+/-` | create then destroy (with `create_before_destroy`) |

## 3e. `terraform apply`

Executes the plan and updates state.

- `terraform apply` — computes a new plan, asks for `yes`.
- `terraform apply tfplan` — applies a saved plan, **no interactive approval prompt**.
- `-auto-approve` — skip the prompt (CI/automation).
- `-replace=ADDR` — force recreate a single resource (modern replacement for `terraform taint`).
- If apply fails midway, state records what *was* created; fix and re-run.

## 3f. `terraform destroy`

Destroys all resources tracked in state for that configuration. Equivalent to `terraform apply -destroy`.

- `terraform plan -destroy` previews it.
- Destroys in reverse dependency order.
- Resources with `prevent_destroy = true` cause an error.
- Destroy removes resources from state but does not delete the state file.

## 3g. `terraform fmt`

Rewrites `.tf` files to the canonical style (indentation, alignment of `=`).

- `-recursive` include subdirectories
- `-check` exit non-zero if changes needed (CI)
- `-diff` show differences

`fmt` is style only; `validate` is correctness.

## Worked example (try it)

```bash
mkdir demo && cd demo
cat > main.tf <<'HCL'
terraform {
  required_providers {
    random = { source = "hashicorp/random", version = "~> 3.6" }
  }
}
resource "random_pet" "p" { length = 2 }
output "name" { value = random_pet.p.id }
HCL

terraform init
terraform fmt
terraform validate
terraform plan -out=tfplan
terraform apply tfplan
terraform output
terraform destroy
```

## Exam traps

- `plan` ≠ changes anything. `validate` ≠ plan.
- `apply tfplan` does **not** ask for approval.
- `destroy` = `apply -destroy`.
- `taint` is deprecated → `apply -replace`.
- `terraform refresh` is deprecated → `apply -refresh-only`.
- `init` is needed again after adding providers/modules or changing the backend.

## Self-check

1. What three things does `init` do?
2. Does `validate` call cloud APIs?
3. How do you apply exactly the plan you reviewed?
4. How do you recreate one resource without editing code?
5. How would you check formatting in CI?

## Further reading

- <https://developer.hashicorp.com/terraform/intro/core-workflow>
- <https://developer.hashicorp.com/terraform/cli/commands/plan>
- <https://developer.hashicorp.com/terraform/cli/commands/apply>
