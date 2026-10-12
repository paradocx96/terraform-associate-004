# Domain 5 — Modules (Practice)

**Q1.** What is the *root module*?

- A) A module stored in the registry
- B) The configuration in the working directory where you run Terraform
- C) The first module alphabetically
- D) A module with no variables

<details><summary>Answer</summary>

**B.**
</details>

**Q2.** (Choose two) Which are valid module sources?

- A) A local path such as `./modules/vpc`
- B) A Terraform Registry address such as `terraform-aws-modules/vpc/aws`
- C) A Docker image tag
- D) A Slack channel

<details><summary>Answer</summary>

**A and B.** Git, HTTP, S3 and GCS sources are also supported.
</details>

**Q3.** The `version` argument in a `module` block works with which sources?

- A) Local paths
- B) Any Git URL
- C) Modules from a registry (public or private)
- D) Every source type

<details><summary>Answer</summary>

**C.** For Git, use `?ref=` to pin a tag/branch/commit.
</details>

**Q4.** A child module needs a value from the root module's variable `env`. How is it supplied?

- A) The child automatically reads `var.env`
- B) You pass it as an argument in the `module` block to a variable declared in the child
- C) Using `global.env`
- D) Using `terraform.env`

<details><summary>Answer</summary>

**B.** Modules have isolated scope.
</details>

**Q5.** How does the root module use an attribute of a resource created inside a child module?

- A) `module.net.aws_vpc.main.id`
- B) The child defines an `output`, and the root references `module.net.<output_name>`
- C) By importing the state
- D) By using `data` blocks only

<details><summary>Answer</summary>

**B.**
</details>

**Q6.** You add a new `module` block that uses a registry module. What must you run before `plan`?

- A) `terraform get -upgrade` only
- B) `terraform init`
- C) `terraform fmt`
- D) `terraform refresh`

<details><summary>Answer</summary>

**B.** (`terraform get` also downloads modules, but `init` is the standard workflow.)
</details>

**Q7.** What repository naming convention is required to publish a module on the public Terraform Registry?

- A) `<provider>-<name>-module`
- B) `terraform-<PROVIDER>-<NAME>`
- C) `tf-<name>`
- D) `module-<name>`

<details><summary>Answer</summary>

**B.** e.g., `terraform-aws-vpc`, with semantic-version tags (`v1.0.0`).
</details>

**Q8.** How do you pin a Git-sourced module to a release?

- A) `version = "1.2.0"`
- B) Add `?ref=v1.2.0` to the source URL
- C) Use `tag = "v1.2.0"`
- D) It cannot be pinned

<details><summary>Answer</summary>

**B.**
</details>

**Q9.** Which is a recommended practice when composing modules?

- A) Nest modules as deeply as possible
- B) Keep hierarchies shallow and wire modules together in the root by passing outputs to inputs
- C) Declare `provider` blocks inside every reusable module
- D) Hard-code environment IDs inside modules

<details><summary>Answer</summary>

**B.** Reusable modules should leave provider configuration to the caller.
</details>
