# Domain 7 — Maintain Infrastructure with Terraform

**Objectives:** 7a Import existing infrastructure · 7b Use the CLI to inspect state · 7c Verbose logging

**Estimated study time:** 3–4 hours · **Labs:** [Lab 05](../../labs/lab-05-state-management/README.md), [Lab 06](../../labs/lab-06-aws-optional/README.md) (import)
**Practice:** [`practice/07-maintain-infrastructure.md`](../../practice/07-maintain-infrastructure.md)

---

## 7a. Importing existing infrastructure

Import brings **already-existing** resources under Terraform management by adding them to state.

### Config-driven `import` block (preferred)

```hcl
import {
  to = aws_s3_bucket.legacy
  id = "my-existing-bucket-name"
}
```

Workflow:

1. Add the `import` block (and optionally an empty/partial `resource` block).
2. Generate configuration: `terraform plan -generate-config-out=generated.tf`
3. Review/clean `generated.tf`, move it into your real files.
4. `terraform plan` (shows the import) → `terraform apply`.
5. Remove the `import` block after it's applied (optional; it's harmless).

Benefits: appears in `plan`, reviewable in PRs, can import many resources, can generate configuration, works in HCP Terraform.

### Legacy CLI command

```bash
terraform import aws_s3_bucket.legacy my-existing-bucket-name
```

- Updates **state only**.
- You must **write the resource block yourself** first, or the import fails/leaves unmanaged config.
- Not shown in a plan beforehand.

Remember: the **ID format is provider-specific** (check the resource's "Import" section in the provider docs).

## 7b. Inspecting state with the CLI

| Command | What it does |
|---|---|
| `terraform state list` | List all resource addresses in state (optionally filter by address) |
| `terraform state show ADDR` | Show one resource's recorded attributes |
| `terraform show` | Human-readable view of the whole state (or `show tfplan` for a plan) |
| `terraform show -json` | Machine-readable |
| `terraform output [NAME]` | Print outputs (`-json`, `-raw`) |
| `terraform state pull` | Print raw state JSON to stdout |
| `terraform state mv` / `rm` | Modify state (prefer `moved`/`removed` blocks) |
| `terraform graph` | DOT dependency graph |
| `terraform console` | Evaluate expressions against current state |

Addresses: `aws_instance.web`, `aws_instance.web[0]`, `aws_instance.web["a"]`, `module.app.aws_instance.web`, `data.aws_ami.ubuntu`.

## 7c. Verbose logging

Set environment variables to see debug logs:

```bash
export TF_LOG=DEBUG            # TRACE | DEBUG | INFO | WARN | ERROR
export TF_LOG_PATH=terraform.log
terraform plan
unset TF_LOG TF_LOG_PATH
```

- **TRACE** is the most verbose; **ERROR** the least.
- `TF_LOG_CORE` and `TF_LOG_PROVIDER` set levels separately for core vs providers.
- Use when plans/applies behave unexpectedly, providers fail, or you need to report a bug.
- Logs can contain **sensitive data**; sanitise before sharing.
- Crash logs: `crash.log` (don't commit it).

## Troubleshooting (learning-path tutorial "Troubleshoot Terraform")

HashiCorp groups problems into **four types**. Rule out earlier ones before suspecting later ones:

| Type | What it is | Typical clue |
|---|---|---|
| **Language errors** | Invalid HCL / configuration (syntax, types, bad references) | `terraform validate` / `fmt` messages with a file and line |
| **State errors** | State is out of sync with reality or config, which can make Terraform change or destroy resources | Unexpected plan diffs, missing resources; use `state list/show`, `-refresh-only` |
| **Core errors** | Bugs in Terraform core (config interpretation, state handling, graph, provider communication) | Crashes, `crash.log`; capture `TF_LOG_CORE` |
| **Provider errors** | Provider plugin issues (authentication, API calls, resource mapping) | API/auth errors; capture `TF_LOG_PROVIDER` |

When reporting bugs, include the relevant logs (core vs provider) — sanitise secrets first.

## Exam traps

- `terraform import` (CLI) changes state only; the **import block** can generate config.
- You can't import "into thin air" — a resource block address is required (`to = ...`).
- `TF_LOG=TRACE` is the most verbose; set `TF_LOG_PATH` to persist.
- `terraform state` subcommands for inspection: `list`, `show`.
- Import doesn't make Terraform manage things you don't describe in config — you still need matching configuration.

## Self-check

1. Compare the `import` block and `terraform import` in three ways.
2. Which flag generates config for an import block?
3. How do you list all resources in state?
4. Which env var writes logs to a file?

## Further reading

- <https://developer.hashicorp.com/terraform/language/import>
- <https://developer.hashicorp.com/terraform/cli/commands/state>
- <https://developer.hashicorp.com/terraform/internals/debugging>
