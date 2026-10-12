# Domain 3 - Core Workflow (Practice)

**Q1.** What is the core Terraform workflow?

- A) Plan → Write → Apply
- B) Write → Plan → Apply
- C) Init → Destroy → Apply
- D) Validate → Import → Apply

<details><summary>Answer</summary>

**B.** Write, Plan, Apply (with `init` preparing the working directory first, and `destroy` when finished).
</details>

**Q2.** (Choose two) What does `terraform init` do?

- A) Installs required providers
- B) Applies the configuration
- C) Initialises the backend
- D) Formats the configuration

<details><summary>Answer</summary>

**A and C.** It also downloads modules and creates the lock file.
</details>

**Q3.** `terraform validate` will:

- A) Contact cloud APIs to ensure all names are available
- B) Check syntax and internal consistency without accessing remote services
- C) Apply the plan in dry-run mode
- D) Update state

<details><summary>Answer</summary>

**B.** It requires initialised providers/modules (`terraform init`, or `init -backend=false`) but doesn't access remote services or state.
</details>

**Q4.** Which statement about `terraform plan` is correct?

- A) It creates the resources but doesn't update state
- B) It shows proposed changes without modifying infrastructure
- C) It requires `-auto-approve`
- D) It permanently locks the state

<details><summary>Answer</summary>

**B.**
</details>

**Q5.** You saved a plan with `terraform plan -out=tfplan`. You then run `terraform apply tfplan`. What happens?

- A) Terraform recomputes a plan and asks for approval
- B) Terraform applies exactly the saved plan without prompting for approval
- C) The apply fails because plans can't be applied
- D) Terraform destroys infrastructure not in the plan

<details><summary>Answer</summary>

**B.** Applying a saved plan doesn't ask for interactive approval (you approved by reviewing/saving it). If state changed since the plan was created, apply fails as stale.
</details>

**Q6.** Which command is equivalent to `terraform destroy`?

- A) `terraform apply -destroy`
- B) `terraform plan -destroy -auto-approve`
- C) `terraform state rm`
- D) `terraform apply -replace`

<details><summary>Answer</summary>

**A.**
</details>

**Q7.** A CI pipeline should fail if any file isn't canonically formatted. Which command?

- A) `terraform validate -check`
- B) `terraform fmt -check`
- C) `terraform plan -format`
- D) `terraform fmt -destroy`

<details><summary>Answer</summary>

**B.** `-check` returns a non-zero exit code when changes would be made (often combined with `-recursive`).
</details>

**Q8.** You want Terraform to recreate one specific resource on the next apply without editing code. What do you use?

- A) `terraform apply -replace="aws_instance.web"`
- B) `terraform refresh`
- C) `terraform import`
- D) `terraform init -upgrade`

<details><summary>Answer</summary>

**A.** `-replace` supersedes the deprecated `terraform taint`.
</details>

## Official-style questions (based on HashiCorp's sample formats)

**Q9.** (Pick two) Which commands automatically refresh the state unless given additional flags?

- A) `terraform plan`
- B) `terraform state list`
- C) `terraform apply`
- D) `terraform validate`
- E) `terraform output`

<details><summary>Answer</summary>

**A and C.** `plan` and `apply` refresh by default (`-refresh=false` to skip).
</details>

**Q10.** (Pick two) What happens when you apply a Terraform configuration?

- A) Terraform makes the infrastructure changes defined in the configuration
- B) Terraform downloads the plugins the configuration requires
- C) Terraform updates the state file with the changes it made
- D) Terraform corrects formatting errors
- E) Terraform destroys and recreates all infrastructure

<details><summary>Answer</summary>

**A and C.** Plugins are downloaded by `init`; formatting is `fmt`.
</details>

**Q11.** When is `-target` appropriate?

- A) In every routine plan
- B) For exceptional situations, such as recovering from an error; Terraform warns that the rest of the configuration may be out of sync
- C) To skip provider installation
- D) To apply to a different workspace

<details><summary>Answer</summary>

**B.**
</details>
