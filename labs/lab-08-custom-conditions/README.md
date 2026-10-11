# Lab 08 — Custom Conditions

**Objectives:** 4g (and 4f lifecycle context) · **Needs:** Terraform CLI only

## Steps

1. `terraform init`
2. `terraform plan -var port=80` → variable validation fails. Note the message and when it fails (before any resource work).
3. `terraform plan -var port=8080` → precondition fails.
4. `terraform apply -var port=9000` → success.
5. **check block vs precondition:** edit the `check` block's condition to something that fails (e.g. `var.port > 10000` with port 9000). Apply again. Observe it **warns** but the run **continues**.
6. **postcondition:** change the postcondition to `condition = self.content == ""` (which is false for this file). Observe that a failing postcondition **fails the run**, after the resource was evaluated.
7. Add `lifecycle { prevent_destroy = true }` to `local_file.cfg`, then try `terraform destroy`. Read the error. Remove it again.
8. Add `create_before_destroy = true` and change `filename` to force replacement; read the plan symbol (`+/-`).
9. Clean up: `terraform destroy -var port=9000`

## Reading task: ephemeral values and write-only arguments

Open `docs/06-hcl-cheatsheet.md` ("Ephemeral values and write-only arguments"). Explain in your own words:

- Why `sensitive` isn't enough to keep a secret out of state.
- What can an ephemeral value be used for, and where is it *not* allowed?
- What does a write-only argument do?

## Check yourself

- [ ] I can list the four custom-condition mechanisms and which ones block a run.
- [ ] I can explain when `precondition` vs `postcondition` is evaluated.
- [ ] I can explain `ephemeral` vs `sensitive`.
