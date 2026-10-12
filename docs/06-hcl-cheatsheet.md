# 06 - HCL Cheat Sheet

## Block types

```hcl
terraform {
  required_version = ">= 1.9.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
  backend "s3" {}            # or: cloud { ... }
}

provider "aws" {
  region = "us-east-1"
}

provider "aws" {
  alias  = "west"
  region = "us-west-2"
}

resource "aws_instance" "web" { /* ... */ }      # manages
data     "aws_ami"      "ubuntu" { /* ... */ }   # reads
variable "name" { type = string }
locals   { prefix = "app-${var.name}" }
output   "id" { value = aws_instance.web.id }
module   "net" { source = "./modules/net" }

moved   { from = aws_instance.a  to = aws_instance.b }
import  { to = aws_s3_bucket.x  id = "bucket-name" }
removed { from = aws_instance.old
          lifecycle { destroy = false } }
check   "name" { assert { condition = true  error_message = "..." } }
```

(Multi-attribute blocks are shown compactly above; in real files put each argument on its own line.)

## Provider version constraints

| Operator | Meaning |
|---|---|
| `= 1.2.3` or `1.2.3` | Exactly |
| `!= 1.2.3` | Not this version |
| `>= 1.2.0` | At least |
| `< 2.0.0` | Below |
| `~> 1.2` | `>= 1.2` and `< 2.0` (rightmost component can increase) |
| `~> 1.2.0` | `>= 1.2.0` and `< 1.3.0` |

## References

| Thing | Syntax |
|---|---|
| Resource attribute | `aws_instance.web.id` |
| Data source attribute | `data.aws_ami.ubuntu.id` |
| Variable | `var.name` |
| Local | `local.prefix` |
| Module output | `module.net.vpc_id` |
| Count index | `count.index` |
| for_each key/value | `each.key`, `each.value` |
| Self (in provisioners/conditions) | `self.attr` |
| Path helpers | `path.module`, `path.root`, `path.cwd` |
| CLI workspace | `terraform.workspace` |

## Types

| Kind | Types |
|---|---|
| Primitive | `string`, `number`, `bool` |
| Collection | `list(type)`, `set(type)`, `map(type)` |
| Structural | `object({ a = string, b = number })`, `tuple([string, number])` |
| Any | `any` |

## Variable block options

```hcl
variable "env" {
  type        = string
  default     = "dev"
  description = "Deployment environment"
  nullable    = false
  sensitive   = false
  ephemeral   = false          # true => never persisted to state/plan

  validation {
    condition     = contains(["dev", "prod"], var.env)
    error_message = "Must be dev or prod."
  }
}
```

## Meta-arguments

| Meta-argument | Where | Purpose |
|---|---|---|
| `count` | resource, module | N copies, `count.index` |
| `for_each` | resource, module | One per map key / set element |
| `depends_on` | resource, module, data, output | Explicit dependency |
| `provider` | resource | Choose aliased provider |
| `providers` | module | Pass providers to a child module |
| `lifecycle` | resource | See below |

### lifecycle

```hcl
lifecycle {
  create_before_destroy = true
  prevent_destroy       = true
  ignore_changes        = [tags, ami]
  replace_triggered_by  = [aws_security_group.web.id]

  precondition  { condition = ...  error_message = "..." }
  postcondition { condition = ...  error_message = "..." }
}
```

## Expressions

```hcl
# Conditional
size = var.env == "prod" ? "large" : "small"

# for expressions
upper_names = [for n in var.names : upper(n)]
name_map    = { for n in var.names : n => length(n) }
filtered    = [for k, v in var.map : k if v > 1]

# Splat
ids = aws_instance.web[*].id

# Dynamic block
dynamic "ingress" {
  for_each = var.ports
  content {
    from_port = ingress.value
    to_port   = ingress.value
    protocol  = "tcp"
  }
}
```

## Commonly seen functions

| Category | Functions |
|---|---|
| String | `upper`, `lower`, `format`, `join`, `split`, `replace`, `trimspace`, `substr`, `regex` |
| Collection | `length`, `concat`, `merge`, `flatten`, `keys`, `values`, `lookup`, `element`, `contains`, `distinct`, `slice`, `zipmap` |
| Type | `tolist`, `toset`, `tomap`, `tostring`, `tonumber` |
| Numeric | `min`, `max`, `ceil`, `floor`, `abs` |
| Filesystem | `file`, `templatefile`, `fileexists`, `filebase64` |
| Encoding | `jsonencode`, `jsondecode`, `yamlencode`, `base64encode` |
| Network | `cidrsubnet`, `cidrhost` |
| Error-handling | `try`, `can`, `coalesce` |
| Date/time | `timestamp`, `timeadd`, `formatdate` |

Test any expression interactively: `terraform console`.

## Ephemeral values and write-only arguments (Terraform 1.10+ / 1.11+)

```hcl
variable "db_password" {
  type      = string
  sensitive = true
  ephemeral = true           # not stored in state or plan files
}

# Ephemeral resource (read at run time, never persisted)
ephemeral "aws_secretsmanager_secret_version" "db" {
  secret_id = "prod/db"
}

# Write-only argument (provider-defined; sent to API, never stored)
# resource "aws_db_instance" "db" {
#   password_wo         = ephemeral.aws_secretsmanager_secret_version.db.secret_string
#   password_wo_version = 1
# }
```

Ephemeral values can only be used in ephemeral contexts (other ephemeral resources, provider config, write-only arguments, ephemeral outputs/variables). Check each provider's docs for supported write-only arguments.
