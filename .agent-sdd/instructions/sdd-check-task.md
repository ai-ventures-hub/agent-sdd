# /sdd-check-task <task-id>
Verify if a task was executed and documented properly.

**IMPORTANT:** This is an Agent-SDD instruction, NOT a bash command.

---

## Purpose
- Verify task completion status and quality.
- Check documentation completeness.
- Validate theme compliance.
- Ensure tasks conform to the unified schema in `.agent-sdd/standards/task-schema.md`.

---

## Task Schema
Tasks in `tasks.json` follow `.agent-sdd/standards/task-schema.md`:
- **Required**: `id`, `type`, `title`, `description`, `status`, `priority`, `created_date`, `ux_ui_reviewed`, `theme_changes`.
- **Optional**: `completed_date`, `target_files`, `dependencies`, `linked_task`, `acceptance_criteria`.

---

## Workflow
1. **Locate task spec**:
   - Search in `.agent-sdd/specs/*/tasks.json` for the given `<task-id>`.
   - If not found, report "Task not found".
2. **Check spec folder structure**:
   - Verify folder follows naming convention: `<action>-<task-id>-[date]`.
   - Check for presence of `sdd.md` and `tasks.json`.
3. **Validate task schema**:
   - Ensure task object in `tasks.json` conforms to `.agent-sdd/standards/task-schema.md`.
   - Check required fields: `id`, `type`, `title`, `description`, `status`, `priority`, `created_date`, `ux_ui_reviewed`, `theme_changes`.
   - Verify optional fields (`completed_date`, `target_files`, `dependencies`, `linked_task`, `acceptance_criteria`) are valid if present.
4. **Verify task status**:
   - Check `status` field: `"completed"` for finished tasks, `"pending"` or `"in_progress"` otherwise.
   - Verify `ux_ui_reviewed: true` for completed UI tasks (with `theme_changes: true`).
   - Check `completed_date` if `status: "completed"`, noting it’s optional.
5. **Review implementation**:
   - Check if `target_files` exist and match task `description`.
   - Verify modifications align with `description` and `acceptance_criteria`.
   - Look for `.bak` backup files if applicable (e.g., from `/sdd-update`).
6. **Check documentation**:
   - Verify `sdd.md` contains:
     - Overview with goal and success criteria.
     - Technical specs with implementation details.
     - Theme Standards compliance notes.
7. **Validate theme compliance**:
   - For tasks with `theme_changes: true`, verify `target_files` follow `.agent-sdd/standards/theme-standards.md` (e.g., allowed color classes, WCAG 2.1 AA compliance, dark mode variants).
8. **Check commit history**:
   - Look for commits with task ID in message, following format: `feat|fix|tweak(scope): message (TASK-ID)`.
9. **Generate report**:
   ```
   Task Check Report: [TASK-ID]
   ================================
   ✅ Spec folder found: [path]
   ✅ Task schema valid
   ✅ Task status: [status]
   ✅ UX/UI reviewed: [true/false]
   ⚠️ Theme compliance: [status]
   ✅ Commit found: [hash]
   
   Overall: PASSED | NEEDS ATTENTION
   ```

---

## Output Examples

### Successful check:
```
✅ Task BTN-012 Check Complete
- Spec: .agent-sdd/specs/update-BTN-012-2025-08-18/
- Status: completed
- Files modified: src/components/Button/Button.tsx
- Theme compliant: Yes
- UX/UI reviewed: true
- Overall: PASSED
```

### Issues found:
```
⚠️ Task CARD-005 Needs Attention
- Spec: .agent-sdd/specs/create-spec-CARD-005-2025-08-18/
- Status: in_progress
- Schema issues: Missing required field 'priority'
- UX/UI reviewed: false
- Theme issues: Non-compliant classes found in src/components/Card/Card.tsx
- Action: Run /sdd-review-code with --fix
- Overall: NEEDS ATTENTION
```

---

## Integration
- Run after `/sdd-execute-task`, `/sdd-update`, or `/sdd-vibe-task`.
- Useful for CI/CD pipelines to validate task completion.
- Ensures consistency with `.agent-sdd/standards/task-schema.md` for desktop app visualization.

---

## Notes
- Validates all required fields to ensure `tasks.json` consistency.
- For vibe coders, reports are clear and actionable to maintain simplicity.
- Desktop app uses `status`, `priority`, `theme_changes`, and `theme_name` for progress display.

---

## Example
```sh
# Check a specific task
/sdd-check-task BTN-012

# Check latest task (if tracking system available)
/sdd-check-task LATEST
```