# Domain 1 - IaC Concepts (Practice)

**Q1.** Which statement best describes a *declarative* approach to infrastructure?

- A) You list every step needed, in order, to create each resource
- B) You describe the desired end state and the tool determines the steps
- C) You write shell scripts that call cloud CLIs
- D) You manually create resources and record them in a spreadsheet

<details><summary>Answer</summary>

**B.** Declarative IaC describes the desired end state; Terraform compares it with the current state and computes the actions.
</details>

**Q2.** (Choose two) Which are advantages of IaC?

- A) Infrastructure changes can be reviewed in version control
- B) Environments can be reproduced consistently
- C) State files are no longer needed
- D) Cloud providers become interchangeable with no code changes

<details><summary>Answer</summary>

**A and B.** C is false (Terraform needs state). D is false: resource types differ between providers.
</details>

**Q3.** How does Terraform manage resources on many different platforms using one workflow?

- A) A single built-in resource type works on every cloud
- B) Providers translate configuration into each platform's API calls
- C) It converts HCL into CloudFormation templates
- D) It requires a separate CLI per platform

<details><summary>Answer</summary>

**B.** Providers are plugins that implement resources and data sources for each platform.
</details>

**Q4.** Terraform is primarily categorised as which type of tool?

- A) Configuration management (installing software inside servers)
- B) Infrastructure provisioning / orchestration
- C) Container runtime
- D) CI server

<details><summary>Answer</summary>

**B.** Terraform provisions and manages infrastructure resources. Configuration management tools (Ansible, Chef, Puppet) configure software on machines.
</details>

**Q5.** You run `terraform apply` twice in a row with no configuration changes. What should happen on the second run?

- A) Everything is destroyed and recreated
- B) Duplicate resources are created
- C) No changes are made
- D) Terraform asks you to re-initialise

<details><summary>Answer</summary>

**C.** Idempotency: when real infrastructure already matches the configuration, Terraform reports "No changes".
</details>

**Q6.** True or false: Terraform can only manage public cloud infrastructure.

<details><summary>Answer</summary>

**False.** Providers exist for public clouds, private/on-prem platforms (e.g., VMware), and SaaS services (DNS, monitoring, version control, etc.), enabling hybrid and service-agnostic workflows.
</details>
