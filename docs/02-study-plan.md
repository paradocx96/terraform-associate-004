# 02 - Study Plan

Three plans. Pick one based on your Terraform experience. Beginners to Terraform: use the **6-week plan**, even if you already know Docker, CI/CD or a cloud platform - Terraform has its own vocabulary (state, plan, providers, modules) that needs hands-on time.

> **Rule #1:** type every lab yourself. Reading alone is the most common reason people fail this exam.
> **Rule #2:** after each domain, answer its practice questions *closed-book*.

---

## Plan A - 6 weeks (recommended for Terraform beginners)

**Time:** ~1.5 h on weekdays, ~3 h on one weekend day (≈ 8–10 h/week).

### Week 1 - Foundations (Domains 1, 2, 3)

| Day | Task |
|---|---|
| 1 | Read [`docs/00-exam-overview.md`](00-exam-overview.md) and [`01-quick-start.md`](01-quick-start.md). Install Terraform + VS Code extension. |
| 2 | Domain 1 README (IaC concepts). Practice Qs: `practice/01-iac-concepts.md` |
| 3 | Domain 2 README (providers + state basics). |
| 4 | **Lab 01** - first config, providers, workflow |
| 5 | Domain 3 README (core workflow). Memorise the CLI cheat sheet [`05-cli-cheatsheet.md`](05-cli-cheatsheet.md). |
| 6 | Practice Qs: domains 2 and 3. Re-do Lab 01 from a blank folder without notes. |
| 7 | Rest or light review. Write a one-page summary of the workflow in your own words. |

### Week 2 - Configuration I (Domain 4, part 1)

| Day | Task |
|---|---|
| 1 | Domain 4 README: resources vs data, references, variables, outputs, locals |
| 2 | **Lab 02** - variables, locals, outputs, precedence |
| 3 | Domain 4: complex types, expressions, functions ([`06-hcl-cheatsheet.md`](06-hcl-cheatsheet.md)) |
| 4 | **Lab 03** - `count`, `for_each`, `for` expressions |
| 5 | Domain 4: dependencies, `lifecycle` (`depends_on`, `create_before_destroy`, `prevent_destroy`, `ignore_changes`) |
| 6 | Practice Qs: domain 4 (first half) |
| 7 | Review misses |

### Week 3 - Configuration II + Modules (Domains 4, 5)

| Day | Task |
|---|---|
| 1 | Domain 4: custom conditions (`validation`, `precondition`, `postcondition`, `check`) |
| 2 | **Lab 08** - custom conditions |
| 3 | Domain 4: sensitive data, **ephemeral values**, **write-only arguments**, Vault |
| 4 | Domain 5 README: modules |
| 5 | **Lab 04** - local modules |
| 6 | Practice Qs: domain 4 (second half) and domain 5 |
| 7 | Review misses. **Checkpoint:** can you explain implicit vs explicit dependencies and module variable scope aloud? |

### Week 4 - State and Maintenance (Domains 6, 7)

| Day | Task |
|---|---|
| 1 | Domain 6 README: state, backends, locking |
| 2 | **Lab 05** - state CLI, `moved`, `removed`, drift, backend migration |
| 3 | Domain 6: drift and refresh-only; remote backends concepts |
| 4 | Domain 7 README: import (CLI + `import` block), state CLI, logging |
| 5 | **Lab 06** (AWS, optional) - data sources, `dynamic`, import, S3 backend. If skipping AWS, redo Lab 05 with extra scenarios. |
| 6 | Practice Qs: domains 6 and 7 |
| 7 | Review misses |

### Week 5 - HCP Terraform + first full-exam practice (Domain 8)

| Day | Task |
|---|---|
| 1 | Domain 8 README |
| 2 | **Lab 07** - HCP Terraform: org, workspace, variable set, project, run trigger |
| 3 | Domain 8: governance (Sentinel/OPA, private registry, teams, drift detection, explorer, change requests) |
| 4 | Practice Qs: domain 8 + `practice/rapid-fire.md` |
| 5 | Take a timed 60-minute mixed set from an external practice-exam provider (see [`03-study-materials.md`](03-study-materials.md)) |
| 6 | Analyse every wrong answer; map each to an objective in [`08-objective-checklist.md`](08-objective-checklist.md) |
| 7 | Rest |

### Week 6 - Revision and exam

| Day | Task |
|---|---|
| 1 | Re-read all domain "Exam traps" sections |
| 2 | Timed practice set #2 |
| 3 | Fix weak objectives with targeted labs |
| 4 | Timed practice set #3 (target 85%+) |
| 5 | Read [`04-exam-strategy.md`](04-exam-strategy.md); run the proctor system check |
| 6 | Light review: cheat sheets only. Sleep well. |
| 7 | **Exam day** (or the next day if you want a buffer) |

---

## Plan B - 4 weeks (some IaC/cloud background)

| Week | Focus |
|---|---|
| 1 | Domains 1, 2, 3 + Labs 01, 02. Read quick start and cheat sheets. |
| 2 | Domains 4, 5 + Labs 03, 04, 08 |
| 3 | Domains 6, 7, 8 + Labs 05, 07 (06 optional) |
| 4 | Three timed practice sets, fix weak spots, exam strategy |

Daily: ~2 hours.

---

## Plan C - 2 weeks revision (already hands-on)

| Days | Focus |
|---|---|
| 1–2 | Read exam content list; mark objectives you can't explain. Skim all domain READMEs "Exam traps". |
| 3–5 | Targeted labs for weak objectives (state, import, conditions, HCP Terraform) |
| 6–8 | Domain practice questions; re-do misses |
| 9–11 | Two timed mixed sets |
| 12–13 | Cheat sheets, strategy, system check |
| 14 | Exam |

---

## Weekly habits that work

- **Daily 10-minute recall:** open the CLI cheat sheet, cover it, and list the commands + flags from memory.
- **Error journal:** keep `notes/mistakes.md` (not committed). One line per missed question: *objective → what I thought → what is true → why*.
- **Spaced repetition:** re-attempt missed questions after 2 days and again after 7 days.
- **Break things deliberately** in labs (delete a resource outside Terraform, change a provider version, break a variable type) and read the errors.

## Readiness checklist

You are ready when you can:

- [ ] Explain, without notes, what happens during `init`, `plan` and `apply`
- [ ] Write a config with variables, outputs, `for_each`, a data source and a module from scratch
- [ ] Describe variable precedence in the right order
- [ ] Explain state, locking, drift and when to use refresh-only
- [ ] Differentiate `import` block vs CLI import, `moved` vs `removed`
- [ ] Explain HCP Terraform workspaces vs projects vs CLI workspaces
- [ ] Score 85%+ on three timed mixed practice sets
