# Lab 02 — Variables, Locals, Outputs and Precedence

**Objectives:** 4a–4d, 4g (validation), 4h (sensitive) · **Needs:** Terraform CLI only

## Steps

1. `terraform init`
2. `export TF_VAR_api_token=abc123` then `terraform apply`. Notice the `token` output is redacted: `terraform output token` vs `terraform output -raw token`.
3. Inspect `terraform.tfstate`. Can you find `abc123`? (Yes — `sensitive` redacts CLI output only. This is a key exam point.)
4. **Precedence experiment** — change `environment` using each method and note which wins:
   - default (`dev`)
   - `export TF_VAR_environment=staging`
   - create `terraform.tfvars` containing `environment = "prod"`
   - create `zz.auto.tfvars` containing `environment = "staging"`
   - `terraform plan -var environment=dev`
   - `terraform plan -var-file=example.tfvars -var environment=prod`
5. Trigger validation: `terraform plan -var environment=test` and read the error.
6. Add a new variable `ports` of type `list(number)` and an output using a `for` expression: `[for p in var.ports : p + 1000]`.
7. Use `terraform console` to try `upper("abc")`, `merge({a=1},{b=2})`, `length(var.tags)`.
8. `terraform destroy`.

## Expected precedence order (lowest → highest)

default → `TF_VAR_*` → `terraform.tfvars` → `terraform.tfvars.json` → `*.auto.tfvars` (alphabetical) → `-var` / `-var-file` (command-line order).

## Check yourself

- [ ] I can predict the final value of a variable given several sources.
- [ ] I can explain exactly what `sensitive = true` does and doesn't do.
- [ ] I can write a variable with a validation block from memory.
