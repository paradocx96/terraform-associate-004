# Domain 4 — Configuration (Practice)

**Q1.** What is the difference between a `resource` block and a `data` block?

- A) `data` creates resources; `resource` reads them
- B) `resource` manages infrastructure lifecycle; `data` reads existing information
- C) They are identical
- D) `data` can only be used in modules

<details><summary>Answer</summary>

**B.**
</details>

**Q2.** How do you reference the `id` attribute of a data source `aws_ami.ubuntu`?

- A) `aws_ami.ubuntu.id`
- B) `data.aws_ami.ubuntu.id`
- C) `data["aws_ami"].ubuntu.id`
- D) `var.aws_ami.ubuntu.id`

<details><summary>Answer</summary>

**B.** Data source references are prefixed with `data.`.
</details>

**Q3.** A variable `region` has default `us-east-1`. `TF_VAR_region=eu-west-1` is exported, `terraform.tfvars` sets `us-west-2`, and you run `terraform apply -var region=ap-south-1`. Which value is used?

- A) `us-east-1`
- B) `eu-west-1`
- C) `us-west-2`
- D) `ap-south-1`

<details><summary>Answer</summary>

**D.** `-var` / `-var-file` have the highest precedence.
</details>

**Q4.** What does `sensitive = true` on an output do?

- A) Encrypts the value in state
- B) Redacts the value in CLI output
- C) Prevents the module from using it
- D) Stores it in Vault

<details><summary>Answer</summary>

**B.** The value is still in state.
</details>

**Q5.** Which values can `for_each` accept?

- A) A list of strings
- B) A map or a set of strings
- C) Only a number
- D) Any type

<details><summary>Answer</summary>

**B.** Convert a list with `toset()`.
</details>

**Q6.** You create three resources with `count` from a list. You remove the first element of the list. What is the likely result?

- A) Only the first resource is destroyed
- B) Terraform shifts indices, causing changes/recreation of multiple resources
- C) Nothing changes
- D) Terraform errors

<details><summary>Answer</summary>

**B.** `count` is index-based; use `for_each` with stable keys to avoid this.
</details>

**Q7.** Resource A needs resource B to exist first, but A doesn't reference any attribute of B. What do you add to A?

- A) `depends_on = [B]` (using B's resource address)
- B) `count = 1`
- C) `provider = B`
- D) `lifecycle { prevent_destroy = true }`

<details><summary>Answer</summary>

**A.** `depends_on` declares an explicit dependency for hidden relationships.
</details>

**Q8.** What does `create_before_destroy = true` do?

- A) Creates a backup before destroying
- B) Creates the replacement resource before destroying the old one
- C) Prevents destroy permanently
- D) Creates resources in parallel

<details><summary>Answer</summary>

**B.**
</details>

**Q9.** Which custom condition produces only a warning if it fails and does not stop the run?

- A) Variable `validation`
- B) `precondition`
- C) `postcondition`
- D) `check` block assertion

<details><summary>Answer</summary>

**D.**
</details>

**Q10.** Which type is best for a variable that holds named servers, each with a `size` (string) and `count` (number)?

- A) `list(string)`
- B) `map(object({ size = string, count = number }))`
- C) `set(number)`
- D) `tuple([string])`

<details><summary>Answer</summary>

**B.**
</details>

**Q11.** (Choose two) Which are true about ephemeral values in Terraform 1.12 configuration?

- A) They are not persisted to state or plan files
- B) They can be used freely in any normal resource argument
- C) They are useful for handling secrets such as passwords or tokens
- D) They are the same as `sensitive = true`

<details><summary>Answer</summary>

**A and C.** B is false: they can be used only in ephemeral contexts (ephemeral resources, provider config, write-only arguments, etc.). D is false: `sensitive` still stores the value in state.
</details>

**Q12.** What is a *write-only argument*?

- A) An argument that can't be set by users
- B) An argument whose value is sent to the provider but never stored in state or plan
- C) A read-only data attribute
- D) A provisioner setting

<details><summary>Answer</summary>

**B.** Provider-specific (e.g., `password_wo` patterns); check provider docs.
</details>

**Q13.** Which is the best practice for Vault-based secrets with Terraform?

- A) Hard-code the secret in `.tf` files
- B) Prefer short-lived/dynamic credentials and protect state, since values read via normal data sources are stored in state
- C) Commit `terraform.tfvars` with secrets
- D) Disable state

<details><summary>Answer</summary>

**B.**
</details>

**Q14.** What does the `dynamic` block do?

- A) Generates repeated nested blocks from a collection
- B) Creates dynamic providers
- C) Defines runtime variables
- D) Enables hot reload

<details><summary>Answer</summary>

**A.**
</details>

**Q15.** Which function reads the contents of a local file as a string?

- A) `read()`
- B) `file()`
- C) `open()`
- D) `local()`

<details><summary>Answer</summary>

**B.** (`templatefile()` renders a template file with variables.)
</details>
