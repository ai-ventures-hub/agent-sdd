# sdd-task --spec

PURPOSE: Generate a full SDD task specification from product docs and standards.

WORKFLOW_STEPS:

SEQUENCE_GUARDS:
- PRE_FLIGHT:
  - REQUIRE dispatcher pre-flight validations completed
  - IF not → RETURN {{errors.shared.ERR_014}}
- ORDER_ENFORCEMENT:
  - IF steps executed out of order → RETURN {{errors.shared.ERR_012}}

STEP_1_PROJECT_VALIDATION:
- CHECK {{paths.product_dir}}/overview.md exists
  - IF missing → TRIGGER auto_init_guidance
- CHECK {{paths.product_dir}}/roadmap.md exists
  - IF missing → TRIGGER auto_init_guidance
- CHECK {{paths.standards_dir}}/tech-stack.md exists
  - IF missing → TRIGGER auto_init_guidance
- CHECK {{paths.standards_dir}}/best-practices.md exists
  - IF missing → TRIGGER auto_init_guidance
- OPTIONAL: design artifacts in {{paths.product_dir}}/pages/

AUTO_INIT_GUIDANCE:
- DETECT missing_files_count → required_files_list
- IF all_missing → RETURN "Run '/sdd-task --init' first to generate required project files. This will create overview.md, roadmap.md, tech-stack.md, and best-practices.md."
- IF partial_missing → RETURN "Missing files: {file_list}. Run '/sdd-task --init' to regenerate all project files or manually create missing files."
- PROVIDE workflow_sequence_help: "--init → --spec → --execute"

STEP_2_DOCUMENT_REVIEW:
- {{agents.context_manager}}(mode="gather") → overview.md, roadmap.md, wireframes, user-journeys, tech-stack.md, best-practices.md

STEP_3_TASK_IDENTIFICATION:
- {{agents.project_analyzer}}(mode="roadmap_parse") → phase_structure, phase1_tasks, dependencies

STEP_4_SPECIFICATION_GENERATION:
- {{agents.file_creator}}(mode="spec") → functional_requirements, technical_specs, acceptance_criteria, implementation_guidelines

STEP_5_TASK_DECOMPOSITION:
- {{agents.task_decomposer}}(mode="analyze") → scope_evaluation, complexity_score, task_breakdown

STEP_6_SCHEMA_VALIDATION:
- {{agents.task_schema_validator}}(mode="full") → tasks.json validation
- IF validation_fails → RETRY with simplified_schema
- IF retry_fails → {{agents.task_schema_validator}}(mode="light") → minimal_validation
- IF all_validation_fails → RETURN {{errors.shared.ERR_003}} with schema_help

STEP_7_DIRECTORY_CREATION:
- {{agents.file_creator}}(mode="spec_directory") → spec_dir_path
- ATTEMPT pattern: {task_slug}_{type}_{YYYY-MM-DD}
- IF pattern_fails → FALLBACK to {task_slug}_{timestamp}
- IF fallback_fails → FALLBACK to {task_slug}_spec
- IF all_patterns_fail → RETURN {{errors.next_spec_docs.ERR_008}} with directory_help

STEP_8_FINAL_VALIDATION:
- VALIDATE content completeness, consistency, technical feasibility

ERROR_HANDLING:
- MISSING_OVERVIEW {{errors.next_spec_docs.ERR_005}} → "Missing overview.md. Run '/sdd-task --init' to generate required project files. Workflow: --init → --spec → --execute"
- MISSING_ROADMAP {{errors.next_spec_docs.ERR_004}} → "Missing roadmap.md. Run '/sdd-task --init' to generate required project files. Workflow: --init → --spec → --execute"
- MISSING_TECH_STACK {{errors.next_spec_docs.ERR_006}} → "Missing tech-stack.md. Run '/sdd-task --init' to generate required project files. Workflow: --init → --spec → --execute"
- MISSING_BEST_PRACTICES {{errors.next_spec_docs.ERR_007}} → "Missing best-practices.md. Run '/sdd-task --init' to generate required project files. Workflow: --init → --spec → --execute"
- SCHEMA_VALIDATION_FAILED {{errors.shared.ERR_003}} → "Task schema validation failed. Retrying with simplified schema. If this persists, check task complexity."
- DIRECTORY_PATTERN_FAILED {{errors.next_spec_docs.ERR_008}} → "Directory pattern validation failed. Using fallback naming pattern."

RECOVERY_STRATEGIES:
- missing_files → auto_init_guidance + workflow_sequence
- schema_fails → progressive_degradation: full → simplified → light
- pattern_fails → fallback_patterns: standard → timestamp → simple
- all_fails → actionable_error_with_next_steps

