# Lab 05 - State Management, Drift and Refactoring

**Objectives:** 2d, 6a–6d, 7b · **Needs:** Terraform CLI only

## Part 1 - Inspect state

1. `terraform init && terraform apply`
2. `terraform state list`, `terraform state show local_file.a`, `terraform show`
3. Open `terraform.tfstate` and find: `serial`, `lineage`, `resources[]`, attributes.

## Part 2 - Drift

1. Delete `out/b.txt` manually (simulating an out-of-band change).
2. `terraform plan -refresh-only` - what does Terraform report?
3. `terraform plan` - what would a normal apply do? (Recreate the file: the config is the source of truth.)
4. Run `terraform apply -refresh-only` and confirm. Check `terraform state list` - b is gone from state.
5. `terraform apply` to recreate it.

## Part 3 - Rename without destroying (`moved`)

1. Rename `local_file.a` to `local_file.alpha` in `main.tf` (don't add a `moved` block yet) and `terraform plan` → destroy + create.
2. Add:

```hcl
moved {
  from = local_file.a
  to   = local_file.alpha
}
```

3. `terraform plan` → "has moved" with no replacement. Apply it.

## Part 4 - Stop managing without destroying (`removed`)

1. Delete the `local_file.b` resource block and add:

```hcl
removed {
  from = local_file.b

  lifecycle {
    destroy = false
  }
}
```

2. `terraform plan` / `apply`. The file `out/b.txt` should still exist, but it's no longer in state.

## Part 5 - Change the backend path (migration)

1. Add inside the `terraform {}` block:

```hcl
  backend "local" {
    path = "state/custom.tfstate"
  }
```

2. `terraform init -migrate-state` (answer `yes`). Confirm `state/custom.tfstate` exists.
3. Try a second terminal running `terraform apply` while the first waits at the confirmation prompt - observe the lock error. (`-lock-timeout`, `force-unlock` exist for stuck locks.)

## Part 6 - Clean up

`terraform destroy`

## Check yourself

- [ ] I can explain refresh-only vs normal apply for drift.
- [ ] I can refactor addresses with `moved` and stop managing with `removed`.
- [ ] I can describe what changes when a backend changes and why `init` is needed.
