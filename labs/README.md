# Labs

Hands-on exercises. **Type the code yourself** — copying teaches nothing.

| Lab | Topic | Domains | Cloud account? | Time |
|---|---|---|---|---|
| 01 | First config, providers, workflow | 2, 3 | No | 45 min |
| 02 | Variables, locals, outputs, precedence | 4 | No | 60 min |
| 03 | `count`, `for_each`, `for` expressions | 4 | No | 60 min |
| 04 | Local modules | 5 | No | 60 min |
| 05 | State CLI, `moved`/`removed`, drift, backend migration | 6, 7 | No | 75 min |
| 06 | AWS provider, data sources, `dynamic`, import, S3 backend | 2, 4, 6, 7 | AWS (optional) | 90 min |
| 07 | HCP Terraform workspaces, projects, variable sets | 8 | HCP Terraform | 75 min |
| 08 | Custom conditions | 4 | No | 45 min |

Labs 01–05 and 08 use the `local` and `random` providers: free and safe, they only write files in the lab folder.

## Ground rules

1. Work in a **copy**: `cp -r labs/lab-01-hello-terraform ~/tf-practice/lab-01` (so Git stays clean).
2. Run `terraform fmt` and `terraform validate` frequently.
3. Always finish with `terraform destroy` (especially Lab 06).
4. **Break things on purpose**, then read the errors.
5. Never commit `*.tfstate`, `.terraform/`, or secrets (the repo `.gitignore` covers these).
