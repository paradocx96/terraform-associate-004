# 10 - Coverage Matrix

Maps every official objective in the **Exam Content List (004)** to where this repo covers it, and to the official **Learning Path** resources you should still open. "Official docs" = the pages HashiCorp lists for that objective; this repo summarises them but does not replace them.

Legend: ✅ covered in notes + practice · 🧪 also has a lab

| Obj | Topic | Repo notes | Lab / practice | Official reading still worth doing |
|---|---|---|---|---|
| 1a | What IaC is | Domain 1 ✅ | `practice/01` | What is Terraform?, IaC in private/public cloud |
| 1b | IaC advantages | Domain 1 ✅ | `practice/01` | Why Terraform |
| 1c | Multi-cloud / hybrid | Domain 1 ✅ | `practice/01` | Multi-Cloud Deployment |
| 2a | Install & version providers | Domain 2 ✅ | 🧪 Lab 01, `practice/02` | Lock & Upgrade Provider Versions tutorial, Provider Requirements, Dependency Lock File |
| 2b | How providers work | Domain 2 ✅ | 🧪 Lab 01 | How Terraform Works with Plugins |
| 2c | Multiple providers | Domain 2 ✅ | 🧪 Lab 06 | Provider Block Reference (`alias`) |
| 2d | State | Domain 2 ✅ | 🧪 Lab 05 | Purpose of Terraform State |
| 3a–3g | Workflow, init, validate, plan, apply, destroy, fmt | Domain 3 ✅ (incl. auto-refresh, `-target`, graph) | 🧪 Lab 01, `practice/03` | Create a Plan, Apply, Destroy tutorials; Resource Graph |
| 4a | resource vs data | Domain 4 ✅ | 🧪 Labs 01/06 | Query Data Sources tutorial |
| 4b | References / addressing | Domain 4 ✅ | 🧪 Lab 03 | Resource Addressing, References to Named Values |
| 4c | Variables & outputs | Domain 4 ✅ | 🧪 Lab 02 | Variables tutorial, Output tutorial |
| 4d | Complex types | Domain 4 ✅ | 🧪 Lab 03 | Type Constraints |
| 4e | Expressions & functions | Domain 4 ✅ + HCL cheat sheet | 🧪 Lab 03 | Built-in Functions reference (browse the categories) |
| 4f | `depends_on`, `create_before_destroy` | Domain 4 ✅ | 🧪 Lab 08 | Create Resource Dependencies, Manage Resource Lifecycle |
| 4g | Custom conditions | Domain 4 ✅ | 🧪 Lab 08 | Validate Modules with Custom Conditions, Use Checks tutorials |
| 4h | Sensitive data, ephemeral, write-only, Vault | Domain 4 ✅ | 🧪 Lab 02/08 (reading task) | Manage Sensitive Data, Protect Sensitive Input Variables, Inject Secrets with Vault provider tutorial |
| 5a–5d | Module sources, scope, use, versions | Domain 5 ✅ (incl. composition, structure) | 🧪 Lab 04, `practice/05` | Use Registry Modules tutorial, Module Composition |
| 6a | Local backend | Domain 6 ✅ | 🧪 Lab 05 | Backend Type: local |
| 6b | Locking | Domain 6 ✅ | 🧪 Lab 05/06 | State Storage and Locking |
| 6c | Remote backend block | Domain 6 ✅ | 🧪 Lab 06 | Backend Block Configuration |
| 6d | Drift, refactor state | Domain 6 ✅ | 🧪 Lab 05 | Manage Resource Drift, Use Refresh-Only Mode tutorials |
| 7a | Import | Domain 7 ✅ | 🧪 Lab 06 | Import Terraform Configuration tutorial |
| 7b | Inspect state | Domain 7 ✅ | 🧪 Lab 05 | State command docs |
| 7c | Verbose logging | Domain 7 ✅ (+ four error types) | `practice/07` | Troubleshoot Terraform tutorial |
| 8a | Create infra with HCP Terraform | Domain 8 ✅ | 🧪 Lab 07 | HCP Terraform Get Started collection |
| 8b | Collaboration & governance | Domain 8 ✅ | 🧪 Lab 07 (tour) | Explorer, Private Registry, Change Requests, Policy (Sentinel/OPA), Health, Teams, Dynamic Credentials, Drift Detection tutorials |
| 8c | Workspaces & projects | Domain 8 ✅ | 🧪 Lab 07 | Run Triggers, Projects, Variable Sets tutorials |
| 8d | CLI integration | Domain 8 ✅ | 🧪 Lab 07 | Use HCP Terraform with the CLI, Migrate State to HCP Terraform |

## Honest limits of this coverage

- Notes are **summaries**; the exam is written against HashiCorp's docs. Skim each "official reading" page for the objectives you miss in practice.
- HCP Terraform is the hardest domain to learn from notes alone. Lab 07 needs a real account; some features depend on plan tier, so **read** those docs even if you can't click through them.
- Practice questions are original. Use HashiCorp's official sample questions and at least one external practice-exam provider too.
- Provider-specific details (AWS etc.) are not tested, but Lab 06 uses AWS for illustration.
