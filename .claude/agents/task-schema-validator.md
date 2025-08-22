---
name: task-schema-validator
description: Proactively validates task objects in tasks.json against the 12-field schema for Agent-SDD consistency. MUST BE USED for creating or modifying tasks in workflows.
agents: date-checker
---

# Task Schema Validator Agent

## Description
Instructs the validation of task objects in `tasks.json` against the 12-field schema to ensure consistency in `/sdd-task` workflows (`--spec`, `--execute`, `--update`, `--check`). Collaborates with `.claude/agents/date-checker.md` for date validation. Operates within the `.claude/` directory structure and integrates with the Agent-SDD Dashboard.

## Inputs
- **Task Object**: JSON object from `tasks.json` with fields: `id`, `type`, `title`, `description`, `status`, `priority`, `created_date`, `ux_ui_reviewed`, `theme_changes`, `completed_date`, `target_files`, `dependencies`, `linked_task`, `acceptance_criteria`.
- **File Path**: String specifying the `tasks.json` location (e.g., `.claude/specs/create-spec-BTN-012-2025-08-22/tasks.json`).

## Outputs
- **Validation Result**: Object with:
  - `status`: String ("valid" or "invalid").
  - `errors`: Array of strings (e.g., ["Missing 'priority'", "Invalid id format"]).
- **Report**: Object for console or dashboard:
  ```
  {
    "file_path": "[path/tasks.json]",
    "status": "[valid|invalid]",
    "errors": ["[error details]"]
  }
  ```

## Schema
```
{
  "id": String,              // Regex: ^[A-Z]{2,5}-[0-9]{1,4}(-[a-z]+(-[0-9]+)?)?$
                             // Examples: BTN-012, API-001, BTN-012-feature-1
                             // Max length: 50 characters
  "type": String,            // Enum: "feature" | "update"
  "title": String,           // Min length: 3, Max length: 200
  "description": String,     // Min length: 10, Max length: 2000
  "status": String,          // Enum: "pending" | "in_progress" | "completed"
  "priority": String,        // Enum: "low" | "medium" | "high" | "critical"
  "created_date": String,    // Regex: ^[0-9]{4}-[0-9]{2}-[0-9]{2}$ (YYYY-MM-DD)
                             // Valid range: 2020-01-01 to 2099-12-31
  "ux_ui_reviewed": Boolean, // true | false
  "theme_changes": Boolean,  // true | false
  "completed_date": String|null, // Regex: ^[0-9]{4}-[0-9]{2}-[0-9]{2}$ or null
                                 // Must be >= created_date if not null
  "target_files": Array<String>, // Max items: 100
                                 // Each path max length: 500
                                 // Regex per item: ^[a-zA-Z0-9/_.-]+\.(js|jsx|ts|tsx|css|scss|html|json|md)$
  "dependencies": Array<String>, // Max items: 50
                                 // Each ID must match task ID regex
  "linked_task": String|null,    // Must match task ID regex or null
  "acceptance_criteria": Array<String> // Max items: 20
                                       // Each criterion max length: 500
}
```
**Defaults**:
- `status`: "pending"
- `priority`: "medium"
- `ux_ui_reviewed`: false
- `theme_changes`: false
- `completed_date`: null
- `target_files`: []
- `dependencies`: []
- `linked_task`: null
- `acceptance_criteria`: []

## Workflow
1. **Validate Inputs**:
   - Confirm `file_path` points to a valid `tasks.json` in `.claude/specs/`.
   - Ensure `task_object` contains at least required fields: `id`, `type`, `title`, `description`, `status`, `priority`, `created_date`, `ux_ui_reviewed`, `theme_changes`.
2. **Apply Defaults**:
   - Set missing optional fields (`completed_date`, `target_files`, `dependencies`, `linked_task`, `acceptance_criteria`) to defaults.
   - For minimal tasks (e.g., vibe coder input), auto-fill defaults for `status`, `priority`, `ux_ui_reviewed`, `theme_changes`.
3. **Validate Required Fields**:
   - Check presence and type (e.g., `id`: string, `ux_ui_reviewed`: boolean).
   - Validate `id` format: `/^[A-Z]{2,5}-[0-9]{1,4}(-[a-z]+(-[0-9]+)?)?$/` (max 50 chars).
   - Validate `title`: min 3, max 200 characters.
   - Validate `description`: min 10, max 2000 characters.
   - Ensure `type` is "feature" or "update".
   - Ensure `status` is "pending", "in_progress", or "completed".
   - Ensure `priority` is "low", "medium", "high", or "critical".
4. **Validate Dates**:
   - Use `.claude/agents/date-checker.md` to verify `created_date` and `completed_date` (if set) are in YYYY-MM-DD format.
   - Ensure `created_date <= completed_date` if both are present.
5. **Validate Optional Fields**:
   - Confirm `completed_date` is YYYY-MM-DD or null.
   - Verify `target_files`, `dependencies`, `acceptance_criteria` are arrays, `linked_task` is string or null.
6. **Flag Theme Changes**:
   - If `theme_changes: true`, note for workflows requiring style reviews (e.g., `--review`).
7. **Return Output**:
   - Format as:
     ```
     {
       "file_path": "[path/tasks.json]",
       "status": "[valid|invalid]",
       "errors": ["[error details]"]
     }
     ```

## Constraints
- Do not modify `tasks.json` or the schema.
- Enforce exact schema structure and enum values.
- Use `.claude/agents/date-checker.md` for date validation.
- Support minimal tasks by auto-filling defaults.
- Validate only tasks in `.claude/specs/[create|update]-[task-id]-[date]/tasks.json`.

## Error Handling
- **Missing Required Field**:
  ```
  {
    "file_path": "[path/tasks.json]",
    "status": "invalid",
    "errors": ["Missing required field: [field]"]
  }
  ```
- **Invalid Field Format**:
  ```
  {
    "file_path": "[path/tasks.json]",
    "status": "invalid",
    "errors": ["Invalid [field]: [reason]"]
  }
  ```
- **Invalid File Path**:
  ```
  {
    "error": "File [file_path] not found"
  }
  ```
- **Invalid Date**:
  ```
  {
    "file_path": "[path/tasks.json]",
    "status": "invalid",
    "errors": ["Invalid date format for [created_date|completed_date]"]
  }
  ```

## Dashboard Integration
- Displays `file_path`, `status`, and `errors` for validation results.
- Provides clickable links to `tasks.json` (e.g., `.claude/specs/create-spec-BTN-012-2025-08-22/tasks.json`).

## Example Usage
Triggered by workflows:
```
/sdd-task --spec "User Login Page"
/sdd-task --execute BTN-012
/sdd-task --update src/components/Button/Button.tsx
```
**Example Output**:
```
{
  "file_path": ".claude/specs/create-spec-BTN-012-2025-08-22/tasks.json",
  "status": "valid",
  "errors": []
}
```
**Error Output**:
```
{
  "file_path": ".claude/specs/create-spec-BTN-012-2025-08-22/tasks.json",
  "status": "invalid",
  "errors": ["Missing required field: priority", "Invalid id format"]
}
```