# Agent-SDD Command Dispatcher: /sdd-task

COMMAND_SYNTAX: /sdd-task --<flag> [arguments]

SUPPORTED_FLAGS:
- --init: Initialize project with intelligent analysis & roadmap
- --bootstrap: Setup development boilerplate and invoke project starter [--shadcn]
- --next: Analyze roadmap for next task and generate spec sheet
- --spec: Create Software Design Document with task decomposition
- --execute: Execute task end-to-end with tests and style fixes
- --improve: Apply enhancements, fixes, or refactoring
- --edit: Apply simple, lightweight edits
- --evolve: Run framework self-improvement and analytics cycle

WORKFLOW_DISPATCH:
- READ .claude/config/variables.yml → commands map
- IF flag ∉ commands map → RETURN [ERR_001]
- ELSE:
  - SELECT output style:
    - style_name := variables.output_styles.by_flag[flag] || variables.output_styles.default
    - APPLY `/output-style ${style_name}` (project-level)
  - ROUTE to commands[flag].workflow

WORKFLOW_DEPENDENCY_MATRIX:
- --init: Can run first on any project (no dependencies)
- --bootstrap: Can run on empty projects OR after --init on existing projects
- --next: Requires .claude/product/overview.md and .claude/product/roadmap.md
- --spec: Requires .claude/product/ overview.md, roadmap.md, tech-stack.md, best-practices.md + design artifacts
- --execute: Requires .claude/specs/{task}/spec.md and tasks.json
- --improve: Independent (can run anytime, may reference existing files)
- --edit: Independent (lightweight changes, no spec overhead)
- --evolve: Independent (can run anytime to improve framework health)

WORKFLOW_DEPENDENCY_VALIDATION:
- VALIDATE_REQUIRED_FILES: Check existence of dependency files before execution
- SEQUENCE_ENFORCEMENT: Prevent out-of-order workflow execution
- DEPENDENCY_CHAIN_CHECK: Verify complete dependency chain is satisfied

SEQUENCE_GUARD:
- IF pre-flight validations not completed → RETURN [ERR_014] or [ERR_012]
- IF workflow dependencies not met → RETURN [ERR_004] with dependency list
- IF sequence violation detected → RETURN [ERR_012] with correct order

TASK_SCHEMA_VALIDATION:
- FOR --spec, --execute: analyze complexity using task-decomposer.md
- IF score ≥ 70: decompose into 4-8 tasks with dependencies
- VALIDATE using task-schema-validator.md
- ENFORCE 14-field schema: id, type, title, description, status, priority, created_date, ux_ui_reviewed, theme_changes, completed_date, target_files, dependencies, linked_task, acceptance_criteria

PRE_FLIGHT_VALIDATION:
- COMMAND must start with /sdd-task --
- CONFIRM Agent-SDD framework active
- READ dispatcher file first
- USE Task tool for ALL agent invocations

EXECUTION_FLOW:
1. PARSE input: /sdd-task --<flag> [arguments]
2. MANDATORY: Task tool subagent_type="logger" read mode
3. VALIDATE task: Task tool subagent_type="task-schema-validator"
4. MANDATORY: Task tool subagent_type="context-manager"
5. EXECUTE corresponding workflows/<flag>.md
6. CREATE files: Task tool subagent_type="file-creator"
7. RUN tests: Task tool subagent_type="test-runner"
8. QUALITY validation: Task tool subagent_type="code-reviewer"
9. VERIFY dates: Task tool subagent_type="date-checker"
10. OUTPUT result and update files
11. MANDATORY: Task tool subagent_type="logger" write mode

FILE_LOCKING_PROTOCOL:
- CHECK for existing locks: {target_changelog}.lock
- ACQUIRE lock with process ID and timestamp
- WAIT up to 5 seconds for acquisition
- VALIDATE lock file contents
- RELEASE lock after operations
- FAIL if lock cannot be acquired

ERROR_HANDLING:
- WORKFLOW_BYPASS [ERR_010]: Direct file modification detected
- MISSING_AGENT_INVOCATION [ERR_011]: Required agent not invoked
- STEP_SEQUENCE_VIOLATION [ERR_012]: Steps executed out of order
- CONTEXT_GATHERING_SKIPPED [ERR_013]: Context manager not invoked
- PRE_FLIGHT_FAILED [ERR_014]: Pre-flight validation failed
- MCP_UNREACHABLE [ERR_015]: MCP server connectivity failed
- MCP_COMMAND_FAILED [ERR_016]: MCP command execution failed
- NETWORK_TIMEOUT [ERR_017]: Network operation timed out
- FILE_WRITE_FAILED [ERR_018]: File write operation failed
- DIR_CREATION_FAILED [ERR_019]: Directory creation failed
- PERMISSION_DENIED [ERR_020]: Insufficient permissions
- INVALID_WORKFLOW_TYPE [ERR_021]: Invalid workflow type specified
- HIGH_RISK_REJECTED [ERR_022]: High-risk change rejected
- TARGET_NOT_FOUND [ERR_023]: Target file/directory not found
- DATE_FORMAT_ERROR [ERR_024]: Invalid date format
- INVALID_FLAG [ERR_001]: Invalid flag provided
- MISSING_ARGUMENTS [ERR_002]: Required arguments missing
- PARAMETER_PARSING [ERR_002A]: Invalid parameter format
- INVALID_TASK_SCHEMA [ERR_003]: Schema validation failed
- FILE_NOT_FOUND [ERR_004]: Required file not found
- TASK_NOT_FOUND [ERR_005]: Task ID not found
- GIT_OPERATION_FAILED [ERR_006]: Git operation failed
- TEST_FAILURE [ERR_007]: Tests failed
- THEME_COMPLIANCE [ERR_008]: Theme compliance check failed
- FILE_LOCK_FAILED [ERR_009]: Cannot acquire file lock
