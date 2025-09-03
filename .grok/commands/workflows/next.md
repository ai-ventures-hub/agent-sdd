# grok_sdd_next() Workflow

Identifies and creates a spec for the next pending task in the roadmap when `grok_sdd_next()` is invoked. Operates within the `.grok/` directory structure and integrates with the Agent-SDD Dashboard.

## Purpose
- Automate spec creation for the next pending task from `.grok/product/roadmap.md`.
- Maintain sequential development by linking roadmap tasks to specs.
- Ensure generated `tasks.json` conforms to the 14-field schema using `.grok/agents/task-schema-validator.md`.

## Directory Context
Uses the `.grok/` structure:
- **Product**: `.grok/product/` (roadmap.md)
- **Specs**: `.grok/specs/[feature-name]_[type]_[date]/` (spec.md, tasks.json)
- **Commands**: `.grok/commands/workflows/` (spec.md for spec creation)
- **Agents**: `.grok/agents/` (task-schema-validator.md, file-creator.md, context-fetcher.md)

## Command Syntax
```
grok_sdd_next()
```
- **Arguments**: None.

## Workflow
1. **Parse Input**:
   - Read `grok_sdd_next()` via CLI or dashboard.
2. **Read Changelog Context**:
   - Use `.grok/agents/logger.md` in read mode to gather recent project changes and context.
3. **Read Roadmap**:
   - Load `.grok/product/roadmap.md` using `.grok/agents/context-fetcher.md`.
4. **Identify Active Phase**:
   - Scan roadmap for phases (e.g., Phase 1, Phase 2) and identify the first phase with pending `[ ]` tasks.
5. **Select Next Task**:
   - Pick the first incomplete task (marked `[ ]`) in the active phase.
   - Use the task's description as the feature name for spec creation.
6. **Create Spec**:
   - Trigger `.grok/commands/workflows/spec.md` with the task's description as the feature name.
   - Use `.grok/agents/file-creator.md` to generate `spec.md` and `tasks.json` in `.grok/specs/[feature-name]_[type]_[date]/`.
   - Validate `tasks.json` using `.grok/agents/task-schema-validator.md` to ensure the 14-field schema: `id`, `type`, `title`, `description`, `status`, `priority`, `created_date`, `ux_ui_reviewed`, `theme_changes`, `completed_date`, `target_files`, `dependencies`, `linked_task`, `acceptance_criteria`.
7. **Update Roadmap**:
   - Append to the Progress Log in `.grok/product/roadmap.md`:
     ```
     [YYYY-MM-DD] – [Task Name]
     Status: in_progress
     Spec: .grok/specs/[feature-name]_[type]_[date]/
     ```
8. **Log Next Task Selection**:
   - Use `.grok/agents/logger.md` in write mode to record task selection in `.grok/changelog.md`.

## Dashboard Integration
- The dashboard triggers `--next` via a button or menu option.
- Displays the selected task and generated spec path in the interface.

## Error Handling
- **Missing Roadmap** [ERR_004]: Return "Error [ERR_004]: `.grok/product/roadmap.md` not found. Run /sdd-task --roadmap first."
- **No Pending Tasks**: Return "Error: No pending tasks in roadmap."
- **Empty Phases**: Skip to the next phase with pending tasks or return "Error: No active phases with pending tasks."
- **Schema Validation Failure** [ERR_003]: Return validation errors from `.grok/agents/task-schema-validator.md`.

## Example Usage
```
grok_sdd_next()
```
**Example Output**:
```
Found next task in Phase 1: 'Create Text Display component'
Creating spec...
Spec created at .grok/specs/text-display-component_feature_2025-08-22/
Created spec.md and tasks.json (validated)
Updated roadmap progress log
```