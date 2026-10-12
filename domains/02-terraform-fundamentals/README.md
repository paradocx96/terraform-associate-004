# Domain 2 - Terraform Fundamentals

**Objectives:** 2a Install and version providers · 2b How Terraform uses providers · 2c Multiple providers · 2d How Terraform uses and manages state

**Estimated study time:** 4–5 hours · **Lab:** [Lab 01](../../labs/lab-01-hello-terraform/README.md)
**Practice:** [`practice/02-terraform-fundamentals.md`](../../practice/02-terraform-fundamentals.md)

---

## 2a/2b. Providers

A **provider** is a plugin (a separate binary) that knows how to talk to one platform's API. Terraform core doesn't know about AWS or Azure; providers do.

### How providers are installed

`terraform init` reads `required_providers`, downloads provider binaries (by default from the public **Terraform Registry**, `registry.terraform.io`) into `.terraform/`, and records selections in `.terraform.lock.hcl`.

```hcl
terraform {
  required_version = ">= 1.9.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"   # [hostname/]namespace/type
      version = "~> 6.0"
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 3.6.0, < 4.0.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}
```

- **Source address:** `namespace/type` (e.g., `hashicorp/aws`). Full form: `registry.terraform.io/hashicorp/aws`.
- **Provider tiers on the Registry:** *Official* (HashiCorp), *Partner* (technology partners), *Community*.
- **Resource type prefix** = provider local name: `aws_instance` → provider `aws`.

### Version constraints

| Constraint | Allows |
|---|---|
| `= 5.2.0` | exactly 5.2.0 |
| `>= 5.0` | 5.0 or newer |
| `~> 5.2` | ≥ 5.2 and < 6.0 |
| `~> 5.2.0` | ≥ 5.2.0 and < 5.3.0 |
| `>= 5.0, < 6.0` | range |

### The dependency lock file

`.terraform.lock.hcl` pins the **exact** provider versions (and hashes) selected during `init`.

- **Commit it to version control** so everyone/CI use identical provider builds.
- `terraform init` honours the lock file. To move to newer versions allowed by your constraints: `terraform init -upgrade`.
- Changing a constraint so the locked version no longer fits → `init` errors until you `-upgrade`.

### Terraform CLI version

`required_version` in the `terraform` block restricts which CLI versions can run the configuration.

Managing Terraform versions (learning-path tutorial "Manage Terraform versions"):

- `required_version` accepts the same constraint operators as providers (`>= 1.9.0, < 2.0.0`).
- Use a version manager (e.g., `tfenv`) or package manager to switch CLI versions locally.
- In **HCP Terraform**, each workspace has its own Terraform version setting (see Domain 8).
- Provider and CLI versions are independent: `required_version` → CLI; `required_providers` → providers.
- The `terraform` block is also where `backend`/`cloud` and `required_providers` live.

## 2c. Multiple providers

**Different providers** in one config: just declare each in `required_providers`.

**Same provider, multiple configurations** (e.g., two regions): use `alias`.

```hcl
provider "aws" {
  region = "us-east-1"
}

provider "aws" {
  alias  = "west"
  region = "us-west-2"
}

resource "aws_s3_bucket" "east" {
  bucket = "demo-east-12345"
}

resource "aws_s3_bucket" "west" {
  provider = aws.west            # select aliased provider
  bucket   = "demo-west-12345"
}
```

- A provider block without `alias` is the **default** for that provider.
- Child modules inherit default providers; use `providers = { aws = aws.west }` in the `module` block to pass an alias.

## 2d. State fundamentals

**State** is a JSON file (default `terraform.tfstate`) in which Terraform records the real-world resources it manages.

Why Terraform needs state:

1. **Mapping** config blocks to real resource IDs.
2. **Metadata** (dependencies, provider info, resource ordering for destroy).
3. **Performance** - caching attribute values so large infrastructures don't require querying every resource every time (you can skip refresh with `-refresh=false`).
4. **Collaboration** - shared state is the team's source of truth (via remote backends).

Critical properties:

- State may contain **sensitive values in plaintext** (passwords, keys, even if marked `sensitive`). Protect and encrypt it.
- **Never edit state by hand.** Use `terraform state` subcommands, `moved`/`removed` blocks, `import`.
- **Never commit state to Git.**
- Local state is fine for learning; use a remote backend for teams (see Domain 6).

## Exam traps

- Provider *version* constraints live in `required_providers`; the *CLI* constraint is `required_version`.
- The lock file is **committed**; `.terraform/` is **not**.
- `terraform init -upgrade` upgrades providers within constraints; it doesn't ignore constraints.
- Provider **alias** is how you use one provider with different configs (regions, accounts).
- `sensitive = true` does not encrypt state.

## Self-check

1. What does `~> 3.2.0` allow? What about `~> 3.2`?
2. Where does `terraform init` download providers from by default?
3. Name four reasons Terraform uses state.
4. How do you deploy to two AWS regions from one configuration?

## Further reading

- <https://developer.hashicorp.com/terraform/language/providers/requirements>
- <https://developer.hashicorp.com/terraform/language/files/dependency-lock>
- <https://developer.hashicorp.com/terraform/language/state/purpose>
