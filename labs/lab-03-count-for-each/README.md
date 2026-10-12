# Lab 03 - `count`, `for_each` and `for` Expressions

**Objectives:** 4b, 4d, 4e · **Needs:** Terraform CLI only

## Steps

1. `terraform init && terraform apply`. List `out/` and run `terraform state list` - compare the addresses: `[0]`, `["alice"]`, `["one"]`.
2. **count pitfall:** change `names` to `["two", "three"]` (remove the first item). Run `terraform plan`. How many resources change, and why?
3. Restore the list, apply, then do the same removal for the `from_set` resources. Compare the plan for `for_each` - only the removed key is destroyed.
4. Try `for_each = var.names` (a list) in `from_set`. Read the error. Fix with `toset()`.
5. Add a new user `carol` with role `admin`; observe the plan (`+` for only that key). Check the `admins` output.
6. Try using both `count` and `for_each` on one resource and read the error.
7. Experiment in `terraform console`:
   - `[for n in var.names : upper(n)]`
   - `{ for n in var.names : n => length(n) }`
   - `local_file.user["alice"].filename`
8. `terraform destroy`.

## Check yourself

- [ ] I can explain why `for_each` is safer than `count` for most resources.
- [ ] I know `for_each` needs a map or a set of strings.
- [ ] I can write list and map `for` expressions with a filter.
