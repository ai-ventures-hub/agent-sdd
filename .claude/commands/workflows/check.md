# /sdd-task --check Workflow

Verifies task completion and documentation quality when `/sdd-task --check <task-id>` is invoked. Operates within the `.claude/` directory structure and integrates with the Agent-SDD Dashboard.

## Purpose
- Validate task execution, documentation, and theme compliance.
- Ensure `tasks.json` conforms to the 12-field schema using `.claude/agents/task-schema-validator.md`.
- Generate a report summarizing task status and issues.

## Directory Context
Uses the `.claude/` structure:
- **Standards**: `.claude/standards/` (theme-standards.md for theme compliance)
- **Specs**: `.claude/specs/create-spec-[task-id]-[date]/` (spec.md, tasks.json)
- **Agents**: `.claude/agents/` (task-schema-validator.md, context-fetcher.md, code-reviewer.md)

## Command Syntax
```
/sdd-task --check <task-id>
```
- **Arguments**: Required `task-id` (e.g., `BTN-012`).

## Workflow
1. **Parse Input**:
   - Read `task-id` from `/sdd-task --check <task-id>` via CLI or dashboard.
2. **Locate Task Spec**:
   - Search `.claude/specs/*/tasks.json` for the given `task-id`.
   - Verify folder follows naming convention: `create-spec-[task-id]-[date]`.
   - Check for `spec.md` and `tasks.json`.
3. **Validate Task Schema**:
   - Use `.claude/agents/task-schema-validator.md` to ensure `tasks.json` conforms to the 12-field schema: `id`, `type`, `title`, `description`, `status`, `priority`, `created_date`, `ux_ui_reviewed`, `theme_changes`, `completed_date`, `target_files`, `dependencies`, `linked_task`, `acceptance_criteria`.
   - Required fields: `id`, `type`, `title`, `description`, `status`, `priority`, `created_date`, `ux_ui_reviewed`, `theme_changes`.
   - Optional fields: `completed_date`, `target_files`, `dependencies`, `linked_task`, `acceptance_criteria`.
4. **Verify Task Status**:
   - Check `status`: `"completed"`, `"pending"`, or `"in_progress"`.
   - For `status: "completed"`, verify `ux_ui_reviewed: true` if `theme_changes: true`, and check `completed_date` (if present) using `.claude/agents/date-checker.md`.
5. **Review Implementation**:
   - Verify `target_files` exist and align with `description` and `acceptance_criteria`.
   - Check for `.bak` backup files (e.g., from `--update` tasks) using `.claude/agents/context-fetcher.md`.
6. **Check Documentation**:
   - Verify `spec.md` includes:
     - Overview with goal and success criteria.
     - Technical specs with implementation details.
     - Theme Standards compliance notes (if `theme_changes: true`).
7. **Validate Theme Compliance**:
   - For tasks with `theme_changes: true`, use `.claude/agents/code-reviewer.md` to verify `target_files` comply with `.claude/standards/theme-standards.md` (e.g., colors, WCAG 2.1 AA, dark mode).
8. **Check Commit History**:
   - Verify commits include `task-id` in messages (format: `feat|fix|tweak(scope): message (TASK-ID)`).
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
- Displays the report with clickable links to `spec.md` or `.claude/standards/theme-standards.md` for issues.

## Error Handling
- **Invalid Task ID**: Return "Error: Task ID not found in `.claude/specs/`."
- **Invalid Folder Structure**: Return "Error: Spec folder does not follow `create-spec-[task-id]-[date]` naming."
- **Missing Files**: Return "Error: `spec.md` or `tasks.json` not found."
- **Schema Validation Failure**: Return errors from `.claude/agents/task-schema-validator.md`.
- **Non-Compliant Theme**: Suggest running `/sdd-task --review <paths>` for fixes.

## Example Usage
```
/sdd-task --check BTN-012
```

## Output Examples
### Successful Check:
```
Task Check Report: BTN-012
============================
Spec folder: .claude/specs/create-spec-BTN-012-2025-08-18/
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
Spec folder: .claude/specs/create-spec-CARD-005-2025-08-18/
Task schema: Invalid (Missing 'priority')
Task status: in_progress
UX/UI reviewed: false
Theme compliance: Non-compliant classes in src/components/Card/Card.tsx
Commits: Not found
Overall: NEEDS ATTENTION
Action: Run /sdd-task --review src/components/Card/Card.tsx
```