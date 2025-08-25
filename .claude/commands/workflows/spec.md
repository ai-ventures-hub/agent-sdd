# /sdd-task --spec Workflow

Creates a Software Design Document when `/sdd-task --spec <feature-name> <description>` is invoked. Operates within the `.claude/` directory structure and integrates with the Agent-SDD Dashboard.

## Purpose
- Generate a structured spec with `spec.md` and `tasks.json` for a given feature.
- Support lightweight specs for non-UI tasks or UI-focused specs with theme compliance.
- Ensure `tasks.json` conforms to the 14-field schema using `.claude/agents/task-schema-validator.md`.

## Directory Context
Uses the `.claude/` structure:
- **Standards**: `.claude/standards/` (theme-standards.md, tech-stack.md, best-practices.md)
- **Product**: `.claude/product/` (overview.md, roadmap.md)
- **Specs**: `.claude/specs/[feature-name]_[type]_[date]/` (spec.md, tasks.json)
- **Agents**: `.claude/agents/` (task-schema-validator.md, file-creator.md, context-fetcher.md, date-checker.md)

## Command Syntax
```
/sdd-task --spec <feature-name> <description>
```
- **Arguments**: Required `feature-name` (e.g., "User Login Page") and `description` (e.g., "Create responsive login form with validation").

## Workflow
1. **Parse Input**:
   - Read `feature-name` and `description` from `/sdd-task --spec <feature-name> <description>` via CLI or dashboard.
2. **Read Changelog Context**:
   - Use `.claude/agents/logger.md` in read mode to gather recent project changes and context.
3. **Prompt for UI Focus**:
   - Via dashboard, prompt: "Is this a UI task?" to set `theme_changes: true` for UI-focused specs.
   - CLI assumes lightweight spec unless `--spec` is invoked via dashboard with UI selection.
4. **Fetch Context**:
   - Use `.claude/agents/context-fetcher.md` to load `.claude/product/overview.md`, `.claude/product/roadmap.md`, and `.claude/standards/` (theme-standards.md, tech-stack.md, best-practices.md).
5. **Generate Task ID**:
   - Create a unique `task-id` (e.g., `LGN-001`) based on `feature-name` and project context.
6. **Create Spec Directory**:
   - Convert `feature-name` to lowercase, replace spaces with hyphens.
   - Determine `type` from task data (feature/update/fix).
   - Use `.claude/agents/file-creator.md` to create `.claude/specs/[feature-name]_[type]_[date]/`.
7. **Generate `spec.md`**:
   - Write `spec.md` with:
     - Overview: Goal and success criteria based on `feature-name` and `description`.
     - Technical Specs: Implementation details from `.claude/standards/tech-stack.md`.
     - Theme Compliance: Notes from `.claude/standards/theme-standards.md` (if `theme_changes: true`).
     - Acceptance Criteria: Derived from `feature-name`, `description`, and context.
8. **Generate `tasks.json`**:
   - Create `tasks.json` with the 14-field schema: `id`, `type`, `title`, `description`, `status`, `priority`, `created_date`, `ux_ui_reviewed`, `theme_changes`, `completed_date`, `target_files`, `dependencies`, `linked_task`, `acceptance_criteria`.
   - Set `title` to `feature-name`, `description` to the provided `description` parameter, `status: pending`, `created_date` via `.claude/agents/date-checker.md`, `theme_changes` based on UI prompt.
   - Validate `tasks.json` using `.claude/agents/task-schema-validator.md`.
9. **Output Result**:
   - Return spec path and validation status to console or dashboard.
10. **Log Task Creation**:
    - Use `.claude/agents/logger.md` in write mode to record spec creation in `.claude/changelog.md`.

## Dashboard Integration
- The dashboard provides text inputs for `feature-name` and `description`, plus a UI task prompt ("Is this a UI task?").
- Displays the generated spec path and `tasks.json` validation status.

## Error Handling
- **Missing Feature Name or Description** [ERR_002]: Return "Error [ERR_002]: --spec requires feature name and description."
- **Missing Standards Files** [ERR_004]: Return "Error [ERR_004]: Required file (e.g., `.claude/standards/theme-standards.md`) not found."
- **Schema Validation Failure** [ERR_003]: Return validation errors from `.claude/agents/task-schema-validator.md`.
- **Directory Creation Failure**: Return "Error: Failed to create `.claude/specs/[feature-name]_[type]_[date]/`."

## Example Usage
```
/sdd-task --spec "User Login Page" "Create responsive login form with validation"
```
**Example Output**:
```
Spec created at .claude/specs/user-login-page_feature_2025-08-22/
Created spec.md and tasks.json (validated)
```

## Output Examples
### Lightweight Spec:
```
Spec Path: .claude/specs/api-integration_feature_2025-08-22/
Task ID: API-001
Theme Changes: false
Schema: Valid
```

### UI-Focused Spec:
```
Spec Path: .claude/specs/user-login-page_feature_2025-08-22/
Task ID: LGN-001
Theme Changes: true
Schema: Valid
```