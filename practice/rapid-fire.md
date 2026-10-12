# Rapid-Fire True / False

Cover the answers, say T or F out loud, then check. Do a batch of 10 a day.

| # | Statement | Answer |
|---|---|---|
| 1 | Terraform is a declarative IaC tool. | **T** |
| 2 | `terraform plan` can change real infrastructure. | **F** — it only previews |
| 3 | `terraform validate` contacts cloud APIs. | **F** |
| 4 | `terraform init` must be re-run after adding a new provider or module. | **T** |
| 5 | `.terraform.lock.hcl` should be committed to Git. | **T** |
| 6 | `terraform.tfstate` should be committed to Git. | **F** |
| 7 | `sensitive = true` keeps a value out of state. | **F** — only redacts CLI output |
| 8 | Ephemeral values are not written to state or plan files. | **T** |
| 9 | `for_each` accepts a plain list of strings. | **F** — map or set |
| 10 | `count` and `for_each` can be used together on one resource. | **F** |
| 11 | `data` blocks create new infrastructure. | **F** |
| 12 | `depends_on` is needed whenever resource A references B. | **F** — references create implicit dependencies |
| 13 | A child module can read the parent module's variables directly. | **F** |
| 14 | A parent module can read a child's resources directly without outputs. | **F** |
| 15 | The `version` argument works for local-path modules. | **F** |
| 16 | The `version` argument works for registry modules. | **T** |
| 17 | Git module sources can be pinned with `?ref=`. | **T** |
| 18 | `terraform apply tfplan` asks for confirmation. | **F** |
| 19 | `terraform destroy` equals `terraform apply -destroy`. | **T** |
| 20 | `terraform taint` is the recommended way to force replacement today. | **F** — use `apply -replace` |
| 21 | `terraform refresh` is deprecated in favour of `-refresh-only`. | **T** |
| 22 | The default backend is local. | **T** |
| 23 | Backend blocks can use input variables. | **F** |
| 24 | A configuration can have multiple backend blocks. | **F** |
| 25 | `moved` blocks let you rename a resource without destroying it. | **T** |
| 26 | `terraform state rm` deletes the real resource. | **F** — it only stops tracking it |
| 27 | `terraform force-unlock` should be used casually to bypass locks. | **F** — only for stuck locks |
| 28 | The `import` block can generate configuration with `plan -generate-config-out`. | **T** |
| 29 | The legacy `terraform import` command writes the resource block for you. | **F** |
| 30 | `TF_LOG=TRACE` is the most verbose level. | **T** |
| 31 | `TF_LOG_PATH` writes logs to a file. | **T** |
| 32 | HCP Terraform runs plan/apply remotely by default for CLI-driven workflows with the `cloud` block. | **T** |
| 33 | CLI workspaces and HCP Terraform workspaces are the same thing. | **F** |
| 34 | Projects group workspaces in HCP Terraform. | **T** |
| 35 | Variable sets can be shared across multiple workspaces. | **T** |
| 36 | Sentinel/OPA checks run after plan and before apply. | **T** |
| 37 | Terraform Enterprise is a self-hosted offering. | **T** |
| 38 | `check` blocks stop the run when assertions fail. | **F** — warnings |
| 39 | `precondition` failures stop the run. | **T** |
| 40 | `terraform fmt -check` exits non-zero if formatting is needed. | **T** |
| 41 | A provider `alias` lets you configure the same provider multiple times. | **T** |
| 42 | `required_version` constrains the Terraform CLI version. | **T** |
| 43 | `~> 1.2` allows 1.9 but not 2.0. | **T** |
| 44 | `-var` overrides values from `terraform.tfvars`. | **T** |
| 45 | `terraform.tfvars` overrides `-var`. | **F** |
| 46 | Provider-specific cloud knowledge is required for the exam. | **F** |
| 47 | `terraform output -raw NAME` prints a string without quotes. | **T** |
| 48 | `terraform console` lets you evaluate expressions. | **T** |
| 49 | Terraform supports user-defined functions in HCL. | **F** — built-in only |
| 50 | Destroy removes the state file from disk. | **F** — the file remains with updated contents |
| 51 | `terraform plan` and `terraform apply` refresh state by default. | **T** |
| 52 | `terraform validate` and `terraform output` refresh state. | **F** |
| 53 | `terraform apply` downloads provider plugins. | **F** — `init` does |
| 54 | `terraform.tfvars` is loaded automatically by `terraform plan`. | **T** |
| 55 | `prod.tfvars` is loaded automatically. | **F** — needs `-var-file` |
| 56 | `-target` is recommended for routine use. | **F** — exceptional situations only |
| 57 | HCP Terraform execution modes are Remote, Local and Agent. | **T** |
| 58 | Reusable modules should declare their own `provider` blocks. | **F** |
| 59 | Passwords referenced via variables still appear in plaintext in state. | **T** |
| 60 | The four troubleshooting error types are language, state, core and provider. | **T** |
