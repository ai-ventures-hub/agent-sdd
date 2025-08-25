# Agent-SDD Command Dispatcher: /sdd-task

The `/sdd-task` command is the primary interface for the Agent-SDD framework, streamlining structured software development with a single command and intuitive flags. It operates within the `.claude/` directory structure and integrates with the Agent-SDD Dashboard. This dispatcher routes user requests to specific workflows and agents, ensuring task validation and consistency.

## Purpose
- Centralize all Agent-SDD operations (roadmap planning, spec creation, task execution, etc.) via a single `/sdd-task` command with flags.
- Provide clear, development-aligned flags (e.g., `--spec`, `--execute`) while hiding workflow complexity.
- Validate tasks using `.claude/agents/task-schema-validator.md` for relevant flags.
- Support flag selection and execution via the Agent-SDD Dashboard.

## Directory Context
Operates within the `.claude/` structure:
- **Standards**: `.claude/standards/` (tech-stack.md, theme-standards.md, best-practices.md)
- **Product**: `.claude/product/` (overview.md, roadmap.md, decisions.md)
- **Specs**: `.claude/specs/create-spec-[task-id]-[date]/` (spec.md, tasks.json)
- **Commands**: `.claude/commands/` (sdd-task.md, workflows/)
- **Agents**: `.claude/agents/` (task-schema-validator.md, context-fetcher.md, file-creator.md, date-checker.md, test-runner.md, code-reviewer.md)

## Command Syntax
/sdd-task --<flag> [arguments]

### Supported Flags
| Flag        | Description                                              | Arguments                     |
|-------------|----------------------------------------------------------|-------------------------------|
| `--roadmap` | Plan product roadmap and milestones                      | None                          |
| `--next`    | Create spec for the next roadmap task                    | None                          |
| `--spec`    | Create a Software Design Document (lightweight or UI-focused) | Feature name                 |
| `--execute` | Execute a task end-to-end (includes tests, auto style fixes) | Task ID                     |
| `--update`  | Apply UI/UX enhancements or improvements to working code | Target file/component        |
| `--fix`     | Apply targeted fixes to resolve bugs or broken functionality | Optional task ID              |
| `--review`  | Review code for theme compliance                        | Modified paths                |
| `--analyze` | Analyze project for issues and improvements              | None                          |
| `--check`   | Verify task completion                                   | Task ID                       |

## Workflow Dispatch
Each flag triggers a corresponding workflow in `.claude/commands/workflows/`:
1. **--roadmap**: Executes `workflows/roadmap.md` to update `.claude/product/roadmap.md` with milestones and tasks.
2. **--next**: Executes `workflows/next.md` to identify the next task from `.claude/product/roadmap.md` and create a spec in `.claude/specs/`.
3. **--spec**: Executes `workflows/spec.md` to create a lightweight or UI-focused spec in `.claude/specs/create-spec-[task-id]-[date]/`. The dashboard prompts for UI focus (sets `theme_changes: true` in tasks.json if UI-focused).
4. **--execute**: Executes `workflows/execute.md` to implement a task from a spec, running tests via `.claude/agents/test-runner.md` and applying style fixes via `.claude/agents/code-reviewer.md`.
5. **--update**: Executes `workflows/update.md` to apply UI/UX enhancements or improvements to working code, including tests and style fixes.
6. **--fix**: Executes `workflows/fix.md` to apply targeted fixes for bugs or broken functionality, with optional task context via `<task-id>` parameter.
7. **--review**: Executes `workflows/review.md` to check modified paths against `.claude/standards/theme-standards.md` using `.claude/agents/code-reviewer.md`.
8. **--analyze**: Executes `workflows/analyze.md` to scan the project for issues and suggest improvements.
9. **--check**: Executes `workflows/check.md` to verify task completion against `tasks.json` using `.claude/agents/task-schema-validator.md`.

