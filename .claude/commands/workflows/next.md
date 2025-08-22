# /sdd-task --next Workflow

Identifies and creates a spec for the next pending task in the roadmap when `/sdd-task --next` is invoked. Operates within the `.claude/` directory structure and integrates with the Agent-SDD Dashboard.

## Purpose
- Automate spec creation for the next pending task from `.claude/product/roadmap.md`.
- Maintain sequential development by linking roadmap tasks to specs.
- Ensure generated `tasks.json` conforms to the 12-field schema using `.claude/agents/task-schema-validator.md`.

## Directory Context
Uses the `.claude/` structure:
- **Product**: `.claude/product/` (roadmap.md)
- **Specs**: `.claude/specs/create-spec-[task-id]-[date]/` (spec.md, tasks.json)
- **Commands**: `.claude/commands/workflows/` (spec.md for spec creation)
- **Agents**: `.claude/agents/` (task-schema-validator.md, file-creator.md, context-fetcher.md)

## Command Syntax
```
/sdd-task --next
```
- **Arguments**: None.

## Workflow
1. **Parse Input**:
   - Read `/sdd-task --next` via CLI or dashboard.
2. **Read Roadmap**:
   - Load `.claude/product/roadmap.md` using `.claude/agents/context-fetcher.md`.
3. **Identify Active Phase**:
   - Scan roadmap for phases (e.g., Phase 1, Phase 2) and identify the first phase with pending `[ ]` tasks.
4. **Select Next Task**:
   - Pick the first incomplete task (marked `[ ]`) in the active phase.
   - Use the task’s description as the feature name for spec creation.
5. **Create Spec**:
   - Trigger `.claude/commands/workflows/spec.md` with the task’s description as the feature name.
   - Use `.claude/agents/file-creator.md` to generate `spec.md` and `tasks.json` in `.claude/specs/create-spec-[task-id]-[date]/`.
   - Validate `tasks.json` using `.claude/agents/task-schema-validator.md` to ensure the 12-field schema: `id`, `type`, `title`, `description`, `status`, `priority`, `created_date`, `ux_ui_reviewed`, `theme_changes`, `completed_date`, `target_files`, `dependencies`, `linked_task`, `acceptance_criteria`.
6. **Update Roadmap**:
   - Append to the Progress Log in `.claude/product/roadmap.md`:
     ```
     [YYYY-MM-DD] – [Task Name]
     Status: in_progress
     Spec: .claude/specs/create-spec-[task-id]-[date]/
     ```

## Dashboard Integration
- The dashboard triggers `--next` via a button or menu option.
- Displays the selected task and generated spec path in the interface.

## Error Handling
- **Missing Roadmap**: Return "Error: `.claude/product/roadmap.md` not found. Run /sdd-task --roadmap first."
- **No Pending Tasks**: Return "Error: No pending tasks in roadmap."
- **Empty Phases**: Skip to the next phase with pending tasks or return "Error: No active phases with pending tasks."
- **Schema Validation Failure**: Return errors from `.claude/agents/task-schema-validator.md`.

## Example Usage
```
/sdd-task --next
```
**Example Output**:
```
Found next task in Phase 1: 'Create Text Display component'
Creating spec...
Spec created at .claude/specs/create-spec-TXT-001-2025-08-22/
Created spec.md and tasks.json (validated)
Updated roadmap progress log
```