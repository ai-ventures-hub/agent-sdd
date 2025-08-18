# /sdd-update [--type tweak|fix] [--no-tests] [--fix-style] <target>
Apply a UI/UX tweak or fix (bug, styling, accessibility) to existing code and enforce Theme Standards.

**IMPORTANT:** This is an Agent-SDD instruction, NOT a bash command.

---

## Purpose
- Apply small UI/UX improvements or fix defects while maintaining Theme Standards.
- Ensure changes align with the active theme from `/sdd-apply-theme`.
- Support vibe coders with minimal input and consistent `tasks.json` output for desktop app visualization.

---

## Options
- `--type tweak|fix` → Specify task type: `tweak` for UI/UX improvements, `fix` for bugs, styling, or accessibility issues. Default: `tweak`.
- `--no-tests` → Skip test writing/execution.
- `--fix-style` → Run `.agent-sdd/scripts/fix-theme-style.sh` to auto-replace non-compliant classes with theme-compliant ones.

---

## Task Schema
Tasks in `tasks.json` follow `.agent-sdd/standards/task-schema.md`:
- **Required**: `id`, `type: "tweak" or "fix"`, `title`, `description`, `status`, `priority`, `created_date`, `ux_ui_reviewed`, `theme_changes`.
- **Optional**: `completed_date`, `target_files`, `dependencies`, `linked_task`, `acceptance_criteria`, `theme_name`.

**Defaults for vibe coders**:
- `status: "pending"`, `priority: "medium"`, `ux_ui_reviewed: false`, `theme_changes: true`.
- `theme_name`: Auto-populated by `file-creator` from `.agent-sdd/standards/theme-files/` if `theme_changes: true`.

---

## Workflow
1. **Prompt for details** if not provided in `<target>`:
   - Ask for a short description (e.g., "Increase button padding" for tweak, "Fix login error" for fix).
   - Ask for target file(s) or component(s) if `<target>` is unclear.
2. **Determine task type**:
   - Set `type: "tweak"` or `type: "fix"` based on `--type` (default: `tweak`).
3. **Create tracking spec** (optional, for complex updates):
   - Use **date-checker** agent to get current date (e.g., "2025-08-18").
   - Create `.agent-sdd/specs/update-[task-id]-[CURRENT-DATE]/tasks.json` using `file-creator`.
   - Set task fields: `id: "[task-id]-[type]-[N]"`, `title` (from description), `description`, `status: "pending"`, `priority: "medium"`, `created_date`, `ux_ui_reviewed: false`, `theme_changes: true`, `theme_name` (auto-populated).
   - Include optional fields: `target_files` (from `<target>`), `acceptance_criteria` (from user input or inferred), `linked_task` (if applicable).
4. **Locate target file(s)**:
   - Search by component or file name within `src/` based on `<target>`.
5. **Backup file(s)**:
   - Create `.bak` copies before modifications.
6. **Implement update**:
   - For tweaks: Adjust UI/UX (e.g., padding, shadows, contrast).
   - For fixes: Correct bugs, styling, or accessibility issues (e.g., ARIA labels, contrast ratios).
   - Follow Theme Standards for typography, spacing, and colors.
   - Avoid changing business logic unless explicitly required for fixes.
7. **Theme Review**:
   - Run `/sdd-review-code <modified-paths>` (NOT as bash command).
   - If `--fix-style`, run `.agent-sdd/scripts/fix-theme-style.sh` to auto-replace non-compliant classes before review.
   - **Primary source**: `.agent-sdd/standards/theme-files/[theme-name]/theme.css`.
   - **Fallbacks**: `syntax-custom.css` or `app.css` if `theme.css` missing.
   - **Fallback script**: If `/sdd-review-code` is unavailable, use `.agent-sdd/scripts/sdd-review-code.sh <target-file>`.
8. **Tests** (unless `--no-tests`):
   - Write or update minimal tests for the update using the `test-runner` agent.
   - Run tests to verify functionality or UI changes.
9. **Commit suggestion**:
   - Use `date-checker` for UPDATE-ID timestamping.
   - Format: `[type](scope): message (UPDATE-ID)` (e.g., `tweak(Button): increase padding (BTN-012)` or `fix(Auth): resolve login error (AUTH-001)`).
10. **Generate report**:
    - Summarize changes, review results, and test outcomes.

---

## Notes
- Maintain WCAG 2.1 AA compliance and responsiveness (e.g., touch targets ≥ 40px).
- Use spacing in 4px multiples (`p-1`, `m-2`, `gap-3`, etc.).
- Always provide `dark:` variants for themed colors where needed.
- For vibe coders, prompt only for description and target; defaults are applied for other fields.
- Desktop app uses `status`, `priority`, `theme_changes`, and `theme_name` for visualization.

---

## Examples
```sh
# Tweak button padding with auto-fix styles
/sdd-update src/components/Button/Button.tsx --type tweak --fix-style

# Fix button accessibility without tests
/sdd-update src/components/Button/Button.tsx --type fix --no-tests

# Fix login bug with tests
/sdd-update src/lib/auth.ts --type fix
```

**Generated tasks.json Example**:
```json
{
  "feature": "button-update",
  "tasks": [
    {
      "id": "BTN-012-tweak-1",
      "type": "tweak",
      "title": "Increase button padding",
      "description": "Increase padding on primary button for better UX.",
      "status": "pending",
      "priority": "medium",
      "created_date": "2025-08-18",
      "target_files": ["src/components/Button/Button.tsx"],
      "acceptance_criteria": ["Button padding increased", "Meets WCAG 2.1 AA"],
      "ux_ui_reviewed": false,
      "theme_changes": true,
      "theme_name": "minimal"
    }
  ]
}
```

---

## Integration
- Works with `/sdd-review-code` for theme compliance.
- Integrates with `test-runner` for tests (unless `--no-tests`).
- Can be validated with `/sdd-check-task`.
- Supports CI/CD for automated update tracking.