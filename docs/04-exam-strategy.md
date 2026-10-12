# 04 - Exam Strategy

## Time management

- 60 minutes for roughly 57 questions ≈ **~1 minute per question**.
- First pass: answer what you know in ≤ 45 seconds; **flag** anything uncertain and move on.
- Reserve the last 10 minutes for flagged questions.
- Never leave a question blank.

## Reading questions

- Underline the **keyword**: *which command*, *which block*, *NOT*, *EXCEPT*, *best*, *first*.
- "Choose two/three" - count how many you must select before reviewing options.
- Eliminate options that are obviously another tool's feature (Ansible, CloudFormation) or a removed/deprecated command.
- True/false: look for absolutes ("always", "never", "only"). Terraform answers are rarely absolute - but some are (e.g., module `version` works only for registry sources).

## Classic traps

| Trap | Truth |
|---|---|
| "`sensitive = true` keeps secrets out of state" | No - only redacts CLI output. Values remain in state. |
| "`terraform plan` changes infrastructure" | Never. |
| "`terraform validate` contacts the cloud" | No - static check (needs `init` for providers/modules). |
| "`terraform refresh` is the way to update state" | Deprecated - use `plan/apply -refresh-only`. |
| "`taint` is the way to force replacement" | Deprecated - use `apply -replace=ADDR`. |
| "`version` works on any module source" | Only registry (public/private) sources. |
| "Backend config can use variables" | No. Use partial config (`-backend-config`). |
| "`for_each` accepts a list" | Only a map or a set of strings (`toset(...)`). |
| "Child modules can read the parent's variables" | No - pass inputs explicitly. |
| "Lock file should be gitignored" | Commit `.terraform.lock.hcl`. Do **not** commit `.terraform/` or state. |
| "`terraform import` writes configuration" | CLI `import` updates state only. The `import` block can generate config with `plan -generate-config-out`. |
| "Destroy deletes the state file" | State is updated (resources removed); file remains. |
| "A saved plan prompts for approval on apply" | `terraform apply tfplan` applies without the interactive prompt. |
| "`check` blocks stop the run" | They produce warnings; `precondition`/`postcondition`/`validation` can block. |

## Last-week routine

| Day | Do |
|---|---|
| −7 | Timed full practice set; log misses |
| −5 | Targeted labs on weak domains |
| −3 | Second timed set; cheat sheets |
| −2 | Re-do all logged misses |
| −1 | System check, ID, quiet room. Light review only. |
| 0 | Eat, hydrate, log in 20–30 min early |

## Exam-day checklist (online proctored)

- [ ] Government ID ready (name matches registration)
- [ ] Stable internet; wired if possible; close all other apps
- [ ] Cleared desk, no notes, no second monitor unless allowed
- [ ] Quiet, well-lit room; follow the proctor's room scan instructions
- [ ] Charger plugged in; phone out of reach (per rules)
- [ ] Have done the system/browser check on this machine
- [ ] Breathe - read each question twice

## If you don't pass

Retake rules and waiting periods are defined by HashiCorp; check the certification portal. Use the score report's weak areas to target study, then re-run the domain labs and practice sets.
