# grok_sdd_spec() Workflow

Creates a Software Design Document when `grok_sdd_spec(feature, description)` function call is executed. Operates within the `.grok/` directory structure and integrates with natural language conversations.

## Purpose
- Generate a structured spec with `spec.md` and `tasks.json` for a given feature.
- Support lightweight specs for non-UI tasks or UI-focused specs with theme compliance.
- Ensure `tasks.json` conforms to the 14-field schema using `.grok/agents/task-schema-validator.md`.

## Directory Context
Uses the `.grok/` structure:
- **Standards**: `.grok/standards/` (theme-standards.md, tech-stack.md, best-practices.md)
- **Product**: `.grok/product/` (overview.md, roadmap.md)
- **Specs**: `.grok/specs/[feature-name]_[type]_[date]/` (spec.md, tasks.json)
- **Agents**: `.grok/agents/` (task-schema-validator.md, file-creator.md, context-fetcher.md, date-checker.md)

## Function Call Interface
```
grok_sdd_spec(feature: string, description: string)
```
- **Parameters**: Required `feature` (e.g., "User Login Page") and `description` (e.g., "Create responsive login form with validation").

## Workflow
1. **Parse Input**:
   - Extract `feature` and `description` from `grok_sdd_spec(feature, description)` function call.
2. **Read Changelog Context**:
   - Use `.grok/agents/logger.md` in read mode to gather recent project changes and context.
3. **Prompt for UI Focus**:
   - Through conversation, prompt: "Is this a UI task?" to set `theme_changes: true` for UI-focused specs.
   - Assume lightweight spec unless user confirms UI focus during conversation.
4. **Fetch Context**:
   - Use `.grok/agents/context-fetcher.md` to load `.grok/product/overview.md`, `.grok/product/roadmap.md`, and `.grok/standards/` (theme-standards.md, tech-stack.md, best-practices.md).
5. **Generate Task ID**:
   - Create a unique `task-id` (e.g., `LGN-001`) based on `feature` and project context.
6. **Create Spec Directory**:
   - Convert `feature` to lowercase, replace spaces with hyphens.
   - Determine `type` from task data (feature/update/fix).
   - Use `.grok/agents/file-creator.md` to create `.grok/specs/[feature-name]_[type]_[date]/`.
7. **Generate `spec.md`**:
   - Write `spec.md` with:
     - Overview: Goal and success criteria based on `feature` and `description`.
     - Technical Specs: Implementation details from `.grok/standards/tech-stack.md`.
     - Theme Compliance: Notes from `.grok/standards/theme-standards.md` (if `theme_changes: true`).
     - Acceptance Criteria: Derived from `feature`, `description`, and context.
8. **Generate `tasks.json`**:
   - Create `tasks.json` with the 14-field schema: `id`, `type`, `title`, `description`, `status`, `priority`, `created_date`, `ux_ui_reviewed`, `theme_changes`, `completed_date`, `target_files`, `dependencies`, `linked_task`, `acceptance_criteria`.
   - Set `title` to `feature`, `description` to the provided `description` parameter, `status: pending`, `created_date` following `.grok/agents/date-checker.md` patterns, `theme_changes` based on UI prompt.
   - Validate `tasks.json` following `.grok/agents/task-schema-validator.md` patterns.
9. **Output Result**:
   - Return spec path and validation status through conversation.
10. **Log Task Creation**:
    - Following `.grok/agents/logger.md` patterns to record spec creation in `.grok/changelog.md`.

## Conversational Integration
- Through natural language conversation, extract `feature` and `description` parameters
- Prompts for UI focus: "Is this a UI task?" to set `theme_changes: true` for UI-focused specs
- Displays the generated spec path and `tasks.json` validation status in conversation

## Error Handling
- **Missing Feature or Description** [ERR_002]: Return "Error [ERR_002]: grok_sdd_spec() requires feature and description parameters."
- **Missing Standards Files** [ERR_004]: Return "Error [ERR_004]: Required file (e.g., `.grok/standards/theme-standards.md`) not found."
- **Schema Validation Failure** [ERR_003]: Return validation errors from `.grok/agents/task-schema-validator.md`.
- **Directory Creation Failure**: Return "Error: Failed to create `.grok/specs/[feature-name]_[type]_[date]/`."

## Example Usage
```
"Create a spec for user login with validation"
```
**Function Call Triggered**:
```
grok_sdd_spec(feature: "User Login", description: "Create responsive login form with validation")
```

**Example Output**:
```
Spec created at .grok/specs/user-login_feature_2025-08-22/
Created spec.md and tasks.json (validated)
```

## Output Examples
### Lightweight Spec:
```
Spec Path: .grok/specs/api-integration_feature_2025-08-22/
Task ID: API-001
Theme Changes: false
Schema: Valid
```

### UI-Focused Spec:
```
Spec Path: .grok/specs/user-login_feature_2025-08-22/
Task ID: LGN-001
Theme Changes: true
Schema: Valid
```