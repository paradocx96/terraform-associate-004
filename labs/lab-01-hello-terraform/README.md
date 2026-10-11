# Lab 01 — Hello Terraform

**Objectives:** 2a, 2b, 3a–3g · **Needs:** Terraform CLI only

## Steps

1. Copy this folder somewhere outside Git, `cd` into it.
2. `terraform init` — note the downloaded providers and the new `.terraform/` folder and `.terraform.lock.hcl`.
3. `terraform fmt` then `terraform validate`.
4. `terraform plan` — read the `+` lines. Which attribute is "known after apply"?
5. `terraform plan -out=tfplan`, then `terraform apply tfplan`. Was there a confirmation prompt?
6. Open the generated `hello-*.txt`. Run `terraform show`, `terraform output`, `terraform state list`.
7. Run `terraform plan` again → "No changes". (Idempotency.)
8. Replace one resource: `terraform apply -replace=random_pet.name`. What else got replaced, and why? (Dependency chain.)
9. Destroy: `terraform destroy`. Confirm the file is gone and look at `terraform.tfstate`.

## Break-it exercises

- Change the `random` constraint to `~> 2.0` and run `terraform init`. Read the error. Fix it, then try `terraform init -upgrade`.
- Delete `.terraform/` and run `plan`. What does Terraform tell you?
- Introduce a typo in an attribute name; run `validate`.
- Remove `.terraform.lock.hcl` and `init` again. What changed?

## Check yourself

- [ ] I can explain what each of init / plan / apply / destroy does.
- [ ] I know why `.terraform.lock.hcl` is committed but `.terraform/` isn't.
- [ ] I can explain the implicit dependency between the two resources.
