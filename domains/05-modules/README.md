# Domain 5 - Terraform Modules

**Objectives:** 5a How Terraform sources modules · 5b Variable scope · 5c Using modules · 5d Module versions

**Estimated study time:** 4–5 hours · **Lab:** [Lab 04](../../labs/lab-04-modules/README.md)
**Practice:** [`practice/05-modules.md`](../../practice/05-modules.md)

---

## What is a module?

A **module** is a directory containing `.tf` files. Every configuration has at least a **root module** (the working directory). A **child module** is one called from another module with a `module` block.

Why use modules: reuse, consistency, encapsulation, easier testing, team standards.

## 5a. Module sources

| Source | Example `source` value |
|---|---|
| Local path | `./modules/vpc` or `../shared/vpc` |
| Terraform Registry (public) | `terraform-aws-modules/vpc/aws` |
| Private registry (HCP Terraform) | `app.terraform.io/my-org/vpc/aws` |
| GitHub | `github.com/org/repo` |
| Generic Git | `git::https://example.com/vpc.git?ref=v1.2.0` |
| HTTP URL / archive | `https://example.com/vpc.zip` |
| S3 / GCS buckets | `s3::https://...` / `gcs::https://...` |

`terraform init` (or `terraform get`) downloads remote modules into `.terraform/modules/`.

## 5c. Using modules

```hcl
module "network" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 6.0"

  name = "demo"
  cidr = "10.0.0.0/16"
}

module "app" {
  source = "./modules/app"

  subnet_id = module.network.public_subnets[0]   # use a child output
  env       = var.environment
}
```

Module meta-arguments: `count`, `for_each`, `depends_on`, `providers`, plus `source` and `version`.

After adding/changing a module block (source or version) → run `terraform init` again.

Writing a module (standard layout):

```
modules/app/
├── main.tf        # resources
├── variables.tf   # inputs
├── outputs.tf     # outputs
└── README.md
```

## 5b. Variable scope within modules

- A module has its **own scope**. Child modules **cannot** read the parent's variables, locals or resources.
- **Inputs:** the child's `variable` blocks are set as arguments in the `module` block.
- **Outputs:** the parent can only read values the child exposes via `output`.
- Resource attributes inside a child are not directly accessible: `module.app.some_output` works, `module.app.aws_instance.x.id` does not.

```hcl
# modules/app/outputs.tf
output "instance_id" {
  value = aws_instance.this.id
}

# root main.tf
output "app_instance" {
  value = module.app.instance_id
}
```

Providers: child modules inherit the parent's default (non-aliased) provider configurations. Pass aliased ones with `providers = { aws = aws.west }`. Avoid defining `provider` blocks inside reusable modules.

## Module composition and best practices (learning-path docs)

- Keep module hierarchies **shallow/flat**; avoid deeply nested modules.
- Prefer **composition**: the root module wires small modules together by passing one module's outputs into another's inputs (`module.network.subnet_ids` → `module.app`).
- Use **encapsulation**: expose only what callers need via variables/outputs.
- Pass in existing objects (IDs, data source results) rather than hard-coding lookups inside the module, so it stays reusable.
- **Standard module structure:** `main.tf`, `variables.tf`, `outputs.tf`, `README.md`, optionally `modules/` and `examples/`.
- **Providers within modules:** reusable modules should not declare `provider` blocks; declare `required_providers` and let the caller configure providers (use `providers = { ... }` to pass aliases).

## 5d. Module versions

- `version` is supported **only** for modules from a **registry** (public or private). It accepts the same constraint syntax as providers (`~> 6.0`, `>= 5.0, < 7.0`).
- For Git sources, pin with `?ref=` (tag, branch or commit).
- For local paths, there is no version - you get whatever is on disk.
- Pin versions for repeatable builds; upgrade deliberately with `terraform init -upgrade`.

```hcl
module "s3" {
  source = "git::https://github.com/example/terraform-aws-s3.git?ref=v2.1.0"
}
```

## Publishing to the registry (awareness)

Public registry modules need a GitHub repo named `terraform-<PROVIDER>-<NAME>` (e.g., `terraform-aws-vpc`), with semantic-version tags (`v1.0.0`). HCP Terraform offers a **private registry** for internal modules and providers.

## Exam traps

- `version` argument doesn't work for local paths or generic Git sources.
- Module outputs are the *only* way to read child values.
- Parent variables are not automatically visible to children.
- New module block → re-run `terraform init`.
- A module's `count`/`for_each` creates multiple instances addressed `module.name[0]` / `module.name["key"]`.

## Self-check

1. Name four module source types.
2. How do you use a resource ID created inside a child module from the root?
3. How do you pin a Git module to a release?
4. Which command downloads modules?

## Further reading

- <https://developer.hashicorp.com/terraform/language/modules>
- <https://developer.hashicorp.com/terraform/language/block/module>
- <https://developer.hashicorp.com/terraform/tutorials/modules/module-use>
