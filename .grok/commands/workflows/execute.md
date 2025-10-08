# {{platform_vars.command_prefix}}sdd-task --execute <task-id> [task-id ...]

PURPOSE: Execute one or more SDD tasks end-to-end with guardrails, design consultation, implementation, testing, and logging.

AGENT_EXECUTION_WORKFLOW: Task implementation with proactive theme guidance and quality assurance

WORKFLOW_STEPS:

0. LOGGER_READ: INVOKE {{agents.logger}} → recent_changes

1. CONTEXT_INIT: INVOKE {{agents.context_manager}} → workflow_context, caching

SEQUENCE_GUARDS:
- PRE_FLIGHT:
  - REQUIRE dispatcher pre-flight validations completed
  - IF not → RETURN {{errors.shared.ERR_014}}
- AGENT_GATES:
  - REQUIRE logger (read) invoked before modifications
  - REQUIRE context_manager invoked before implementation
  - IF missing → RETURN {{errors.shared.ERR_011}} (logger) / {{errors.shared.ERR_013}} (context)
- ORDER_ENFORCEMENT:
  - IF steps executed out of order → RETURN {{errors.shared.ERR_012}}

BATCH_EXECUTION:
- ACCEPT multiple task_id arguments
- PROCESS each task_id sequentially through the full execution pipeline
- COLLECT results for each task
- PERFORM phase completion check once after all tasks complete

2. FOR EACH task_id in arguments:
   a. TASK_RESOLVE: locate_validate(task_id) → specs_dir
      - VALIDATE task_id against `{{constraints.task_id_regex}}`; REJECT invalid with {{errors.shared.ERR_003}}
      - VALIDATE specs_dir name conforms to `{{constraints.spec_dir_pattern}}`; REJECT legacy with {{errors.shared.ERR_003}}

   b. DEPENDENCY_CHECK: validate(dependent_tasks[]) → all_completed

   c. PATH_CONFIRM: determine(target_files[]) → implementation_paths[]

   d. TECH_STACK_CHECK: analyze_framework() → MCP_compatibility

   e. THEME_CONSULTATION: READ {{agents.designer}} for design guidance
   - EXECUTE theme consultation using read_file tool → css_classes[], widget_template, compliance_checklist[]

   f. MCP_INTEGRATION: IF shadcn_detected → mcp_install(components[])

   g. THEME_AWARE_IMPLEMENTATION: generate_code(task_spec, designer_guidance) → compliant_code

   h. GIT_OPS: IF repo_exists → version_control_operations

   i. TEST_EXECUTION: READ {{agents.test_runner}} for testing guidance
   - EXECUTE test execution using run_terminal_cmd tool → test_results

   j. THEME_VALIDATION: READ {{agents.code_reviewer}} for code review guidance
   - EXECUTE theme validation using read_file and grep tools → final_compliance_check

   k. STATUS_UPDATE: mark_completed(task_id) → schema_validation
      - USE Edit tool to update tasks.json: status="completed", completed_date=today
      - READ {{agents.task_schema_validator}} for schema validation guidance
      - EXECUTE schema validation using read_file tool to validate the update
      - VERIFY file was actually modified

   l. COLLECT_RESULTS: store execution results for final phase completion check

3. PHASE_COMPLETION_CHECK: check_phase_completion(all_specs_dirs, all_task_ids) → phase_completion_status
  - READ tasks.json from all processed specs_dirs to get comprehensive task status
  - EXTRACT phase information from all completed tasks
  - READ roadmap.md to check current phase completion status
  - QUERY all tasks across all phases to determine completion status
  - FOR each completed phase:
    a. UPDATE roadmap.md checkboxes from [ ] to [x] for completed phase items
    b. LOG phase completion in changelog entry
    c. READ {{agents.architecture_visualizer}} for architecture update guidance
    d. EXECUTE architecture visualization using read_file and search_replace tools to update component relationships and completion status

4. LOG_COMPLETION: READ {{agents.logger}} for logging guidance
- EXECUTE logging using search_replace tool with spec_dir_paths=all_specs_dirs, task_ids=all_task_ids, summary=batch_workflow_results → changelog_status
