# Lab 04 — Local Modules

**Objectives:** 5a–5d · **Needs:** Terraform CLI only

## Steps

1. `terraform init` — look inside `.terraform/modules/` (for local modules it records the module manifest).
2. `terraform apply`, then `terraform state list`. Note the addresses: `module.alice.local_file.greeting`, `module.team["bob"]...`.
3. **Scope test:** in the root `main.tf`, add `output "bad" { value = module.alice.local_file.greeting.filename }`. Run `validate` and read the error. Only declared outputs are accessible.
4. **Input test:** inside the module, reference `var.environment` (undefined). Understand why the parent's variables don't leak in.
5. Add an input `uppercase` (`bool`, default `false`) to the module, use a conditional in `content`, and set it from the root for `alice`.
6. Add a second `output` to the module and expose it through the root.
7. Rename `module "alice"` to `module "primary"` and run `plan` — see the destroy/create. Fix it with a `moved` block:

```hcl
moved {
  from = module.alice
  to   = module.primary
}
```

8. (Reading task) Look up a public registry module and identify: `source`, `version`, required inputs, outputs. Write the `module` block you'd use with `version = "~> X.Y"`.
9. `terraform destroy`.

## Check yourself

- [ ] I can explain why module outputs are the only way to read child values.
- [ ] I know `version` only works for registry modules; Git uses `?ref=`.
- [ ] I know to re-run `terraform init` after adding or changing a module.
