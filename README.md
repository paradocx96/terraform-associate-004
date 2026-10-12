# HashiCorp Certified: Terraform Associate (004) — Study Repository

![Exam](https://img.shields.io/badge/Exam-Terraform%20Associate%20004-7B42BC?logo=terraform&logoColor=white)
![Terraform](https://img.shields.io/badge/Terraform-1.12-623CE4?logo=terraform&logoColor=white)
![Level](https://img.shields.io/badge/Level-Beginner%20→%20Certified-blue)
![Format](https://img.shields.io/badge/Docs-Markdown-informational)
![License](https://img.shields.io/badge/License-MIT-green)

A beginner-friendly, hands-on preparation kit for the **HashiCorp Certified: Terraform Associate (004)** exam. It covers the full study plan, domain-by-domain notes, labs, cheat sheets, and original practice questions.

> **Heads-up:** Exam details (price, version, objectives) can change. Always confirm on the official pages listed in [`docs/03-study-materials.md`](docs/03-study-materials.md) before booking.

---

## Table of Contents

1. [Quick Facts](#quick-facts)
2. [Where to Start](#where-to-start)
3. [Repository Structure](#repository-structure)
4. [Domains at a Glance](#domains-at-a-glance)
5. [Study Plan Options](#study-plan-options)
6. [Labs](#labs)
7. [Practice Questions](#practice-questions)
8. [Progress Tracker](#progress-tracker)
9. [Prerequisites](#prerequisites)
10. [Contributing](#contributing)
11. [License](#license)

---

## Quick Facts

| Item | Detail |
|---|---|
| Exam | HashiCorp Certified: Terraform Associate (**004**) |
| Terraform version tested | **1.12** |
| Format | Online proctored, multiple choice |
| Duration | 60 minutes |
| Questions | ~57 (community-reported; not guaranteed) |
| Price | $70.50 USD + local taxes/fees (at time of writing) |
| Validity | 2 years |
| Cloud-specific knowledge | **Not required** — the exam tests Terraform itself |
| Replaced | 003 exam (retired Jan 8, 2026) |

Full details: [`docs/00-exam-overview.md`](docs/00-exam-overview.md)

---

## Where to Start

New to Terraform? Follow this order:

1. [`docs/01-quick-start.md`](docs/01-quick-start.md) — the 1-page "what do I actually need to know" overview
2. [`docs/02-study-plan.md`](docs/02-study-plan.md) — pick the 6-week plan (recommended), 4-week fast track, or 2-week revision plan
3. [`domains/`](domains/) — read one domain, then do its lab and its practice questions
4. [`docs/04-exam-strategy.md`](docs/04-exam-strategy.md) — the week before the exam

---

## Repository Structure

```
terraform-associate-004-prep/
├── README.md
├── LICENSE
├── .gitignore
├── docs/
│   ├── 00-exam-overview.md        # Format, domains, 003 vs 004 changes, registration
│   ├── 01-quick-start.md          # The 80/20 overview + mental model
│   ├── 02-study-plan.md           # 6-week / 4-week / 2-week plans
│   ├── 03-study-materials.md      # Official + community resources
│   ├── 04-exam-strategy.md        # Time management, traps, exam-day checklist
│   ├── 05-cli-cheatsheet.md       # Commands and flags
│   ├── 06-hcl-cheatsheet.md       # Syntax, types, functions, meta-arguments
│   ├── 07-glossary.md             # Terms you must recognise
│   ├── 08-objective-checklist.md  # All 37 objectives as a checklist
│   ├── 09-final-notes.md
│   └── 10-coverage-matrix.md     # Objective → repo files → official reading
├── domains/
│   ├── 01-iac-concepts/
│   ├── 02-terraform-fundamentals/
│   ├── 03-core-workflow/
│   ├── 04-configuration/
│   ├── 05-modules/
│   ├── 06-state-management/
│   ├── 07-maintain-infrastructure/
│   └── 08-hcp-terraform/
├── labs/                          # Hands-on exercises (most need NO cloud account)
└── practice/                      # Original practice Q&A per domain + rapid-fire
```

---

## Domains at a Glance

| # | Domain | Objectives | Notes |
|---|---|---|---|
| 1 | [Infrastructure as Code (IaC) with Terraform](domains/01-iac-concepts/README.md) | 1a–1c | Concepts, short |
| 2 | [Terraform fundamentals](domains/02-terraform-fundamentals/README.md) | 2a–2d | Providers + state basics |
| 3 | [Core Terraform workflow](domains/03-core-workflow/README.md) | 3a–3g | init / validate / plan / apply / destroy / fmt |
| 4 | [Terraform configuration](domains/04-configuration/README.md) | 4a–4h | **Largest domain — most study time** |
| 5 | [Terraform modules](domains/05-modules/README.md) | 5a–5d | Sources, scope, versions |
| 6 | [Terraform state management](domains/06-state-management/README.md) | 6a–6d | Backends, locking, drift |
| 7 | [Maintain infrastructure](domains/07-maintain-infrastructure/README.md) | 7a–7c | Import, state CLI, logging |
| 8 | [HCP Terraform](domains/08-hcp-terraform/README.md) | 8a–8d | Workspaces, projects, policy — new emphasis in 004 |

---

## Study Plan Options

| Plan | Pace | Best for |
|---|---|---|
| **6 weeks** (recommended) | ~8–10 h/week | Beginners to Terraform |
| 4 weeks | ~12–15 h/week | Some IaC/cloud background |
| 2 weeks revision | ~2 h/day | Already hands-on, final polish |

See [`docs/02-study-plan.md`](docs/02-study-plan.md).

---

## Labs

| Lab | Topic | Needs cloud account? |
|---|---|---|
| [01](labs/lab-01-hello-terraform/README.md) | First config, providers, workflow | No |
| [02](labs/lab-02-variables-outputs/README.md) | Variables, locals, outputs, precedence | No |
| [03](labs/lab-03-count-for-each/README.md) | `count`, `for_each`, `for` expressions | No |
| [04](labs/lab-04-modules/README.md) | Local modules, inputs/outputs | No |
| [05](labs/lab-05-state-management/README.md) | State CLI, `moved`/`removed`, drift, backend migration | No |
| [06](labs/lab-06-aws-optional/README.md) | AWS provider, data sources, `dynamic`, import, S3 backend | Optional (AWS) |
| [07](labs/lab-07-hcp-terraform/README.md) | HCP Terraform workspaces, projects, variable sets | HCP account |
| [08](labs/lab-08-custom-conditions/README.md) | Validation, pre/postconditions, `check` blocks | No |

---

## Practice Questions

All questions in [`practice/`](practice/) are **original** study questions written for this repo. They are **not** real exam questions. Use HashiCorp's official sample questions as the reference for style (link in [`practice/README.md`](practice/README.md)).

---

## Progress Tracker

Tick off objectives in [`docs/08-objective-checklist.md`](docs/08-objective-checklist.md). See [`docs/10-coverage-matrix.md`](docs/10-coverage-matrix.md) for how each objective maps to this repo and the official reading.

- [ ] Week 1 complete
- [ ] Week 2 complete
- [ ] Week 3 complete
- [ ] Week 4 complete
- [ ] Week 5 complete
- [ ] Week 6 complete
- [ ] Scored 85%+ on three timed practice sets
- [ ] Exam booked
- [ ] Passed 🎉

---

## Prerequisites

- A laptop with a terminal (Linux, macOS, or Windows + WSL)
- [Terraform CLI](https://developer.hashicorp.com/terraform/install) installed (1.12+ recommended)
- A code editor (VS Code + HashiCorp Terraform extension)
- Git
- *(Optional)* AWS account for Lab 06, HCP Terraform account for Lab 07

---

## Contributing

Spotted an error or outdated detail? Open an issue or PR. Please link the official documentation page that supports the change.

## License

[MIT](LICENSE)
