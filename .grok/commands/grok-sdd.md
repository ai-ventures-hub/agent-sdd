# Grok-SDD Function Call Dispatcher

The Grok-SDD framework provides structured software development through natural language conversations with Grok. It operates within the `.grok/` directory structure and uses function calls to execute workflows and agents, ensuring task validation and consistency.

## Purpose
- Centralize all Grok-SDD operations through natural language requests processed by function calls
- Provide structured development workflows while maintaining conversational flexibility
- Validate tasks using `.grok/agents/task-schema-validator.md` for relevant operations
- Support workflow execution through Grok's function calling capabilities

## Directory Context
Operates within the `.grok/` structure:
- **Standards**: `.grok/standards/` (tech-stack.md, theme-standards.md, best-practices.md)
- **Product**: `.grok/product/` (overview.md, roadmap.md, decisions.md)
- **Specs**: `.grok/specs/[feature-name]_[type]_[date]/` (spec.md, tasks.json)
- **Commands**: `.grok/commands/` (grok-sdd.md, workflows/)
- **Agents**: `.grok/agents/` (task-schema-validator.md, context-fetcher.md, file-creator.md, date-checker.md, test-runner.md, code-reviewer.md, logger.md)

## Function Call Interface
Available operations through natural language requests:

### Available Operations
| Operation     | Description                                              | Function Call Trigger                     |
|---------------|----------------------------------------------------------|-------------------------------------------|
| `roadmap`     | Plan product roadmap and milestones                      | `grok_sdd_roadmap()`                      |
| `next`        | Create spec for the next roadmap task                    | `grok_sdd_next()`                         |
| `spec`        | Create a Software Design Document                        | `grok_sdd_spec(feature, description)`     |
| `execute`     | Execute a task end-to-end (includes tests, auto style fixes) | `grok_sdd_execute(task_id)`               |
| `update`      | Apply UI/UX enhancements or improvements to working code | `grok_sdd_update(target_file)`            |
| `fix`         | Apply targeted fixes to resolve bugs or broken functionality | `grok_sdd_fix(task_id, description)`      |
| `edit`        | Apply simple, lightweight edits without full spec overhead | `grok_sdd_edit(description)`              |
| `review`      | Review code for theme compliance                        | `grok_sdd_review(paths)`                  |
| `analyze`     | Analyze project for issues and improvements              | `grok_sdd_analyze(paths)`                 |
| `check`       | Verify task completion                                   | `grok_sdd_check(task_id)`                 |

## Workflow Dispatch
Each operation triggers a corresponding workflow in `.grok/commands/workflows/`:
1. **`roadmap`**: Executes `workflows/roadmap.md` to update `.grok/product/roadmap.md` with milestones and tasks.
2. **`next`**: Executes `workflows/next.md` to identify the next task from `.grok/product/roadmap.md` and create a spec in `.grok/specs/`.
3. **`spec`**: Executes `workflows/spec.md` to create a spec in `.grok/specs/[feature-name]_[type]_[date]/` using the provided feature name and description. Prompts for UI focus (sets `theme_changes: true` in tasks.json if UI-focused).
4. **`execute`**: Executes `workflows/execute.md` to implement a task from a spec, running tests via `.grok/agents/test-runner.md` and applying style fixes via `.grok/agents/code-reviewer.md`.
5. **`update`**: Executes `workflows/update.md` to apply UI/UX enhancements or improvements to working code, including tests and style fixes, with required user verification before completion (lightweight workflow - no spec creation).
6. **`fix`**: Executes `workflows/fix.md` to apply targeted fixes for bugs or broken functionality, with optional task context via `<task-id>` parameter and required user verification before completion (lightweight workflow - no spec creation).
7. **`edit`**: Executes `workflows/edit.md` to apply simple, lightweight edits with minimal overhead and required user verification before completion - uses logger agents at start and end only.
8. **`review`**: Executes `workflows/review.md` to check modified paths against `.grok/standards/theme-standards.md` using `.grok/agents/code-reviewer.md`.
9. **`analyze`**: Executes `workflows/analyze.md` to scan the project for issues and suggest improvements.
10. **`check`**: Executes `workflows/check.md` to verify task completion against `tasks.json` using `.grok/agents/task-schema-validator.md`.

## Task Schema Validation
For operations involving task specs (`spec`, `execute`, `check`):
- Invokes `.grok/agents/task-schema-validator.md` to validate `tasks.json` in the relevant spec directory.
- Ensure the 14-field schema: `id`, `type`, `title`, `description`, `status`, `priority`, `created_date`, `ux_ui_reviewed`, `theme_changes`, `completed_date`, `target_files`, `dependencies`, `linked_task`, `acceptance_criteria`.

