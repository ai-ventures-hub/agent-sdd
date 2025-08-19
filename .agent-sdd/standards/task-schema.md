# Task Schema
This schema defines the structure of task objects in the `tasks` array of `tasks.json` files for Agent-SDD workflows. It ensures consistency across commands (`/sdd-create-spec`, `/sdd-execute-task`, `/sdd-vibe-task`) and supports vibe coders with minimal input requirements. The desktop app uses this schema to visualize task progress, status, and theme compliance.

Tasks are validated against this schema definition by the `file-creator` agent.

## Schema
```json
{
  "id": "[TASK-ID]-[type]-[N]",
  "type": "feature|fix|tweak",
  "title": "[Short title]",
  "description": "[Detailed description]",
  "status": "pending|in_progress|completed",
  "priority": "low|medium|high|critical",
  "created_date": "[CURRENT-DATE]",
  "completed_date": "[COMPLETION-DATE]",
  "target_files": ["[file-paths]"],
  "dependencies": ["[task-ids]"],
  "linked_task": "[original-task-id]",
  "acceptance_criteria": ["[criteria]"],
  "ux_ui_reviewed": true/false,
  "theme_changes": true/false,
}
```

## Required Fields
- **`id`**: Unique identifier for the task (e.g., "BTN-012-fix-1", "TDC-002-feature-1"). Format: kebab-case `[TASK-ID]-[type]-[N]`.
- **`type`**: Task type: `"feature"` (new functionality), `"fix"` (bug or issue resolution), or `"tweak"` (UI/UX adjustment).
- **`title`**: Short, descriptive title (e.g., "Add new button style").
- **`description`**: Detailed task description, including any relevant details or reproduction steps for fixes.
- **`status`**: Task progress: `"pending"` (not started), `"in_progress"` (active), or `"completed"` (finished). Default: `"pending"`.
- **`priority`**: Priority level: `"low"`, `"medium"`, `"high"`, or `"critical"`. Default: `"medium"`.
- **`created_date`**: Creation date from `date-checker` agent (e.g., "2025-08-18").
- **`ux_ui_reviewed`**: Indicates if UX/UI review is complete. Default: `false`.
- **`theme_changes`**: Indicates if the task involves theme or style changes (triggers `/sdd-review-code`). Default: `false`.

## Optional Fields
- **`completed_date`**: Completion date, set by `/sdd-execute-task` when `status` is `"completed"` (e.g., "2025-08-18"). Default: `null`.
- **`target_files`**: Array of file paths modified or targeted (e.g., `["src/components/Button/Button.tsx"]`). Default: `[]`.
- **`dependencies`**: Array of dependent task IDs (e.g., `["BTN-011"]`). Default: `[]`.
- **`linked_task`**: Original task ID for fixes or tweaks (e.g., "BTN-012"). Default: `null`.
- **`acceptance_criteria`**: Array of success criteria and testing instructions (e.g., `["Button displays correctly", "Meets WCAG 2.1 AA"]`). Default: `[]`.

## Notes
- **Vibe Coders**: Only `title` and `description` are typically prompted; other fields use defaults.
- **Desktop App**: Use `status`, `priority`, and `theme_changes` for visual progress display (e.g., status indicators, priority color-coding).
- **Validation**: The `file-creator` agent validates tasks against this schema definition to ensure required fields are present and valid.