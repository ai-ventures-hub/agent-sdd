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

## Workflow (what the agent does)
1. **Detect mode** (default / `--quick` / `--no-spec`) and **resolve task**:
   - `default`/`--quick`: look up `<task-id>` in `.agent-sdd/specs/*/tasks.json`. Error if missing.
   - `--no-spec`: if `<task-id>` not present, use **date-checker** agent to get current date, then prompt for details and create new ad‑hoc `tasks.json` under `.agent-sdd/specs/execute-task-[task-id]-[CURRENT-DATE]/`.
2. **Confirm target paths** with the user (examples):
   - UI: `src/components/Button/Button.tsx`
   - Logic: `src/lib/fileMonitor.ts`
3. **Implement code** per the spec/task and ensure **WCAG 2.1 AA**.
4. **Commit step (guided)**:
   - Suggest message: `"[task-id]: <short description>"` (e.g., `feat(Button): add disabled state (BTN-012)`).
   - Prompt: Open GitHub Desktop → stage → commit. (For `--quick`/`--no-spec`, ask first.)
5. **Tests**:
   - If not `--no-tests` and a `package.json` exists, write task‑level tests for critical paths and run tests via the **test-runner** agent.
6. **Theme review (always run)**:
   - Use Agent-SDD instruction: `/sdd-review-code <modified-paths> [--fix]` (NOT as bash command)
     - Pass `--fix` automatically if `--fix-style` was provided.
   - Use `/sdd-review-code` command or code-reviewer agent for theme compliance checking
   - **Source of truth:** `.agent-sdd/standards/theme-files/[theme-name]/theme.css`, then fall back to legacy files.
   - If the theme import is missing, display the snippet:
     ```css
     @import "../../.agent-sdd/standards/theme-files/[theme-name]/theme.css";
     ```
7. **Update task state**:
   - Mark status `"completed"` and set `completed_date` using **date-checker** agent
   - Set `ux_ui_reviewed: true` after successful theme review
   - Update `target_files` array with actually modified files
   - Validate final task object against `.agent-sdd/standards/task-schema.md`
8. **Push (optional)**:
   - Prompt to push via GitHub Desktop (skip by default on `--quick`/`--no-spec` unless confirmed).
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
- **Theme must be configured**. The reviewer reads tokens from `theme.css` first.
- **test-runner** is invoked unless `--no-tests`.
- **git-workflow**: If commits were created, remind the user to push when ready.

---

## Example
```sh
# Standard flow with auto style fixes
/sdd-execute-task BTN-012 --fix-style

# Ad-hoc fix without tests
/sdd-execute-task HOTFIX-1 --no-spec --no-tests --fix-style
```