## Natural Language Integration
- Grok-SDD responds to natural language requests that map to function calls
- For `spec` operations, prompts: "Is this a UI task?" to set `theme_changes: true` and add UI sections to `spec.md`.
- For `update` operations, prompts for target file/component and description.
- For `fix` operations, prompts for issue description and provides task-id context.

## Operation Purpose Quick Reference
- **`update`**: Enhance working code (styling, features, improvements)
- **`fix`**: Resolve broken code (bugs, errors, failures)
- **`edit`**: Simple, lightweight edits (typos, formatting, minor changes)
- **`execute`**: Implement new features from specs
- **`review`**: Check code for theme/accessibility compliance
- **`analyze`**: Scan project for potential issues

## Execution Flow
1. **Parse Request**: Interpret natural language request and map to appropriate function call
   - **Parameter Extraction**: Extract operation type and arguments from conversation context
   - **Validation**: Check argument format and requirements for each operation type
2. **Read Changelog Context**: Use `.grok/agents/logger.md` in read mode to gather recent project changes and context for informed decision-making
3. **Validate Task (if applicable)**: For `spec`, `execute`, `check`, run `.grok/agents/task-schema-validator.md` to ensure valid `tasks.json`
4. **Fetch Context**: Use `.grok/agents/context-fetcher.md` to gather relevant files (e.g., `.grok/standards/theme-standards.md` for `review`)
5. **Execute Workflow**: Call the corresponding `workflows/<operation>.md` script
6. **Create/Update Files**: Use `.grok/agents/file-creator.md` to generate or update files (e.g., `spec.md`, `tasks.json`)
7. **Run Tests/Checks**: For `execute`, `update`, and `fix`, invoke `.grok/agents/test-runner.md` and `.grok/agents/code-reviewer.md` for tests and style fixes
8. **User Verification**: For `update`, `fix`, and `edit`, prompt user to verify changes work as expected before proceeding to completion
9. **Verify Dates**: Use `.grok/agents/date-checker.md` to ensure valid `created_date` and `completed_date` in `tasks.json`
10. **Output Result**: Return success/failure message and update relevant files (e.g., `.grok/specs/`, `.grok/product/roadmap.md`)
11. **Log Task Completion**: Use `.grok/agents/logger.md` in write mode to record a brief summary of the completed task in `.grok/changelog.md` - only after user verification for applicable workflows

## Error Handling
- **Invalid Operation** [ERR_001]: Return "Error [ERR_001]: Invalid operation. Please specify a valid Grok-SDD operation."
- **Missing Arguments** [ERR_002]: Prompt for required arguments (e.g., "Error [ERR_002]: spec operation requires feature name and description").
- **Parameter Validation** [ERR_002A]: Return "Error [ERR_002A]: Invalid parameters for fix operation. Expected task_id or description."
- **Invalid Task Schema** [ERR_003]: Return validation errors from `.grok/agents/task-schema-validator.md`.
- **File Not Found** [ERR_004]: Return "Error [ERR_004]: Required file (e.g., `.grok/standards/theme-standards.md`) not found."
- **Task Not Found** [ERR_005]: Return "Error [ERR_005]: Task ID not found in any specs directory."
- **Git Operation Failed** [ERR_006]: Return "Error [ERR_006]: Git operation failed. Check repository status."
- **Test Failure** [ERR_007]: Return "Error [ERR_007]: Tests failed. Review test output for details."
- **Theme Compliance** [ERR_008]: Return "Error [ERR_008]: Theme compliance check failed. See report for violations."

## Natural Language Usage Examples

**Spec Creation:**
- "Create a spec for user login with validation"
- "I need to design a responsive login form"
- "Plan a new feature for user authentication"

**Task Execution:**
- "Execute task T123 from the specs"
- "Implement the login page feature we just specified"
- "Build the user registration functionality"

**Code Updates:**
- "Update the Button component styling"
- "Enhance the login form with better UX"
- "Improve the navigation component"

**Bug Fixes:**
- "Fix the login validation bug"
- "Resolve the button hover state issue in BTN-012"
- "There's a problem with the form submission"

**Lightweight Edits:**
- "Fix the typo in the welcome message"
- "Update the button text to say 'Sign In' instead of 'Login'"
- "Change the color scheme to match our theme"

**Analysis & Review:**
- "Analyze the project for potential issues"
- "Review the recent changes for theme compliance"
- "Check if task T123 is completed"

**Planning:**
- "Plan the product roadmap for the next quarter"
- "Create a spec for the next important feature"
- "Let's map out our development milestones"