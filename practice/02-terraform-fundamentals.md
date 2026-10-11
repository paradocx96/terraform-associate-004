# Domain 2 — Terraform Fundamentals (Practice)

**Q1.** From where does `terraform init` download providers by default?

- A) The cloud vendor's website
- B) GitHub releases of each provider
- C) The public Terraform Registry (registry.terraform.io)
- D) The local `.terraform` directory

<details><summary>Answer</summary>

**C.** Unless a different source address or a mirror is configured, providers come from the public Terraform Registry.
</details>

**Q2.** Which provider versions satisfy the constraint `~> 3.2.0`?

- A) 3.2.0 and 3.2.9
- B) 3.2.0 through 3.9.9
- C) Any 3.x version
- D) Only exactly 3.2.0

<details><summary>Answer</summary>

**A.** `~> 3.2.0` allows only the rightmost component to increase: ≥ 3.2.0 and < 3.3.0. (`~> 3.2` would allow up to < 4.0.)
</details>

**Q3.** Which file records the exact provider versions selected by `terraform init`, and should be committed to version control?

- A) `terraform.tfstate`
- B) `.terraform.lock.hcl`
- C) `.terraform/providers.json`
- D) `terraform.tfvars`

<details><summary>Answer</summary>

**B.** The dependency lock file pins provider versions and checksums for consistent installs. Commit it; don't commit `.terraform/` or state.
</details>

**Q4.** Which command upgrades providers to the newest versions allowed by your version constraints?

- A) `terraform update`
- B) `terraform init -upgrade`
- C) `terraform apply -refresh-only`
- D) `terraform providers upgrade`

<details><summary>Answer</summary>

**B.**
</details>

**Q5.** You need to deploy resources to two AWS regions in the same configuration. What do you use?

- A) Two separate state files in one directory
- B) A provider block with an `alias`, then `provider = aws.<alias>` on resources
- C) The `region` argument on `terraform apply`
- D) Workspaces

<details><summary>Answer</summary>

**B.** Aliases allow multiple configurations of the same provider in one module.
</details>

**Q6.** (Choose two) Why does Terraform use state?

- A) To map configuration to real-world resource IDs
- B) To cache attribute values and improve performance on large infrastructures
- C) To store provider binaries
- D) To compile HCL into bytecode

<details><summary>Answer</summary>

**A and B.** State also stores metadata and dependency information.
</details>

**Q7.** True or false: marking a variable `sensitive = true` prevents its value from being stored in state.

<details><summary>Answer</summary>

**False.** It only redacts CLI output. Values are stored in plaintext in state, so state must be protected. (Ephemeral values are the mechanism that avoids persistence.)
</details>

**Q8.** Which setting restricts the Terraform CLI versions allowed to run a configuration?

- A) `required_providers`
- B) `required_version` in the `terraform` block
- C) `version` in the `provider` block
- D) `terraform_version` variable

<details><summary>Answer</summary>

**B.**
</details>
