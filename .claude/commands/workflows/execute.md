# /sdd-task --execute <task-id> [--no-tests] [--quick | --no-spec] [--fix-style]
Execute a task end-to-end and enforce Theme Standards.

---

## Modes
- `default` → Load `.claude/specs/*/tasks.json`, `spec.md`, and `.claude/product/*`.
- `--quick` → Load only `.claude/specs/*/tasks.json` and `spec.md` (skip roadmap sync).
- `--no-spec` → Skip spec loading. If `<task-id>` not found, prompt and create ad-hoc task under `.claude/specs/execute-task-[task-id]-[CURRENT-DATE]/` (use **date-checker** agent first).
- `--no-tests` → Skip test writing/execution.
- `--fix-style` → When review runs, apply safe style fixes automatically (passes `--fix` to review workflow).

---

## Root Directory Detection
**CRITICAL**: Before any file operations, locate the root `.claude` directory to prevent duplicate installations:

1. **Check current directory first**: If `.claude/` exists in current directory, use it.
2. **Search up the tree**: If not found, search parent directories up to root:
   - Check `../.claude/`, `../../.claude/`, etc.
   - Stop at first `.claude/` directory found.
3. **Use absolute paths**: Once found, use that directory for ALL `.claude/` references.
4. **Never create duplicate**: If no `.claude/` found, error and tell user to create the `.claude` directory structure.

**Example**: If `.claude/` is found at `/project-root/.claude/`, ALL references should use that path.

---

## Workflow (what the agent does)
1. **Detect mode** (default / `--quick` / `--no-spec`) and **resolve task**:
   - `default`/`--quick`: Look up `<task-id>` in `.claude/specs/*/tasks.json`. Error if missing.
   - `--no-spec`: If `<task-id>` not present, use **date-checker** agent to get current date, then prompt for details and create new ad-hoc `tasks.json` under `.claude/specs/execute-task-[task-id]-[CURRENT-DATE]/` using the `file-creator` agent.
2. **Confirm target paths** with the user (examples):
   - UI: `src/components/Button/Button.tsx`
   - Logic: `src/lib/fileMonitor.ts`
3. **Implement code** per the spec/task and ensure **WCAG 2.1 AA**.
4. **Git commit (if repo exists)**:
   - Check if `.git` directory exists.
   - If yes: Suggest message: `"[task-id]: <short description>"` (e.g., `feat(Button): add disabled state (BTN-012)`).
   - If no: Show message "ℹ️ No git repository - changes saved locally. Run 'git init' to enable version control".
5. **Tests**:
   - If not `--no-tests` and a `package.json` exists, write task-level tests for critical paths and run tests via the **test-runner** agent.
6. **Theme review (always run)**:
   - Execute theme review using: `/sdd-task --review <modified-paths> [--fix]` (via command dispatcher, NOT as bash command).
     - Pass `--fix` automatically if `--fix-style` was provided.
   - Use code-reviewer agent for theme compliance checking.
   - **Source of truth**: `.claude/standards/theme-standards.md`.
   - Ensure code follows the guidelines in `.claude/standards/theme-standards.md`.
7. **Update task state**:
   - Mark status `"completed"` and set `completed_date` using **date-checker** agent.
   - Set `ux_ui_reviewed: true` after successful theme review.
   - Update `target_files` array with actually modified files.
   - Validate final task object against the `task-schema-validator.md` sub-agent (in `.claude/agents/`).
8. **Final git operations (if repo exists)**:
   - If git repo exists, ask: "Would you like to commit and push changes? (y/n)".
   - If yes: Guide through commit/push process.
   - If no or no repo: Continue without git operations.
9. **Summary to user**:
   - Implemented files, review results (and whether auto-fixed), test outcomes, next steps.

---

## Notes & Conventions
- **A11y**: Keep focus visible; touch targets ≥ 40px. Use ARIA roles/labels where appropriate.
- **Commits**: Prefer conventional style: `feat|fix|chore(scope): message (TASK-ID)`.
- **Schema Validation**: Always validate `tasks.json` updates using `task-schema-validator.md` to ensure compliance with the unified 12-field schema.

---

## Integration
- **Theme standards** defined in `.claude/standards/theme-standards.md` are enforced.
- **test-runner** is invoked unless `--no-tests`.
- **git-workflow**: Only use if git repo exists and user opts to commit changes.
- **file-creator**: Used for creating ad-hoc `tasks.json` in `--no-spec` mode, with validation by `task-schema-validator.md`.
- **task-schema-validator**: Ensures all task updates comply with the unified 12-field schema.

---

## Example
```sh
# Standard flow with auto style fixes
/sdd-task --execute BTN-012 --fix-style

# Ad-hoc fix without tests
/sdd-task --execute HOTFIX-1 --no-spec --no-tests --fix-style
```