## Task Schema Validation
For flags involving tasks (`--spec`, `--execute`, `--update`, `--fix`, `--check`):
- Invokes `.claude/agents/task-schema-validator.md` to validate `tasks.json` in the relevant spec directory.
- Ensures the 12-field schema: `id`, `type`, `title`, `description`, `status`, `priority`, `created_date`, `ux_ui_reviewed`, `theme_changes`, `completed_date`, `target_files`, `dependencies`, `linked_task`, `acceptance_criteria`.

## Dashboard Integration
- The dashboard detects `.claude/` and provides a flag selector (e.g., dropdown for `--spec`, `--execute`).
- For `--spec`, prompts: "Is this a UI task?" to set `theme_changes: true` and add UI sections to `spec.md`.
- For `--update`, prompts for target file/component and description.
- For `--fix`, prompts for issue description and provides task-id selector for context.

## Flag Purpose Quick Reference
- **--update**: Enhance working code (styling, features, improvements)
- **--fix**: Resolve broken code (bugs, errors, failures)
- **--execute**: Implement new features from specs
- **--review**: Check code for theme/accessibility compliance
- **--analyze**: Scan project for potential issues

## Execution Flow
1. **Parse Input**: Read `/sdd-task --<flag> [arguments]` via CLI or dashboard.
   - **Optional Parameter Handling**: Flags with optional parameters (`--fix [<task-id>]`, `--analyze [paths...]`) use square bracket syntax.
   - **CLI Parser Requirements**: Must distinguish between optional arguments and subsequent flags.
   - **Validation**: Check argument format and count for each flag type.
2. **Validate Task (if applicable)**: For `--spec`, `--execute`, `--update`, `--fix`, `--check`, run `.claude/agents/task-schema-validator.md` to ensure valid `tasks.json`.
3. **Fetch Context**: Use `.claude/agents/context-fetcher.md` to gather relevant files (e.g., `.claude/standards/theme-standards.md` for `--review`).
4. **Execute Workflow**: Call the corresponding `workflows/<flag>.md` script.
5. **Create/Update Files**: Use `.claude/agents/file-creator.md` to generate or update files (e.g., `spec.md`, `tasks.json`).
6. **Run Tests/Checks**: For `--execute` and `--update`, invoke `.claude/agents/test-runner.md` and `.claude/agents/code-reviewer.md` for tests and style fixes.
7. **Verify Dates**: Use `.claude/agents/date-checker.md` to ensure valid `created_date` and `completed_date` in `tasks.json`.
8. **Output Result**: Return success/failure message and update relevant files (e.g., `.claude/specs/`, `.claude/product/roadmap.md`).

## Error Handling
- **Invalid Flag** [ERR_001]: Return "Error [ERR_001]: Invalid flag. Use /sdd-task --help for options."
- **Missing Arguments** [ERR_002]: Prompt for required arguments (e.g., "Error [ERR_002]: --spec requires feature name").
- **Parameter Parsing** [ERR_002A]: Return "Error [ERR_002A]: Invalid optional parameter format for --fix. Expected task-id or no arguments."
- **Invalid Task Schema** [ERR_003]: Return validation errors from `.claude/agents/task-schema-validator.md`.
- **File Not Found** [ERR_004]: Return "Error [ERR_004]: Required file (e.g., `.claude/standards/theme-standards.md`) not found."
- **Task Not Found** [ERR_005]: Return "Error [ERR_005]: Task ID not found in any specs directory."
- **Git Operation Failed** [ERR_006]: Return "Error [ERR_006]: Git operation failed. Check repository status."
- **Test Failure** [ERR_007]: Return "Error [ERR_007]: Tests failed. Review test output for details."
- **Theme Compliance** [ERR_008]: Return "Error [ERR_008]: Theme compliance check failed. See report for violations."

## Example Usage
/sdd-task --spec "User Login Page"
/sdd-task --execute T123
/sdd-task --update src/components/Button.js
/sdd-task --fix BTN-012          # Context-aware fix
/sdd-task --fix                  # Standalone fix
/sdd-task --analyze src/         # Optional paths
/sdd-task --analyze              # Analyze entire project
/sdd-task --roadmap