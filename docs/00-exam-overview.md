# 00 — Exam Overview

## Official facts (verify before booking)

| Item | Detail |
|---|---|
| Name | HashiCorp Certified: Terraform Associate (004) |
| Version of Terraform tested | 1.12 |
| Delivery | Online proctored |
| Question style | **True/false, multiple choice (one answer), and multiple answer** ("Pick the 2 correct responses"). HashiCorp states the questions are not meant to trick you. |
| Duration | 60 minutes |
| Price | $70.50 USD plus locally applicable taxes/fees (no free retake included) |
| Language | English |
| Validity | 2 years |
| Prerequisites | None mandatory |
| Passing score | Not officially published; community sources commonly report ~70%. Aim for **85%+** in practice. |
| Number of questions | Commonly reported as ~57. Treat as approximate. |

Official page: <https://developer.hashicorp.com/certifications/infrastructure-automation>

> Provider-specific (AWS/Azure/GCP) knowledge is **not required**. Tutorials use clouds only to demonstrate Terraform behaviour.

## Prerequisites (per HashiCorp)

- Basic terminal skills
- Basic understanding of on-premises and cloud architecture
- Best prepared with professional experience using Terraform in production, but performing the objectives in a **personal demo environment may be sufficient**
- The exam covers **Terraform Community Edition (CLI) and HCP Terraform** concepts

## Official question formats (from HashiCorp's sample questions)

| Format | Example topic in the official samples |
|---|---|
| True/false | Passwords referenced in code, even as variables, end up in plain text in state (**True**) |
| Multiple choice | Referencing a map variable value, e.g. `var.vpc_cidrs["us-east-1"]`; whether `terraform plan` auto-loads `terraform.tfvars` |
| Multiple answer | Which commands auto-refresh state (`plan`, `apply`); what happens when you apply (changes made + state updated) |

These topics are practised in `practice/` (look for the "official-style" questions).

## Who the exam is for

Cloud engineers with foundational Terraform knowledge: people who can write and run configurations, understand state, use modules, and know what HCP Terraform / Terraform Enterprise adds on top of the CLI.

## The 8 domains (37 objectives)

| # | Domain | Objectives |
|---|---|---|
| 1 | Infrastructure as Code (IaC) with Terraform | 1a Explain what IaC is · 1b Advantages of IaC patterns · 1c Multi-cloud, hybrid cloud, service-agnostic workflows |
| 2 | Terraform fundamentals | 2a Install and version providers · 2b How Terraform uses providers · 2c Multiple providers · 2d How Terraform uses and manages state |
| 3 | Core Terraform workflow | 3a Workflow · 3b init · 3c validate · 3d plan · 3e apply · 3f destroy · 3g fmt |
| 4 | Terraform configuration | 4a resource vs data · 4b References · 4c Variables and outputs · 4d Complex types · 4e Expressions and functions · 4f Resource dependencies · 4g Custom conditions · 4h Sensitive data and Vault |
| 5 | Terraform modules | 5a Module sources · 5b Variable scope · 5c Using modules · 5d Module versions |
| 6 | Terraform state management | 6a Local backend · 6b State locking · 6c Remote state / backend block · 6d Drift and state |
| 7 | Maintain infrastructure | 7a Import · 7b Inspect state with CLI · 7c Verbose logging |
| 8 | HCP Terraform | 8a Create infrastructure · 8b Collaboration and governance · 8c Workspaces and projects · 8d CLI integration |

**Where to spend time:** Domain 4 has the most objectives (8) and Domain 3 has 7. Domains 6, 7 and 8 are where beginners most often lose marks.

## What changed from 003 to 004

HashiCorp's summary of the update:

- Four new topics
  - **4f** `depends_on` and `create_before_destroy` lifecycle rules
  - **4g** Validate configuration using custom conditions
  - **4h** Ephemeral values and write-only arguments (HashiCorp's change summary lists this; the objective list also covers sensitive data and Vault — study both)
  - **8c** Organise and use HCP Terraform workspaces and projects
- Tests Terraform **1.12**
- HCP Terraform content is its own domain (8)

Source: <https://developer.hashicorp.com/terraform/tutorials/certification-004/associate-review-004>

## Registration steps

1. Create/sign in to your HashiCorp certification account via the certification portal.
2. Choose **Terraform Associate (004)** — not a retired 002/003 appointment.
3. Pick a date. Book once you are trending toward 85%+ on practice sets, but early enough to stay motivated.
4. Complete the proctoring system check on the **same computer and network** you'll use on exam day.
5. Prepare ID and a clear desk/room per the proctor's rules.

## After you pass

- Certification is valid for 2 years. HashiCorp lists recertification paths (retake 004 starting 6 months before expiry, or pass a higher-level exam) on the certification page.
- Next steps: Terraform Authoring and Operations Professional exam, plus real projects.
