# 03 - Study Materials

> Always prefer **official HashiCorp sources** for exam facts. Third-party courses vary in quality and date - confirm any course explicitly targets **004 / Terraform 1.12**, not 003.

## Official (start here - free)

| Resource | Why use it |
|---|---|
| [Associate exam content list (004)](https://developer.hashicorp.com/terraform/tutorials/certification-004/associate-review-004) | Every objective mapped to docs + tutorials. **Your master checklist.** |
| [Associate learning path (004)](https://developer.hashicorp.com/terraform/tutorials/certification-004/associate-study-004) | Start-to-finish tutorial sequence |
| [Associate sample questions (004)](https://developer.hashicorp.com/terraform/tutorials/certification-004/associate-questions-004) | Official question style |
| [Certification page](https://developer.hashicorp.com/certifications/infrastructure-automation) | Price, format, recertification |
| [Terraform documentation](https://developer.hashicorp.com/terraform/docs) | Source of truth for behaviour |
| [Terraform Registry](https://registry.terraform.io/) | Browse providers and modules; learn how docs are structured |
| [HCP Terraform docs](https://developer.hashicorp.com/terraform/cloud-docs) | Domain 8 |
| [Terraform sandbox](https://developer.hashicorp.com/terraform/sandbox) | Browser-based practice environment |
| [Well-Architected Framework](https://developer.hashicorp.com/well-architected-framework) | Best practices context |

## Video / interactive courses (paid or free - verify version)

Look for courses that mention **Terraform Associate 004**. Examples of providers that publish prep material (check current content and ratings before buying):

- KodeKloud - Terraform Associate course with labs (notes site covers 004)
- Udemy - hands-on courses and practice-exam series for 004 (multiple authors; read recent reviews and "last updated" dates)
- Whizlabs - prep guide and practice tests
- freeCodeCamp (YouTube) - good free Terraform foundations; older videos may target 003, so cross-check against the 004 content list

## Books

- *Terraform: Up & Running* - Yevgeniy Brikman (O'Reilly). Deeper than the exam but excellent for real-world habits.

## Practice exams

- Use **at least two** independent providers so you aren't memorising one author's wording.
- Beware "exam dumps" / "leaked questions". They are against HashiCorp's exam policies, frequently wrong, and teach you nothing. This repo's questions are original.
- Use practice exams to find weak objectives, not to memorise answers.

## Free hands-on options

| Option | Cost |
|---|---|
| `local`, `random`, `null`, `time` providers (Labs 01–05, 08) | Free, no account |
| Docker provider | Free (needs Docker) |
| AWS Free Tier (Lab 06) | Free if you destroy resources; set a budget alert |
| HCP Terraform account (Lab 07) | Check current plan limits on the HCP Terraform pricing page |

## Suggested editor setup

- VS Code + **HashiCorp Terraform** extension (syntax, formatting, validation)
- `terraform -install-autocomplete` for shell autocomplete
- Pre-commit hooks later: `terraform fmt -check`, `terraform validate`

## Reading order for official docs (beginner path)

1. What is Terraform? → Core workflow
2. Configuration language: resources, data sources, variables, outputs, locals
3. Expressions and functions
4. Modules
5. State: purpose, backends, locking
6. CLI: init, plan, apply, state, import
7. HCP Terraform: workspaces, projects, runs, policy
