# {{platform_vars.command_prefix}}sdd-task --spec

PURPOSE: Generate a full SDD task specification from product documentation.

WORKFLOW_STEPS:

SEQUENCE_GUARDS:
- PRE_FLIGHT:
  - REQUIRE dispatcher pre-flight validations completed
  - IF not → RETURN {{errors.shared.ERR_014}}
- DEPENDENCY_VALIDATION:
  - REQUIRE {{paths.overview_file}} exists and readable → IF missing → RETURN {{errors.next_spec_docs.ERR_005}}
  - REQUIRE {{paths.roadmap_file}} exists and readable → IF missing → RETURN {{errors.next_spec_docs.ERR_004}}
  - REQUIRE {{paths.tech_stack_file}} exists and readable → IF missing → RETURN {{errors.next_spec_docs.ERR_006}}
  - REQUIRE {{paths.best_practices_file}} exists and readable → IF missing → RETURN {{errors.next_spec_docs.ERR_007}}
  - CHECK design artifacts: {{paths.product_dir}}/pages/ (optional but recommended)
  - VERIFY all required files contain valid content (non-empty, proper structure)
- ORDER_ENFORCEMENT:
  - IF steps executed out of order → RETURN {{errors.shared.ERR_012}}

STEP_1_PROJECT_VALIDATION:
- CHECK {{paths.overview_file}} exists
  - IF missing → TRIGGER auto_init_guidance
- CHECK {{paths.roadmap_file}} exists
  - IF missing → TRIGGER auto_init_guidance
- CHECK {{paths.tech_stack_file}} exists
  - IF missing → TRIGGER auto_init_guidance
- CHECK {{paths.best_practices_file}} exists
  - IF missing → TRIGGER auto_init_guidance
- OPTIONAL: design artifacts in {{paths.product_dir}}/pages/

AUTO_INIT_GUIDANCE:
- DETECT missing_files_count → required_files_list
- IF all_missing → RETURN "Run '{{platform_vars.command_prefix}}sdd-task --init' first to generate required project files. This will create overview.md, roadmap.md, tech-stack.md, and best-practices.md."
- IF partial_missing → RETURN "Missing files: {file_list}. Run '{{platform_vars.command_prefix}}sdd-task --init' to regenerate all project files or manually create missing files."
- PROVIDE workflow_sequence_help: "--init → --spec → --execute"

STEP_2_DOCUMENT_REVIEW:
- READ {{agents.context_manager}} for context gathering guidance
- EXECUTE context gathering using read_file tool → overview.md, roadmap.md, wireframes, user-journeys, tech-stack.md, best-practices.md

STEP_3_TASK_IDENTIFICATION:
- READ {{agents.project_analyzer}} for roadmap parsing guidance
- EXECUTE roadmap analysis using read_file and grep tools → phase_structure, phase1_tasks, dependencies

STEP_4_SPECIFICATION_GENERATION:
- READ {{agents.file_creator}} for specification creation guidance
- EXECUTE file creation using search_replace tool → functional_requirements, technical_specs, acceptance_criteria, implementation_guidelines

STEP_5_TASK_DECOMPOSITION:
- READ {{agents.task_decomposer}} for task decomposition guidance
- EXECUTE scope analysis using read_file and grep tools → scope_evaluation, complexity_score, task_breakdown

STEP_6_SCHEMA_VALIDATION:
- READ {{agents.task_schema_validator}} for schema validation guidance
- EXECUTE full schema validation using read_file and search_replace tools → tasks.json validation
- IF validation_fails → RETRY with simplified_schema
- IF retry_fails → EXECUTE light schema validation using simplified rules
- IF all_validation_fails → RETURN {{errors.shared.ERR_003}} with schema_help

STEP_7_DIRECTORY_CREATION:
- READ {{agents.file_creator}} for directory creation guidance
- EXECUTE directory creation using run_terminal_cmd tool → spec_dir_path
- ATTEMPT pattern: {task_slug}_{type}_{YYYY-MM-DD}
- IF pattern_fails → FALLBACK to {task_slug}_{timestamp}
- IF fallback_fails → FALLBACK to {task_slug}_spec
- IF all_patterns_fail → RETURN {{errors.next_spec_docs.ERR_008}} with directory_help

STEP_8_FINAL_VALIDATION:
- VALIDATE content completeness, consistency, technical feasibility

ERROR_HANDLING:
- MISSING_OVERVIEW {{errors.next_spec_docs.ERR_005}} → "Missing overview.md. Run '{{platform_vars.command_prefix}}sdd-task --init' to generate required project files. Workflow: --init → --spec → --execute"
- MISSING_ROADMAP {{errors.next_spec_docs.ERR_004}} → "Missing roadmap.md. Run '{{platform_vars.command_prefix}}sdd-task --init' to generate required project files. Workflow: --init → --spec → --execute"
- MISSING_TECH_STACK {{errors.next_spec_docs.ERR_006}} → "Missing tech-stack.md. Run '{{platform_vars.command_prefix}}sdd-task --init' to generate required project files. Workflow: --init → --spec → --execute"
- MISSING_BEST_PRACTICES {{errors.next_spec_docs.ERR_007}} → "Missing best-practices.md. Run '{{platform_vars.command_prefix}}sdd-task --init' to generate required project files. Workflow: --init → --spec → --execute"
- SCHEMA_VALIDATION_FAILED {{errors.shared.ERR_003}} → "Task schema validation failed. Retrying with simplified schema. If this persists, check task complexity."
- DIRECTORY_PATTERN_FAILED {{errors.next_spec_docs.ERR_008}} → "Directory pattern validation failed. Using fallback naming pattern."

RECOVERY_STRATEGIES:
- missing_files → auto_init_guidance + workflow_sequence
- schema_fails → progressive_degradation: full → simplified → light
- pattern_fails → fallback_patterns: standard → timestamp → simple
- all_fails → actionable_error_with_next_steps
