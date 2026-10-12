# Domain 6 - Terraform State Management

**Objectives:** 6a Local backend · 6b State locking · 6c Remote state / backend block · 6d Drift and state

**Estimated study time:** 5–6 hours · **Labs:** [Lab 05](../../labs/lab-05-state-management/README.md), optionally [Lab 06](../../labs/lab-06-aws-optional/README.md)
**Practice:** [`practice/06-state-management.md`](../../practice/06-state-management.md)

---

## 6a. The local backend

- Default if you configure nothing.
- Stores state in `terraform.tfstate` in the working directory (and `terraform.tfstate.backup` after changes).
- Uses OS-level file locking during operations.
- Fine for learning/solo work; poor for teams (no sharing, easy to lose, plaintext secrets on disk).

You can change the path:

```hcl
terraform {
  backend "local" {
    path = "state/custom.tfstate"
  }
}
```

## 6b. State locking

Locking **prevents two operations from modifying the same state at once**, which could corrupt it.

- Happens automatically on operations that write state (`plan`, `apply`, `destroy`, `state` modifications), if the backend supports locking.
- Local backend: file lock. Remote backends: depends (S3 supports locking - historically via DynamoDB, newer Terraform versions support a native lock file with `use_lockfile = true`; Azure Blob uses lease locks; GCS supports locking; HCP Terraform locks automatically).
- `-lock=false` disables locking (risky), `-lock-timeout=60s` waits for a lock.
- `terraform force-unlock LOCK_ID` removes a stuck lock - only when you're sure no run is active.

## 6c. Remote state with the backend block

```hcl
terraform {
  backend "s3" {
    bucket       = "my-terraform-state"
    key          = "prod/network/terraform.tfstate"
    region       = "us-east-1"
    encrypt      = true
    use_lockfile = true      # native S3 locking (check your Terraform version/docs)
  }
}
```

Rules to remember:

- **One** backend per configuration (root module).
- Backend blocks **cannot use variables, locals, or other references** (values must be literals). Use **partial configuration** instead: `terraform init -backend-config=backend.hcl` or `-backend-config="key=value"`.
- After adding or changing a backend, run `terraform init`. Terraform offers to **migrate** existing state (`terraform init -migrate-state`); `-reconfigure` ignores existing state/config.
- Remote backends give: shared state, locking, encryption/access control, durability, history (varies by backend).
- HCP Terraform uses the `cloud` block instead of a `backend` block (Domain 8).
- Secrets are stored in plaintext in state → use encryption at rest, restrict access.

`terraform_remote_state` data source reads outputs from another configuration's state (requires read access to that state; exposes only root-level outputs).

## 6d. Drift and managing state

**Drift** = real infrastructure differs from what Terraform last recorded (someone changed a resource in the console, or something was deleted).

How Terraform handles it:

- Every `plan`/`apply` first **refreshes** state from real infrastructure, then compares to config.
- If the config still describes what you want, apply will **revert** drift.
- To accept real-world changes into state **without changing infrastructure**: `terraform apply -refresh-only` (preview with `terraform plan -refresh-only`).
- `terraform refresh` is **deprecated** (it updated state without a review step).

### Refactoring state safely

| Goal | Preferred (config-driven) | Older CLI way |
|---|---|---|
| Rename / move a resource or module without destroy | `moved { from = ..., to = ... }` block | `terraform state mv` |
| Stop managing without destroying | `removed { from = ..., lifecycle { destroy = false } }` block | `terraform state rm` |
| Adopt existing infrastructure | `import { to = ..., id = ... }` block | `terraform import` |

```hcl
moved {
  from = aws_instance.web
  to   = aws_instance.app
}

removed {
  from = aws_instance.legacy

  lifecycle {
    destroy = false
  }
}
```

Config-driven blocks show up in `plan`, can be code-reviewed, and work in HCP Terraform.

## Exam traps

- Local state = `terraform.tfstate` by default. Backends can't use variables.
- Locking protects against concurrent writes; `force-unlock` only for stuck locks.
- `-refresh-only` updates **state only**; it does not change infrastructure.
- Moving/renaming → `moved`; stop managing → `removed` (`destroy = false`) or `state rm`.
- State holds secrets in plaintext even with `sensitive = true`.
- Don't hand-edit state; use CLI/blocks.

## Self-check

1. What does the local backend store and where?
2. Why can't a backend block use `var.bucket`?
3. How do you move local state to S3?
4. How do you detect and accept drift without changing infrastructure?
5. How do you rename a resource without destroying it?

## Further reading

- <https://developer.hashicorp.com/terraform/language/backend>
- <https://developer.hashicorp.com/terraform/language/state/locking>
- <https://developer.hashicorp.com/terraform/language/state/refactor>
- <https://developer.hashicorp.com/terraform/tutorials/state/resource-drift>
