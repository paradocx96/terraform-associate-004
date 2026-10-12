# Domain 6 - State Management (Practice)

**Q1.** What is the default backend and where is state stored?

- A) S3, in a default bucket
- B) Local backend, `terraform.tfstate` in the working directory
- C) HCP Terraform
- D) A hidden `.terraform/state` folder only

<details><summary>Answer</summary>

**B.**
</details>

**Q2.** What is the purpose of state locking?

- A) Encrypt state
- B) Prevent concurrent operations from writing the same state and corrupting it
- C) Prevent plan from running
- D) Lock provider versions

<details><summary>Answer</summary>

**B.**
</details>

**Q3.** Can a `backend` block reference `var.bucket_name`?

- A) Yes
- B) No - backend blocks can't use variables; use partial configuration (`-backend-config`)
- C) Yes, but only strings
- D) Yes, if `sensitive`

<details><summary>Answer</summary>

**B.**
</details>

**Q4.** You changed your configuration from the local backend to a remote backend. Which command migrates existing state?

- A) `terraform state push`
- B) `terraform init -migrate-state`
- C) `terraform apply -migrate`
- D) `terraform refresh`

<details><summary>Answer</summary>

**B.** (`terraform init` also prompts to copy the state when it detects a backend change.)
</details>

**Q5.** Someone deleted a managed resource in the cloud console. You want Terraform's state to reflect that without changing any infrastructure. Which command?

- A) `terraform apply -refresh-only`
- B) `terraform destroy`
- C) `terraform apply -replace`
- D) `terraform init -reconfigure`

<details><summary>Answer</summary>

**A.** (`plan -refresh-only` previews it.) A normal apply would try to recreate the resource.
</details>

**Q6.** Which command is deprecated in favour of `-refresh-only`?

- A) `terraform refresh`
- B) `terraform plan`
- C) `terraform output`
- D) `terraform show`

<details><summary>Answer</summary>

**A.**
</details>

**Q7.** You renamed `aws_instance.web` to `aws_instance.app` in config and don't want Terraform to destroy and recreate it. What do you add?

- A) A `moved` block
- B) A `removed` block
- C) `lifecycle { ignore_changes = all }`
- D) `terraform taint`

<details><summary>Answer</summary>

**A.**
</details>

**Q8.** You want to stop managing a resource with Terraform but keep it running in the cloud. What do you use?

- A) `removed` block with `lifecycle { destroy = false }` (or `terraform state rm`)
- B) `terraform destroy -target`
- C) `terraform import`
- D) `prevent_destroy = true`

<details><summary>Answer</summary>

**A.**
</details>

**Q9.** A previous run crashed and left the state locked. You're sure nobody else is running Terraform. What can you use?

- A) `terraform force-unlock LOCK_ID`
- B) `terraform state rm`
- C) `terraform init -upgrade`
- D) Delete the whole state file

<details><summary>Answer</summary>

**A.**
</details>
