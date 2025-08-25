# /sdd-task --spec Workflow

Creates a Software Design Document (lightweight or UI-focused) when `/sdd-task --spec <feature-name>` is invoked. Operates within the `.claude/` directory structure and integrates with the Agent-SDD Dashboard.

## Purpose
- Generate a structured spec with `spec.md` and `tasks.json` for a given feature.
- Support lightweight specs for non-UI tasks or UI-focused specs with theme compliance.
- Ensure `tasks.json` conforms to the 12-field schema using `.claude/agents/task-schema-validator.md`.

## Directory Context
Uses the `.claude/` structure:
- **Standards**: `.claude/standards/` (theme-standards.md, tech-stack.md, best-practices.md)
- **Product**: `.claude/product/` (overview.md, roadmap.md)
- **Specs**: `.claude/specs/create-spec-[task-id]-[date]/` (spec.md, tasks.json)
- **Agents**: `.claude/agents/` (task-schema-validator.md, file-creator.md, context-fetcher.md, date-checker.md)

## Command Syntax
```
/sdd-task --spec <feature-name>
```
- **Arguments**: Required `feature-name` (e.g., "User Login Page").

## Workflow
1. **Parse Input**:
   - Read `feature-name` from `/sdd-task --spec <feature-name>` via CLI or dashboard.
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
   - Use `.claude/agents/file-creator.md` to create `.claude/specs/create-spec-[task-id]-[date]/`.
7. **Generate `spec.md`**:
   - Write `spec.md` with:
     - Overview: Goal and success criteria based on `feature-name`.
     - Technical Specs: Implementation details from `.claude/standards/tech-stack.md`.
     - Theme Compliance: Notes from `.claude/standards/theme-standards.md` (if `theme_changes: true`).
     - Acceptance Criteria: Derived from `feature-name` and context.
8. **Generate `tasks.json`**:
   - Create `tasks.json` with the 12-field schema: `id`, `type`, `title`, `description`, `status`, `priority`, `created_date`, `ux_ui_reviewed`, `theme_changes`, `completed_date`, `target_files`, `dependencies`, `linked_task`, `acceptance_criteria`.
   - Set `status: pending`, `created_date` via `.claude/agents/date-checker.md`, `theme_changes` based on UI prompt.
   - Validate `tasks.json` using `.claude/agents/task-schema-validator.md`.
9. **Output Result**:
   - Return spec path and validation status to console or dashboard.
10. **Log Task Creation**:
    - Use `.claude/agents/logger.md` in write mode to record spec creation in `.claude/changelog.md`.

## Dashboard Integration
- The dashboard provides a text input for `feature-name` and a UI task prompt (“Is this a UI task?”).
- Displays the generated spec path and `tasks.json` validation status.

## Error Handling
- **Missing Feature Name**: Return "Error: --spec requires feature name."
- **Missing Standards Files**: Return "Error: Required file (e.g., `.claude/standards/theme-standards.md`) not found."
- **Schema Validation Failure**: Return errors from `.claude/agents/task-schema-validator.md`.
- **Directory Creation Failure**: Return "Error: Failed to create `.claude/specs/create-spec-[task-id]-[date]/`."

## Example Usage
```
/sdd-task --spec "User Login Page"
```
**Example Output**:
```
Spec created at .claude/specs/create-spec-LGN-001-2025-08-22/
Created spec.md and tasks.json (validated)
```

## Output Examples
### Lightweight Spec:
```
Spec Path: .claude/specs/create-spec-API-001-2025-08-22/
Task ID: API-001
Theme Changes: false
Schema: Valid
```

### UI-Focused Spec:
```
Spec Path: .claude/specs/create-spec-LGN-001-2025-08-22/
Task ID: LGN-001
Theme Changes: true
Schema: Valid
```