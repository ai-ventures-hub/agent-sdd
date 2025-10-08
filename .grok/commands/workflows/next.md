# {{platform_vars.command_prefix}}sdd-task --next

PURPOSE: Determine and scaffold the next actionable task from roadmap and standards.

WORKFLOW_STEPS:

SEQUENCE_GUARDS:
- PRE_FLIGHT:
  - REQUIRE dispatcher pre-flight validations completed
  - IF not → RETURN {{errors.shared.ERR_014}}
- DEPENDENCY_VALIDATION:
  - REQUIRE {{paths.overview_file}} exists → IF missing → RETURN {{errors.next_spec_docs.ERR_005}}
  - REQUIRE {{paths.roadmap_file}} exists → IF missing → RETURN {{errors.next_spec_docs.ERR_004}}
  - VERIFY file readability and non-empty content
  - CHECK framework integrity: {{paths.base_dir}} accessible
- ORDER_ENFORCEMENT:
  - IF steps executed out of order → RETURN {{errors.shared.ERR_012}}

STEP_1_ROADMAP_ANALYSIS:
- CHECK {{paths.roadmap_file}} exists
  - IF missing → RETURN "Missing roadmap.md. Run '{{platform_vars.command_prefix}}sdd-task --init' first to generate required project files. Workflow: --init → --next → --execute"
- CHECK {{paths.overview_file}} exists
  - IF missing → RETURN "Missing overview.md. Run '{{platform_vars.command_prefix}}sdd-task --init' first to generate required project files. Workflow: --init → --next → --execute"
- READ roadmap.md → current_phase, task_status
- IDENTIFY next logical task based on dependencies
- EXTRACT task requirements and specifications

STEP_2_CONTEXT_GATHERING:
- READ {{agents.context_manager}} for context gathering guidance
- EXECUTE context gathering using read_file tool → overview.md, tech-stack.md, best-practices.md
- READ existing completed specifications for consistency

STEP_3_SPECIFICATION_GENERATION:
- READ {{agents.file_creator}} for specification creation guidance
- EXECUTE file creation using search_replace tool → spec.md with requirements, tech_specs, acceptance_criteria
- DOCUMENT implementation guidelines and standards compliance

STEP_4_TASK_DECOMPOSITION:
- READ {{agents.task_decomposer}} for task decomposition guidance
- EXECUTE complexity analysis using read_file and grep tools → complexity_score, task_breakdown
- APPLY 1-8 task breakdown based on complexity analysis

STEP_5_SCHEMA_VALIDATION:
- READ {{agents.task_schema_validator}} for schema validation guidance
- EXECUTE schema validation using read_file and search_replace tools → tasks.json validation
- IF validation_fails → RETRY with simplified_schema
- IF retry_fails → EXECUTE light validation using simplified schema
- IF all_validation_fails → RETURN {{errors.shared.ERR_003}} with "Task schema validation failed. Retrying with simplified schema. If this persists, check task complexity."

STEP_6_DIRECTORY_CREATION:
- READ {{agents.file_creator}} for directory creation guidance
- EXECUTE directory creation using run_terminal_cmd tool → spec_dir_path
- ATTEMPT pattern: {task_slug}_{feature|enhancement|fix}_{YYYY-MM-DD}
- IF pattern_fails → FALLBACK to {task_slug}_{timestamp}
- IF fallback_fails → FALLBACK to {task_slug}_next
- IF all_patterns_fail → RETURN {{errors.next_spec_docs.ERR_008}} with "Directory pattern validation failed. Using fallback naming pattern."

ERROR_HANDLING:
- MISSING_ROADMAP {{errors.next_spec_docs.ERR_004}} → "Missing roadmap.md. Run '{{platform_vars.command_prefix}}sdd-task --init' to generate required project files. Workflow: --init → --next → --execute"
- MISSING_OVERVIEW {{errors.next_spec_docs.ERR_005}} → "Missing overview.md. Run '{{platform_vars.command_prefix}}sdd-task --init' to generate required project files. Workflow: --init → --next → --execute"
- MISSING_TECH_STACK {{errors.next_spec_docs.ERR_006}} → "Missing tech-stack.md. Run '{{platform_vars.command_prefix}}sdd-task --init' to generate required project files. Workflow: --init → --next → --execute"
- MISSING_BEST_PRACTICES {{errors.next_spec_docs.ERR_007}} → "Missing best-practices.md. Run '{{platform_vars.command_prefix}}sdd-task --init' to generate required project files. Workflow: --init → --next → --execute"
- SCHEMA_VALIDATION_FAILED {{errors.shared.ERR_003}} → "Task schema validation failed. Retrying with simplified schema."
- DIRECTORY_PATTERN_FAILED {{errors.next_spec_docs.ERR_008}} → "Directory pattern validation failed. Using fallback naming pattern."

STEP_7_FINAL_VALIDATION:
- VALIDATE content completeness, consistency, technical feasibility