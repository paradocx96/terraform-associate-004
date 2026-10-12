# Domain 4 - Terraform Configuration

**Objectives:** 4a resource vs data · 4b References · 4c Variables and outputs · 4d Complex types · 4e Expressions and functions · 4f Dependencies · 4g Custom conditions · 4h Sensitive data and Vault

**Estimated study time:** 12–15 hours (largest domain) · **Labs:** [02](../../labs/lab-02-variables-outputs/README.md), [03](../../labs/lab-03-count-for-each/README.md), [08](../../labs/lab-08-custom-conditions/README.md), optionally [06](../../labs/lab-06-aws-optional/README.md)
**Practice:** [`practice/04-configuration.md`](../../practice/04-configuration.md)

---

## 4a. `resource` vs `data`

```hcl
# Manages a real object (create / update / delete)
resource "aws_instance" "web" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"
}

# Reads an existing object (never creates)
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-*-amd64-server-*"]
  }
}
```

| | `resource` | `data` |
|---|---|---|
| Purpose | Manage lifecycle | Read-only lookup |
| Address | `aws_instance.web` | `data.aws_ami.ubuntu` |
| Appears in state | Yes | Yes (cached read) |
| Created/destroyed by Terraform | Yes | No |

## 4b. References and cross-resource references

| What | Syntax |
|---|---|
| Resource attribute | `aws_instance.web.public_ip` |
| Data attribute | `data.aws_ami.ubuntu.id` |
| Input variable | `var.region` |
| Local value | `local.name` |
| Module output | `module.vpc.vpc_id` |
| `count` instances | `aws_instance.web[0].id`, `aws_instance.web[*].id` |
| `for_each` instances | `aws_instance.web["a"].id` |

Referencing another resource's attribute creates an **implicit dependency**: Terraform creates the referenced resource first.

## 4c. Variables, locals and outputs

### Input variables

```hcl
variable "instance_count" {
  type        = number
  default     = 2
  description = "How many instances"
}
```

Ways to set values: defaults, `TF_VAR_name`, `terraform.tfvars`, `*.auto.tfvars`, `-var`, `-var-file`, interactive prompt (if no value and no default).

Accessing collections: `var.vpc_cidrs["us-east-1"]` (map key), `var.names[0]` (list index). Not `var.vpc_cidrs.0`, not `vpc_cidrs[...]` without `var.`.

Auto-loaded files: `terraform.tfvars`, `terraform.tfvars.json`, `*.auto.tfvars`, `*.auto.tfvars.json` are used by a plain `terraform plan` - no flag needed. Any other file name (e.g., `prod.tfvars`) needs `-var-file=prod.tfvars`.

**Precedence (lowest → highest):** default → env `TF_VAR_*` → `terraform.tfvars` → `terraform.tfvars.json` → `*.auto.tfvars*` (alphabetical) → `-var` / `-var-file` (order given).

Useful arguments: `type`, `default`, `description`, `validation`, `sensitive`, `nullable`, `ephemeral`.

### Local values

```hcl
locals {
  name_prefix = "${var.project}-${var.environment}"
  common_tags = { Project = var.project, Env = var.environment }
}
```

Use locals to avoid repeating expressions. Referenced as `local.name_prefix` (singular `local`, block is `locals`).

### Outputs

```hcl
output "instance_ip" {
  value       = aws_instance.web.public_ip
  description = "Public IP"
  sensitive   = false
}
```

Outputs are printed after apply, available via `terraform output`, and are the **only way for a child module to expose values** to its parent. Outputs marked `sensitive = true` are redacted in CLI output (but present in state).

## 4d. Complex types

| Category | Types |
|---|---|
| Primitive | `string`, `number`, `bool` |
| Collection (all elements same type) | `list(T)`, `set(T)`, `map(T)` |
| Structural (mixed types, fixed shape) | `object({...})`, `tuple([...])` |

```hcl
variable "servers" {
  type = map(object({
    size  = string
    count = number
  }))
  default = {
    web = { size = "small", count = 2 }
    db  = { size = "large", count = 1 }
  }
}
```

- **list**: ordered, duplicates allowed, index access `var.l[0]`
- **set**: unordered, unique, no index
- **map**: key → value, same value type
- **object**: named attributes, each with its own type
- **tuple**: ordered, each position its own type

Convert: `tolist()`, `toset()`, `tomap()`.

## 4e. Expressions and functions

```hcl
# Conditional
instance_type = var.env == "prod" ? "m5.large" : "t3.micro"

# for expressions
names_upper = [for n in var.names : upper(n)]
name_len    = { for n in var.names : n => length(n) }
admins      = [for k, v in var.users : k if v.role == "admin"]

# Splat
instance_ids = aws_instance.web[*].id

# String templates
name = "${var.project}-${var.env}"
```

### Meta-arguments

- **`count`** - N copies (`count.index`). Index-based: removing an item from the middle of a list shifts everything after it.
- **`for_each`** - one instance per element of a **map or set of strings** (`each.key`, `each.value`). Keyed → stable when items are added/removed.
- **`depends_on`**, **`provider`**, **`lifecycle`** (see 4f).

```hcl
resource "aws_s3_bucket" "b" {
  for_each = toset(["logs", "assets", "backups"])
  bucket   = "demo-${each.key}-12345"
}
```

`count` and `for_each` **cannot be used together** on the same resource.

### Dynamic blocks

```hcl
dynamic "ingress" {
  for_each = var.ports
  content {
    from_port   = ingress.value
    to_port     = ingress.value
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
```

### Functions

Terraform has built-in functions only (no user-defined functions). Test them in `terraform console`. See [`docs/06-hcl-cheatsheet.md`](../../docs/06-hcl-cheatsheet.md) for the list.

