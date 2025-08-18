# /sdd-vibe-task
Simplified task creation for vibe coders.

---

## Purpose
- Create tasks with minimal input, auto-generating schema-compliant details.
- Supports iterative development with consistent `tasks.json` output for desktop app visualization.

---

## Task Schema
Tasks in `tasks.json` follow `.agent-sdd/standards/task-schema.md`:
- **Required**: `id`, `type: "feature"`, `title`, `description`, `status`, `priority`, `created_date`, `ux_ui_reviewed`, `theme_changes`.
- **Optional**: `completed_date`, `target_files`, `dependencies`, `linked_task`, `acceptance_criteria`, `theme_name`.

**Defaults for vibe coders**:
- `status: "pending"`, `priority: "medium"`, `ux_ui_reviewed: false`, `theme_changes: false`.
- `theme_name`: Auto-populated by `file-creator` from `.agent-sdd/standards/theme-files/` if `theme_changes: true`.
- `completed_date`, `target_files`, `dependencies`, `linked_task`, `acceptance_criteria`: Default to `null` or `[]` unless specified.

---

## Workflow
1. **Prompt for `title` and `description`**:
   - Example: `title: "Add new button style"`, `description: "Create a new button style with rounded corners."`.
2. **Optional prompts**:
   - Ask for `target_files`, `acceptance_criteria`, or `theme_changes` if relevant (e.g., for UI tasks).
3. **Use `date-checker` agent** for `created_date` (e.g., "2025-08-18").
4. **Auto-generate `id`** as `[title-in-kebab-case]-[type]-[N]` (e.g., `add-new-button-style-feature-1`).
5. **Create spec folder**:
   - `.agent-sdd/specs/vibe-task-[task-id]-[CURRENT-DATE]/`.
6. **Create `tasks.json`**:
   - Use `file-creator` to generate `tasks.json` with the feature name (derived from `title`) and a single task.
   - Set required fields: `id`, `type: "feature"`, `title`, `description`, `status: "pending"`, `priority: "medium"`, `created_date`, `ux_ui_reviewed: false`, `theme_changes` (based on user input or default `false`).
   - Set optional fields: `target_files`, `acceptance_criteria` (if provided), `theme_name` (auto-populated if `theme_changes: true`).
   - Validate against `.agent-sdd/standards/task-schema.md`.
7. **Prompt user**: `"Proceed with task? (yes/no)"`.

---

## Notes
- For vibe coders, only `title` and `description` are required; defaults simplify the process.
- Desktop app uses `status`, `priority`, `theme_changes`, and `theme_name` for progress visualization.
- Use `/sdd-execute-task` to implement the task and `/sdd-check-task` to validate completion.

---

## Example
```sh
/sdd-vibe-task "Add new button style"
```

**Generated tasks.json**:
```json
{
  "feature": "add-new-button-style",
  "tasks": [
    {
      "id": "add-new-button-style-feature-1",
      "type": "feature",
      "title": "Add new button style",
      "description": "Create a new button style with rounded corners.",
      "status": "pending",
      "priority": "medium",
      "created_date": "2025-08-18",
      "target_files": ["src/components/Button/Button.tsx"],
      "acceptance_criteria": ["Button displays with rounded corners", "Meets WCAG 2.1 AA"],
      "ux_ui_reviewed": false,
      "theme_changes": true,
      "theme_name": "minimal"
    }
  ]
}
```

---

## Integration
- Works with `/sdd-execute-task` for task implementation.
- Can be validated with `/sdd-check-task`.
- Supports desktop app visualization via schema-compliant `tasks.json`.