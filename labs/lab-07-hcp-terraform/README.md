# Lab 07 - HCP Terraform

**Objectives:** 8a–8d · **Needs:** a free HCP Terraform account (check current plan features), Terraform CLI. Uses the `local`/`random` providers via a tiny config - no cloud account needed.

> HCP Terraform UI and plan tiers change. If a step differs, follow the current official tutorials: <https://developer.hashicorp.com/terraform/tutorials/cloud-get-started>

## Part 1 - Create org + CLI-driven workspace

1. Sign up at HCP Terraform and create an **organization**.
2. In a new folder, create `main.tf`:

```hcl
terraform {
  required_version = ">= 1.9.0"

  cloud {
    organization = "YOUR_ORG"

    workspaces {
      name = "lab07-cli"
    }
  }

  required_providers {
    random = {
      source  = "hashicorp/random"
      version = "~> 3.6"
    }
  }
}

variable "greeting" {
  type    = string
  default = "hello"
}

resource "random_pet" "p" {
  prefix = var.greeting
}

output "pet" {
  value = random_pet.p.id
}
```

3. `terraform login` (browser opens; token stored locally).
4. `terraform init` → the workspace is created if missing.
5. `terraform plan` and `terraform apply`. Observe: the run executes **remotely**; view it in the UI (plan, apply, state versions).

## Part 2 - Variables and variable sets

1. In the workspace, add a **Terraform variable** `greeting = "hola"` and run again.
2. Create a **sensitive** variable (e.g., `token`) - observe that it can't be read back.
3. Create a **variable set** (e.g., `shared-tags`) and apply it to the organization or a project.

## Part 3 - Projects and run triggers

1. Create a **project** (e.g., `training`) and move your workspace into it.
2. Create a second workspace `lab07-downstream`.
3. In `lab07-downstream` → Settings → **Run triggers**, add `lab07-cli` as the source workspace.
4. Apply in `lab07-cli` and watch a run get queued automatically downstream.

## Part 4 - Migrate state

1. Create a tiny local-state config, apply it, then add the `cloud` block and run `terraform init`. Accept state migration. Verify the state appears in the workspace.

## Part 5 - Governance tour (read/click only)

Explore (some features need higher plan tiers): **Teams**, **Private registry**, **Policies** (Sentinel / OPA), **Run tasks**, **Health / drift detection**, **Explorer**, **Change requests**, **Cost estimation**, **Dynamic provider credentials**.

Write one sentence for each describing what problem it solves.

## Clean up

Queue a destroy plan in the workspace (Settings → Destruction and deletion), then delete workspaces you no longer need.

## Check yourself

- [ ] I can write a `cloud` block from memory.
- [ ] I can explain HCP Terraform workspaces vs CLI workspaces.
- [ ] I can explain projects, variable sets and run triggers.
- [ ] I know where policy checks sit in the run lifecycle (after plan, before apply).
