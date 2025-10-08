# Agent-SDD Universal Command Dispatcher

**FRAMEWORK EXECUTION MODE**: When processing `{{platform_vars.command_prefix}}sdd-task` commands, use platform-specific tools to execute workflows instead of agent invocations.

COMMAND_SYNTAX: {{platform_vars.command_prefix}}sdd-task --<flag> [arguments]

SUPPORTED_FLAGS:
Workflow support is defined in `{{paths.base_dir}}/config/variables.yml` under the `commands` map. Updating that registry is sufficient for new workflows; the dispatcher and docs reference it directly.

WORKFLOW_DISPATCH:
- READ {{paths.base_dir}}/config/variables.yml → commands map
- IF flag ∉ commands map → RETURN {{errors.shared.ERR_001}}
- ELSE:
  - SELECT output style:
    - style_name := variables.output_styles.by_flag[flag] || variables.output_styles.default
    - APPLY `{{platform_vars.command_prefix}}output-style ${style_name}` (project-level)
  - ROUTE to commands[flag].workflow

WORKFLOW_DEPENDENCY_MATRIX:
- --init: Can run first on any project (no dependencies)
- --bootstrap: Can run on empty projects OR after --init on existing projects
- --next: Requires {{paths.overview_file}} and {{paths.roadmap_file}}
- --spec: Requires {{paths.overview_file}}, {{paths.roadmap_file}}, {{paths.tech_stack_file}}, {{paths.best_practices_file}} + design artifacts
- --execute: Requires {{paths.specs_dir}}/{task}/spec.md and tasks.json
- --improve: Independent (can run anytime, may reference existing files)
- --edit: Independent (lightweight changes, no spec overhead)
- --evolve: Independent (can run anytime to improve framework health)
- --validate_system: Independent (can run anytime to check framework health)

WORKFLOW_DEPENDENCY_VALIDATION:
- DETECT_PROJECT_STATE: Check if --init has been run
- VALIDATE_REQUIRED_FILES: Check existence of dependency files before execution
- PROVIDE_GUIDANCE: Suggest correct workflow sequence for missing dependencies
- DEPENDENCY_CHAIN_CHECK: Verify complete dependency chain is satisfied

SEQUENCE_GUARD:
- IF pre-flight validations not completed → RETURN {{errors.shared.ERR_014}}
- IF --spec|--next|--execute without --init → RETURN workflow_guidance_message
- IF workflow dependencies not met → RETURN dependency_help_with_commands
- IF sequence violation detected → RETURN {{errors.shared.ERR_012}} with workflow_sequence

WORKFLOW_GUIDANCE_MESSAGES:
- init_required: "Run '{{platform_vars.command_prefix}}sdd-task --init' first to set up your project. This creates overview.md, roadmap.md, tech-stack.md, best-practices.md, and architecture.md."
- sequence_help: "Correct workflow sequence: --init → --spec → --execute"
- dependency_list: "Missing files: {files}. Run --init to generate required project documentation."

TASK_SCHEMA_VALIDATION:
- FOR --spec, --execute: analyze complexity using task-decomposer.md
- IF score ≥ 70: decompose into 4-8 tasks with dependencies
- VALIDATE using task-schema-validator.md
- ENFORCE 14-field schema: id, type, title, description, status, priority, created_date, ux_ui_reviewed, theme_changes, completed_date, target_files, dependencies, linked_task, acceptance_criteria

PRE_FLIGHT_VALIDATION:
- COMMAND must start with {{platform_vars.command_prefix}}sdd-task --
- CONFIRM framework active
- VALIDATE directory structure: Check {{paths.base_dir}}, {{paths.agents_dir}}, {{paths.commands_dir}} exist
- VALIDATE path variables: Ensure {{paths.*}} resolve to accessible paths and directories
- TEST file accessibility: Confirm key directories ({{paths.analytics_dir}}, {{paths.logs_dir}}, {{paths.product_dir}}) are writable
- READ dispatcher file first
- USE Task tool for ALL agent invocations
- VALIDATE command syntax and arguments

EXECUTION_FLOW:
1. PARSE input: {{platform_vars.command_prefix}}sdd-task --<flag> [arguments]
2. MANDATORY: Task tool subagent_type="logger" read mode (cached)
3. VALIDATE task: Task tool subagent_type="task-schema-validator" (lazy load)
4. MANDATORY: Task tool subagent_type="context_manager" (cached)
5. EXECUTE corresponding workflows/<flag>.md (lazy load required agents)
6. CREATE files: Task tool subagent_type="file-creator" (lazy load)
7. RUN tests: Task tool subagent_type="test-runner" (lazy load)
8. QUALITY validation: Task tool subagent_type="code-reviewer" (lazy load)
9. VERIFY dates: Task tool subagent_type="date-checker" (cached)
10. OUTPUT result and update files
11. MANDATORY: Task tool subagent_type="logger" write mode (cached)

AGENT_LOADING_OPTIMIZATION:
- CACHE frequently used agents: logger, context_manager, date_checker
- LAZY LOAD workflow-specific agents: file_creator, test_runner, code_reviewer, task_decomposer
- PRELOAD critical agents during pre-flight validation
- MAINTAIN agent cache across workflow steps
- INVALIDATE cache on framework updates

FILE_LOCKING_PROTOCOL:
- CHECK for existing locks: {target_changelog}.lock
- ACQUIRE lock with process ID and timestamp
- WAIT up to 5 seconds for acquisition
- VALIDATE lock file contents
- RELEASE lock after operations
- FAIL if lock cannot be acquired

ERROR_HANDLING:
- WORKFLOW_BYPASS {{errors.shared.ERR_010}}: Direct file modification detected
- MISSING_AGENT_INVOCATION {{errors.shared.ERR_011}}: Required agent not invoked
- STEP_SEQUENCE_VIOLATION {{errors.shared.ERR_012}}: Steps executed out of order
- CONTEXT_GATHERING_SKIPPED {{errors.shared.ERR_013}}: Context manager not invoked
- PRE_FLIGHT_FAILED {{errors.shared.ERR_014}}: Pre-flight validation failed
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
- INVALID_FLAG {{errors.shared.ERR_001}}: Invalid flag provided
- MISSING_ARGUMENTS {{errors.shared.ERR_002}}: Required arguments missing
- PARAMETER_PARSING {{errors.shared.ERR_002A}}: Invalid parameter format
- INVALID_TASK_SCHEMA {{errors.shared.ERR_003}}: Schema validation failed
- FILE_NOT_FOUND [ERR_004]: Required file not found
- TASK_NOT_FOUND [ERR_005]: Task ID not found
- GIT_OPERATION_FAILED [ERR_006]: Git operation failed
- TEST_FAILURE [ERR_007]: Tests failed
- THEME_COMPLIANCE [ERR_008]: Theme compliance check failed
- FILE_LOCK_FAILED [ERR_009]: Cannot acquire file lock
