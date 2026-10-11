# Domain 7 — Maintain Infrastructure (Practice)

**Q1.** Which configuration element lets you import an existing resource, show it in `plan`, and optionally generate configuration?

- A) `terraform import` CLI command
- B) `import` block
- C) `moved` block
- D) `data` block

<details><summary>Answer</summary>

**B.** Use `terraform plan -generate-config-out=generated.tf` to generate the configuration.
</details>

**Q2.** What does the legacy `terraform import ADDR ID` command do?

- A) Writes the resource configuration for you
- B) Adds the existing resource to state only; you must write the configuration
- C) Creates the resource
- D) Destroys and recreates the resource

<details><summary>Answer</summary>

**B.**
</details>

**Q3.** Which command lists all resource addresses in the state?

- A) `terraform state list`
- B) `terraform list`
- C) `terraform output`
- D) `terraform providers`

<details><summary>Answer</summary>

**A.**
</details>

**Q4.** Which command shows the recorded attributes of a single resource in state?

- A) `terraform state show ADDRESS`
- B) `terraform plan ADDRESS`
- C) `terraform graph`
- D) `terraform state pull ADDRESS`

<details><summary>Answer</summary>

**A.**
</details>

**Q5.** Which environment variable enables verbose logging, and which level is the most verbose?

- A) `TF_DEBUG`, `HIGH`
- B) `TF_LOG`, `TRACE`
- C) `TF_VERBOSE`, `MAX`
- D) `TF_LOG`, `ERROR`

<details><summary>Answer</summary>

**B.** Levels: TRACE, DEBUG, INFO, WARN, ERROR. Use `TF_LOG_PATH` to write to a file.
</details>

**Q6.** Why should you be careful sharing Terraform debug logs?

<details><summary>Answer</summary>

They can contain sensitive information such as tokens, resource details, and API request/response data. Sanitise before sharing.
</details>

**Q7.** Which command prints the root module's output values after an apply?

- A) `terraform output`
- B) `terraform state outputs`
- C) `terraform values`
- D) `terraform console` only

<details><summary>Answer</summary>

**A.**
</details>
