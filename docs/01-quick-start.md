# 01 — Quick Start: What You Actually Need to Know

Read this first. It is the 80/20 of the Terraform Associate exam.

## The mental model (memorise this picture)

```
   YOUR CODE (.tf)         STATE (terraform.tfstate)        REAL WORLD (cloud/SaaS)
  "what I want"            "what Terraform believes exists"  "what actually exists"
        │                              │                              │
        └───────────────► terraform plan ◄─────────────────────────────┘
                              (compare all three, refresh state)
                                      │
                                      ▼
                              terraform apply
                      (call provider APIs, update state)
```

- **Configuration** = desired state (declarative HCL).
- **State** = Terraform's record that maps config → real resources (IDs, attributes, dependencies).
- **Providers** = plugins that talk to APIs (AWS, Azure, GCP, Kubernetes, GitHub…).
- **Plan** = diff between desired config, state, and refreshed reality.
- **Apply** = executes the plan, then updates state.

## The 10 concepts that cover most questions

1. **IaC is declarative**: you describe the end state; Terraform works out the steps.
2. **Workflow**: Write → Init → Plan → Apply (→ Destroy).
3. **Providers** are downloaded by `terraform init` from the Registry; versions are pinned with constraints and recorded in `.terraform.lock.hcl`.
4. **`resource` creates/manages; `data` only reads** existing things.
5. **Dependencies** are implicit (via references) or explicit (`depends_on`).
6. **Variables in, outputs out.** Know variable precedence and `sensitive`.
7. **Modules** are folders of `.tf` files. Child modules only see what you pass in; the parent only sees their `output`s.
8. **State** is sensitive, must be protected, should be remote + locked for teams, and is never hand-edited.
9. **Drift** = real world changed outside Terraform. Detect with `plan -refresh-only`.
10. **HCP Terraform** = remote runs, remote state, workspaces, projects, variable sets, policy (Sentinel/OPA), private registry, team access.

## The 15 commands to know cold

| Command | One-line purpose |
|---|---|
| `terraform init` | Download providers/modules, configure backend, create lock file |
| `terraform validate` | Check syntax and internal consistency (no remote calls) |
| `terraform fmt` | Rewrite files to canonical style |
| `terraform plan` | Show what would change (changes nothing) |
| `terraform apply` | Make the changes |
| `terraform destroy` | Destroy everything in the state (same as `apply -destroy`) |
| `terraform show` | Human-readable view of state or a saved plan |
| `terraform output` | Print output values |
| `terraform state list/show/mv/rm` | Inspect/modify state |
| `terraform import` / `import` block | Bring existing resources under management |
| `terraform apply -refresh-only` | Update state to match reality (no infra changes) |
| `terraform apply -replace=ADDR` | Force recreate one resource (replaces `taint`) |
| `terraform workspace ...` | CLI workspaces (separate state, same config) |
| `terraform login` | Authenticate to HCP Terraform |
| `terraform force-unlock ID` | Release a stuck state lock |

## The "which one?" differentiators (most-tested distinctions)

| Pair | Difference |
|---|---|
| `resource` vs `data` | manage vs read-only |
| `count` vs `for_each` | index-based list vs key-based map/set (more stable) |
| Implicit vs explicit dependency | reference vs `depends_on` |
| `variable` vs `local` vs `output` | input vs internal named expression vs exposed result |
| `sensitive` vs `ephemeral` | hidden in CLI output but **stored in state** vs **never stored in state/plan** |
| `precondition`/`postcondition` vs `check` | block the run vs warn only |
| Local backend vs remote backend | file on disk vs shared, locked, (usually) encrypted storage |
| CLI workspace vs HCP Terraform workspace | state-only partition vs full working environment (vars, runs, permissions) |
| `terraform import` vs `import` block | CLI, state only vs config-driven, plannable, can generate config |
| `moved` vs `removed` | rename/relocate without destroy vs stop managing without destroy |
| `fmt` vs `validate` | style vs correctness |
| `-target` vs full plan | exceptional, partial — not for routine use |

## Study loop (works every time)

1. Read the domain README.
2. Do the matching lab by typing the code yourself.
3. Answer the domain practice questions without looking.
4. For every miss, write a one-line "why" in your own words.
5. Re-do missed questions after 48 hours.

Next: [`02-study-plan.md`](02-study-plan.md)
