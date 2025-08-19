# /sdd-execute-task <task-id> [--no-tests] [--quick | --no-spec] [--fix-style]
Execute a task end‑to‑end and enforce Theme Standards.

---

## Modes
- `default` → Load `.agent-sdd/specs/*/tasks.json`, `sdd.md`, and `.agent-sdd/product/*`.
- `--quick` → Load only `.agent-sdd/specs/*/tasks.json` and `sdd.md` (skip roadmap sync).
- `--no-spec` → Skip spec loading. If `<task-id>` not found, prompt and create ad‑hoc task under `.agent-sdd/specs/execute-task-[task-id]-[CURRENT-DATE]/` (use **date-checker** agent first).
- `--no-tests` → Skip test writing/execution.
- `--fix-style` → When review runs, apply safe style fixes automatically (calls `/sdd-review-code --fix`).

---

## Root Directory Detection
**CRITICAL**: Before any file operations, locate the root `.agent-sdd` directory to prevent duplicate installations:

1. **Check current directory first**: If `.agent-sdd/` exists in current directory, use it.
2. **Search up the tree**: If not found, search parent directories up to root:
   - Check `../.agent-sdd/`, `../../.agent-sdd/`, etc.
   - Stop at first `.agent-sdd/` directory found.
3. **Use absolute paths**: Once found, use that directory for ALL `.agent-sdd/` references.
4. **Never create duplicate**: If no `.agent-sdd/` found, error and tell user to run setup script.

**Example**: If `.agent-sdd/` is found at `/project-root/.agent-sdd/`, ALL references should use that path.

---

## Workflow (what the agent does)
1. **Detect mode** (default / `--quick` / `--no-spec`) and **resolve task**:
   - `default`/`--quick`: look up `<task-id>` in `.agent-sdd/specs/*/tasks.json`. Error if missing.
   - `--no-spec`: if `<task-id>` not present, use **date-checker** agent to get current date, then prompt for details and create new ad‑hoc `tasks.json` under `.agent-sdd/specs/execute-task-[task-id]-[CURRENT-DATE]/`.
2. **Confirm target paths** with the user (examples):
   - UI: `src/components/Button/Button.tsx`
   - Logic: `src/lib/fileMonitor.ts`
3. **Implement code** per the spec/task and ensure **WCAG 2.1 AA**.
4. **Git commit (if repo exists)**:
   - Check if `.git` directory exists
   - If yes: Suggest message: `"[task-id]: <short description>"` (e.g., `feat(Button): add disabled state (BTN-012)`)
   - If no: Show message "ℹ️ No git repository - changes saved locally. Run 'git init' to enable version control"
5. **Tests**:
   - If not `--no-tests` and a `package.json` exists, write task‑level tests for critical paths and run tests via the **test-runner** agent.
6. **Theme review (always run)**:
   - Use Agent-SDD instruction: `/sdd-review-code <modified-paths> [--fix]` (NOT as bash command)
     - Pass `--fix` automatically if `--fix-style` was provided.
   - Use `/sdd-review-code` command or code-reviewer agent for theme compliance checking
   - **Source of truth:** `.agent-sdd/standards/theme-standards.md`.
   - Ensure code follows the guidelines in `.agent-sdd/standards/theme-standards.md`.
7. **Update task state**:
   - Mark status `"completed"` and set `completed_date` using **date-checker** agent
   - Set `ux_ui_reviewed: true` after successful theme review
   - Update `target_files` array with actually modified files
   - Validate final task object against `.agent-sdd/standards/task-schema.md`
8. **Final git operations (if repo exists)**:
   - If git repo exists, ask: "Would you like to commit and push changes? (y/n)"
   - If yes: Guide through commit/push process
   - If no or no repo: Continue without git operations
9. **Summary to user**:
   - Implemented files, review results (and whether auto‑fixed), test outcomes, next steps.

---

## Notes & Conventions
- **Never** modify logic inside the review phase; review only adjusts classes/styles.
- **Spacing grid:** Prefer 4px scale (`p-1/2/3`, `gap-1/2/3`, etc.).
- **Dark mode:** Ensure `dark:` companions for themed text/background as needed.
- **A11y:** Keep focus visible; touch targets ≥ 40px. Use ARIA roles/labels where appropriate.
- **Commits:** Prefer conventional style: `feat|fix|chore(scope): message (TASK-ID)`.

---

## Integration
- **Theme standards** defined in `.agent-sdd/standards/theme-standards.md` are enforced.
- **test-runner** is invoked unless `--no-tests`.
- **git-workflow**: Only use if git repo exists and user opts to commit changes.

---

## Example
```sh
# Standard flow with auto style fixes
/sdd-execute-task BTN-012 --fix-style

# Ad-hoc fix without tests
/sdd-execute-task HOTFIX-1 --no-spec --no-tests --fix-style
```
