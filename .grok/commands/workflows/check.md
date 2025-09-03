# /sdd-task --check Workflow

Verifies task completion and documentation quality when `grok_sdd_check(task_id)` is invoked. Operates within the `.grok/` directory structure and integrates with the Agent-SDD Dashboard.

## Purpose
- Validate task execution, documentation, and theme compliance.
- Ensure `tasks.json` conforms to the 14-field schema using `.grok/agents/task-schema-validator.md`.
- Generate a report summarizing task status and issues.

## Directory Context
Uses the `.grok/` structure:
- **Standards**: `.grok/standards/` (theme-standards.md for theme compliance)
- **Specs**: `.grok/specs/[feature-name]_[type]_[date]/` (spec.md, tasks.json)
- **Agents**: `.grok/agents/` (task-schema-validator.md, context-fetcher.md, code-reviewer.md)

## Command Syntax
```
grok_sdd_check(task_id)
```
- **Arguments**: Required `task-id` (e.g., `BTN-012`).

## Workflow
1. **Parse Input**:
   - Read `task-id` from `grok_sdd_check(task_id)` via CLI or dashboard.
2. **Locate Task Spec**:
   - Search `.grok/specs/*/tasks.json` for the given `task-id`.
   - Verify folder follows naming convention: `[feature-name]_[type]_[date]`.
   - Check for `spec.md` and `tasks.json`.
3. **Validate Task Schema**:
   - Use `.grok/agents/task-schema-validator.md` to ensure `tasks.json` conforms to the 14-field schema: `id`, `type`, `title`, `description`, `status`, `priority`, `created_date`, `ux_ui_reviewed`, `theme_changes`, `completed_date`, `target_files`, `dependencies`, `linked_task`, `acceptance_criteria`.
   - Required fields: `id`, `type`, `title`, `description`, `status`, `priority`, `created_date`, `ux_ui_reviewed`, `theme_changes`.
   - Optional fields: `completed_date`, `target_files`, `dependencies`, `linked_task`, `acceptance_criteria`.
4. **Verify Task Status**:
   - Check `status`: `"completed"`, `"pending"`, or `"in_progress"`.
   - For `status: "completed"`, verify `ux_ui_reviewed: true` if `theme_changes: true`, and check `completed_date` (if present) using `.grok/agents/date-checker.md`.
5. **Review Implementation**:
   - Verify `target_files` exist and align with `description` and `acceptance_criteria`.
   - Check for `.bak` backup files (e.g., from `--update` tasks) using `.grok/agents/context-fetcher.md`.
6. **Check Documentation**:
   - Verify `spec.md` includes:
     - Overview with goal and success criteria.
     - Technical specs with implementation details.
     - Theme Standards compliance notes (if `theme_changes: true`).
7. **Validate Theme Compliance**:
   - For tasks with `theme_changes: true`, use `.grok/agents/code-reviewer.md` to verify `target_files` comply with `.grok/standards/theme-standards.md` (e.g., colors, WCAG 2.1 AA, dark mode).
8. **Check Commit History**:
   - Verify commits include task ID in messages (format: `type(scope): description (TASK-ID)` where type is feat|fix|update|chore|docs|style|refactor|test).
9. **Generate Report**:
   - Output to console or dashboard:
     ```
     Task Check Report: [task-id]
     ================================
     Spec folder: [path | Not found]
     Task schema: [Valid | Errors]
     Task status: [completed | pending | in_progress]
     UX/UI reviewed: [true | false]
     Theme compliance: [Compliant | Issues]
     Commits: [Found | Not found]
     Overall: [PASSED | NEEDS ATTENTION]
     ```

## Dashboard Integration
- The dashboard provides a `task-id` selector (e.g., dropdown or text input).
- Displays the report with clickable links to `spec.md` or `.grok/standards/theme-standards.md` for issues.

## Error Handling
- **Invalid Task ID** [ERR_005]: Return "Error [ERR_005]: Task ID not found in `.grok/specs/`."
- **Invalid Folder Structure**: Return "Error: Spec folder does not follow `[feature-name]_[type]_[date]` naming."
- **Missing Files** [ERR_004]: Return "Error [ERR_004]: `spec.md` or `tasks.json` not found."
- **Schema Validation Failure** [ERR_003]: Return validation errors from `.grok/agents/task-schema-validator.md`.
- **Theme Compliance** [ERR_008]: Suggest running `/sdd-task --review <paths>` for fixes.

## Example Usage
```
/sdd-task --check BTN-012
```

## Output Examples
### Successful Check:
```
Task Check Report: BTN-012
============================
Spec folder: .grok/specs/button-component_feature_2025-08-18/
Task schema: Valid
Task status: completed
UX/UI reviewed: true
Theme compliance: Compliant
Commits: Found
Overall: PASSED
```

### Issues Found:
```
Task Check Report: CARD-005
============================
Spec folder: .grok/specs/card-component_feature_2025-08-18/
Task schema: Invalid (Missing 'priority')
Task status: in_progress
UX/UI reviewed: false
Theme compliance: Non-compliant classes in src/components/Card/Card.tsx
Commits: Not found
Overall: NEEDS ATTENTION
Action: Run /sdd-task --review src/components/Card/Card.tsx
```