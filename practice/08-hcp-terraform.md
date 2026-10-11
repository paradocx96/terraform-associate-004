# Domain 8 — HCP Terraform (Practice)

**Q1.** How does an HCP Terraform workspace differ from a CLI workspace?

- A) They are identical
- B) An HCP Terraform workspace is a full environment (config, variables, state, runs, permissions); a CLI workspace is just a separate state instance within the same backend/config
- C) CLI workspaces provide access control
- D) HCP Terraform workspaces can't hold state

<details><summary>Answer</summary>

**B.**
</details>

**Q2.** Which block connects a configuration to HCP Terraform?

- A) `backend "s3"`
- B) `cloud`
- C) `provider "hcp"`
- D) `remote_state`

<details><summary>Answer</summary>

**B.** Inside the `terraform` block. (`terraform login` authenticates the CLI.)
</details>

**Q3.** What is the purpose of HCP Terraform *projects*?

- A) Group workspaces to organise them and manage access/settings (and share variable sets)
- B) Store provider binaries
- C) Replace workspaces
- D) Define module sources

<details><summary>Answer</summary>

**A.**
</details>

**Q4.** What is a *variable set*?

- A) A list of provider versions
- B) A reusable collection of variables that can be applied to multiple workspaces or projects
- C) A kind of module
- D) A state backup

<details><summary>Answer</summary>

**B.**
</details>

**Q5.** What does a *run trigger* do?

- A) Starts a run in a workspace when a source workspace completes an apply
- B) Runs `terraform fmt`
- C) Sends email
- D) Schedules destroy at midnight

<details><summary>Answer</summary>

**A.**
</details>

**Q6.** Where in the run lifecycle are Sentinel/OPA policy checks evaluated?

- A) Before init
- B) After plan and before apply
- C) After apply
- D) Only on destroy

<details><summary>Answer</summary>

**B.**
</details>

**Q7.** (Choose two) Which are benefits of HCP Terraform remote state?

- A) Automatic state locking
- B) State versions/history
- C) State is never sensitive
- D) State doesn't exist

<details><summary>Answer</summary>

**A and B.** State is also encrypted at rest and access-controlled — but still treat it as sensitive.
</details>

**Q8.** Which are the HCP Terraform run workflows?

- A) VCS-driven, CLI-driven, API-driven
- B) Local, edge, mesh
- C) Plan-only, apply-only, destroy-only
- D) Registry, backend, provider

<details><summary>Answer</summary>

**A.**
</details>

**Q9.** You run `terraform plan` against an HCP Terraform workspace. The run fails with missing cloud credentials even though they're set locally. Why?

<details><summary>Answer</summary>

With remote execution, the plan runs on HCP Terraform's infrastructure, not your machine. Credentials must be configured in the workspace (environment variables/variable sets) or provided via dynamic provider credentials.
</details>

**Q10.** What is the HCP Terraform private registry used for?

<details><summary>Answer</summary>

Sharing and versioning your organisation's internal modules (and providers) so teams can reuse approved building blocks.
</details>
