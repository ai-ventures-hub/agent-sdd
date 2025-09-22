# sdd-task --execute <task-id>

PURPOSE: Execute a specific SDD task end-to-end with guardrails, design consultation, implementation, testing, and logging.

AGENT_EXECUTION_WORKFLOW: Task implementation with proactive theme guidance and quality assurance

---

WORKFLOW_STEPS:

1. CONTEXT_INIT: {{agents.context_manager}} → workflow_context, caching

SEQUENCE_GUARDS:
- PRE_FLIGHT:
  - REQUIRE dispatcher pre-flight validations completed
  - IF not → RETURN [ERR_014]
- AGENT_GATES:
  - REQUIRE logger (read) invoked before modifications
  - REQUIRE context-manager invoked before implementation
  - IF missing → RETURN [ERR_011] (logger) / [ERR_013] (context)
- ORDER_ENFORCEMENT:
  - IF steps executed out of order → RETURN [ERR_012]

2. TASK_RESOLVE: locate_validate(task_id) → specs_dir
  - VALIDATE task_id against `^[A-Z]+-[0-9]{3}$`; REJECT invalid with [ERR_003]
  - VALIDATE specs_dir name conforms to `{slug}_{type}_{YYYY-MM-DD}`; REJECT legacy with [ERR_003]

3. DEPENDENCY_CHECK: validate(dependent_tasks[]) → all_completed

4. PATH_CONFIRM: determine(target_files[]) → implementation_paths[]

5. TECH_STACK_CHECK: analyze_framework() → MCP_compatibility

6. THEME_CONSULTATION: {{agents.designer}} → css_classes[], widget_template, compliance_checklist[]

7. MCP_INTEGRATION: IF shadcn_detected → mcp_install(components[])

8. THEME_AWARE_IMPLEMENTATION: generate_code(task_spec, designer_guidance) → compliant_code

9. GIT_OPS: IF repo_exists → version_control_operations

10. TEST_EXECUTION: {{agents.test_runner}} → test_results

11. THEME_VALIDATION: {{agents.code_reviewer}} → final_compliance_check

12. STATUS_UPDATE: mark_completed(task_id) → schema_validation

13. LOG_COMPLETION: {{agents.logger}}(mode="write", spec_dir_path=specs_dir, task_id=task_id, summary=workflow_results) → phase_completion_status
