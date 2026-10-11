# Domain 1 — Infrastructure as Code (IaC) with Terraform

**Objectives:** 1a Explain what IaC is · 1b Advantages of IaC patterns · 1c Multi-cloud, hybrid cloud, service-agnostic workflows

**Estimated study time:** 2–3 hours · **Lab:** none (concepts) — do Lab 01 for context
**Practice:** [`practice/01-iac-concepts.md`](../../practice/01-iac-concepts.md)

---

## 1a. What is IaC?

Infrastructure as Code means defining servers, networks, databases, DNS, SaaS settings and more in **text files** that tools read and execute, instead of clicking through consoles or running ad-hoc scripts.

Key ideas:

- **Declarative vs imperative.** Terraform is *declarative*: you say "I want 3 servers behind a load balancer". The tool compares that to reality and works out the steps. Imperative scripts say "create server, then create another…" and you handle every edge case.
- **Idempotent.** Re-running gives the same end result. If nothing changed, nothing happens.
- **Version-controlled.** Infrastructure lives in Git: pull requests, reviews, history, rollbacks.
- **Reusable.** Same code → dev, staging, prod (with different variables).

### Where Terraform fits

| Tool type | Examples | Main job |
|---|---|---|
| **Provisioning / orchestration IaC** | Terraform, OpenTofu, CloudFormation, Pulumi, Bicep | Create and manage infrastructure resources |
| **Configuration management** | Ansible, Chef, Puppet | Configure software *inside* machines |
| **Image building** | Packer | Build machine images |

Terraform is cloud-agnostic and uses its own language (HCL). It can be combined with configuration-management tools.

## 1b. Advantages of IaC

| Advantage | Why it matters |
|---|---|
| **Consistency & repeatability** | Same code → same environment; reduces "works on my cloud" |
| **Speed** | Provision whole environments in minutes |
| **Version control & audit** | Who changed what, when, why |
| **Collaboration** | Code review, shared modules, CI/CD |
| **Reduced human error** | Less manual clicking |
| **Documentation as code** | Config *is* the documentation |
| **Cost control** | Easy to tear down (`terraform destroy`) temporary environments |
| **Drift detection** | Compare reality vs desired state |
| **Safe change** | `terraform plan` previews before applying |

## 1c. Multi-cloud, hybrid cloud and service-agnostic workflows

- Terraform's core is **provider-agnostic**. **Providers** are plugins that translate Terraform configuration into API calls for a platform.
- One configuration can use multiple providers: AWS + Cloudflare + Datadog + Kubernetes + GitHub.
- **Multi-cloud**: manage AWS, Azure, GCP with the *same workflow* (`init → plan → apply`), even though resource types differ per provider.
- **Hybrid cloud**: on-prem (VMware, OpenStack, etc.) plus public cloud via their providers.
- **Service-agnostic**: not only compute — DNS, monitoring, identity, SaaS, databases.
- Note: Terraform gives a **common workflow and language**, not a magic abstraction. A `aws_instance` is not interchangeable with `azurerm_linux_virtual_machine`.

```hcl
terraform {
  required_providers {
    aws        = { source = "hashicorp/aws" }
    cloudflare = { source = "cloudflare/cloudflare" }
  }
}
# One config can create an AWS load balancer AND the Cloudflare DNS record pointing to it.
```

## Exam traps

- Terraform is **not** primarily configuration management (that's Ansible/Chef/Puppet territory).
- Declarative ≠ "no ordering": Terraform still builds a **dependency graph** and orders operations.
- Multi-cloud = one workflow + many providers, not one resource type that works everywhere.
- IaC does **not** remove the need for state; Terraform relies on state.

## Self-check

1. In one sentence, why is `terraform plan` valuable?
2. Give two differences between declarative and imperative approaches.
3. Name three benefits of storing infrastructure code in Git.
4. How can one Terraform configuration manage AWS and Cloudflare?

## Further reading

- <https://developer.hashicorp.com/terraform/intro>
- <https://developer.hashicorp.com/terraform/tutorials/aws-get-started/infrastructure-as-code>