## 4f. Resource dependencies and lifecycle rules

- **Implicit:** referencing `aws_vpc.main.id` in another resource.
- **Explicit:** `depends_on = [aws_iam_role_policy.x]` when the dependency isn't visible via references.

```hcl
resource "aws_instance" "app" {
  # ...
  depends_on = [aws_iam_role_policy.app]

  lifecycle {
    create_before_destroy = true      # build replacement first, then destroy old
    prevent_destroy       = true      # error on any plan that would destroy it
    ignore_changes        = [tags]    # ignore out-of-band changes to these attributes
    replace_triggered_by  = [aws_security_group.app.id]
  }
}
```

| Lifecycle option | Effect |
|---|---|
| `create_before_destroy` | Create replacement before destroying the original (avoids downtime; watch for unique-name conflicts) |
| `prevent_destroy` | Plan fails if the resource would be destroyed |
| `ignore_changes` | Don't treat listed attributes' changes as drift to correct |
| `replace_triggered_by` | Force replacement when referenced resources/attributes change |

Terraform builds a **dependency graph**, walks it to create resources in order, and runs independent resources in parallel (`-parallelism=10` default).

## 4g. Custom conditions

Four mechanisms:

```hcl
# 1. Input variable validation (blocks the run if invalid)
variable "port" {
  type = number

  validation {
    condition     = var.port >= 1024 && var.port <= 65535
    error_message = "Port must be between 1024 and 65535."
  }
}

# 2/3. Preconditions and postconditions on resources, data sources (and outputs: precondition)
resource "aws_instance" "web" {
  ami           = var.ami
  instance_type = var.type

  lifecycle {
    precondition {
      condition     = data.aws_ami.selected.architecture == "x86_64"
      error_message = "AMI must be x86_64."
    }
    postcondition {
      condition     = self.public_dns != ""
      error_message = "Instance must have a public DNS name."
    }
  }
}

# 4. Check block - continuous validation, produces warnings (does not block)
check "health" {
  data "http" "app" {
    url = "https://example.com/health"
  }

  assert {
    condition     = data.http.app.status_code == 200
    error_message = "App is not healthy."
  }
}
```

| Mechanism | When evaluated | Blocks the run? |
|---|---|---|
| Variable `validation` | When variable value is evaluated | Yes |
| `precondition` | Before the object is evaluated/created | Yes |
| `postcondition` | After the object is created/read | Yes |
| `check` block `assert` | End of plan/apply | **No** - warning only |

## 4h. Sensitive data, ephemeral values and Vault

### What `sensitive` does and doesn't do

```hcl
variable "db_password" {
  type      = string
  sensitive = true
}
```

- Redacts the value in plan/apply CLI output.
- **Does NOT** keep it out of state or plan files. State holds plaintext → **protect and encrypt state**, restrict access.

### Best practices

- Never hard-code secrets in `.tf` files or commit `*.tfvars` containing secrets.
- Provide secrets through environment variables (`TF_VAR_...`), a secrets manager, HCP Terraform sensitive variables, or dynamic credentials.
- Use a **remote backend with encryption + access controls**.
- Prefer **short-lived / dynamic credentials** (e.g., Vault dynamic secrets, OIDC to cloud providers) over long-lived static keys.

### Ephemeral values and write-only arguments (new in 004 scope)

| Feature | What it gives you |
|---|---|
| **Ephemeral input variables / outputs** (`ephemeral = true`) | Value exists only during the run; **never written to state or plan file** |
| **Ephemeral resources** (`ephemeral "type" "name" {}`) | Fetch a secret at run time without persisting it |
| **Write-only arguments** (e.g., `password_wo` + `password_wo_version`) | Send a value to the provider without storing it in state |

Ephemeral values can only be used in other ephemeral contexts (ephemeral resources, provider configuration, write-only arguments, ephemeral outputs/variables, provisioner/connection blocks). Using one in a normal argument is an error. Which resources offer write-only arguments is **provider-specific** - check provider docs.

### HashiCorp Vault

- The **Vault provider** lets Terraform read secrets (`data "vault_kv_secret_v2"`) and manage Vault configuration.
- Reading a secret through a normal data source **stores the value in Terraform state** → secure the state, or use ephemeral resources where the provider supports them.
- Good pattern: Vault issues **short-lived credentials** (dynamic secrets), and Terraform authenticates to cloud providers with them instead of static keys.

## Exam traps

- `sensitive` ≠ encrypted/not-in-state. `ephemeral` = not in state. Secrets referenced in code, even via variables, end up in **plaintext in state** (official sample true/false).
- `terraform.tfvars` is loaded automatically; `prod.tfvars` is not.
- `for_each` needs a **map or set of strings**, not a list (use `toset()`).
- `count` index shifts → unexpected destroy/recreate; `for_each` keys are stable.
- Child modules only see what you pass in; parent sees only child `output`s.
- `check` blocks warn; `precondition`/`postcondition`/`validation` fail the run.
- Variable precedence: `-var` / `-var-file` beat everything else.
- `locals` (block) vs `local.x` (reference).
- `depends_on` is for **hidden** dependencies; don't use it when a reference already exists.

## Self-check

1. Write a variable that only accepts `dev`, `staging` or `prod`.
2. Convert a list of strings into a map of `name => length(name)`.
3. Why might `count` cause resources to be recreated when you remove the first list item?
4. Name two ways to keep a secret out of state.
5. What's the difference between `precondition` and `check`?

## Further reading

- <https://developer.hashicorp.com/terraform/language/expressions/type-constraints>
- <https://developer.hashicorp.com/terraform/language/validate>
- <https://developer.hashicorp.com/terraform/language/manage-sensitive-data>
- <https://developer.hashicorp.com/terraform/tutorials/secrets/secrets-vault>
