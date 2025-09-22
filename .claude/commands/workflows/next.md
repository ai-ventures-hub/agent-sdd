# sdd-task --next

PURPOSE: Determine and scaffold the next actionable task from roadmap and standards.

WORKFLOW_STEPS:

SEQUENCE_GUARDS:
- PRE_FLIGHT:
  - REQUIRE dispatcher pre-flight validations completed
  - IF not → RETURN {{errors.shared.ERR_014}}
- ORDER_ENFORCEMENT:
  - IF steps executed out of order → RETURN {{errors.shared.ERR_012}}

STEP_1_ROADMAP_ANALYSIS:
- CHECK {{paths.product_dir}}/roadmap.md exists
  - IF missing → RETURN "Missing roadmap.md. Run '/sdd-task --init' first to generate required project files. Workflow: --init → --next → --execute"
- CHECK {{paths.product_dir}}/overview.md exists
  - IF missing → RETURN "Missing overview.md. Run '/sdd-task --init' first to generate required project files. Workflow: --init → --next → --execute"
- READ roadmap.md → current_phase, task_status
- IDENTIFY next logical task based on dependencies
- EXTRACT task requirements and specifications

STEP_2_CONTEXT_GATHERING:
- {{agents.context_manager}}(mode="gather") → overview.md, tech-stack.md, best-practices.md
- READ existing completed specifications for consistency

STEP_3_SPECIFICATION_GENERATION:
- {{agents.file_creator}}(mode="spec") → spec.md with requirements, tech_specs, acceptance_criteria
- DOCUMENT implementation guidelines and standards compliance

STEP_4_TASK_DECOMPOSITION:
- {{agents.task_decomposer}}(mode="analyze") → complexity_score, task_breakdown
- APPLY 1-8 task breakdown based on complexity analysis

STEP_5_SCHEMA_VALIDATION:
- {{agents.task_schema_validator}}(mode="full") → tasks.json validation
- IF validation_fails → RETRY with simplified_schema
- IF retry_fails → {{agents.task_schema_validator}}(mode="light") → minimal_validation
- IF all_validation_fails → RETURN {{errors.shared.ERR_003}} with "Task schema validation failed. Retrying with simplified schema. If this persists, check task complexity."

STEP_6_DIRECTORY_CREATION:
- {{agents.file_creator}}(mode="spec_directory") → spec_dir_path
- ATTEMPT pattern: {task_slug}_{feature|enhancement|fix}_{YYYY-MM-DD}
- IF pattern_fails → FALLBACK to {task_slug}_{timestamp}
- IF fallback_fails → FALLBACK to {task_slug}_next
- IF all_patterns_fail → RETURN {{errors.next_spec_docs.ERR_008}} with "Directory pattern validation failed. Using fallback naming pattern."

ERROR_HANDLING:
- MISSING_ROADMAP {{errors.next_spec_docs.ERR_004}} → "Missing roadmap.md. Run '/sdd-task --init' to generate required project files. Workflow: --init → --next → --execute"
- MISSING_OVERVIEW {{errors.next_spec_docs.ERR_005}} → "Missing overview.md. Run '/sdd-task --init' to generate required project files. Workflow: --init → --next → --execute"
- MISSING_TECH_STACK {{errors.next_spec_docs.ERR_006}} → "Missing tech-stack.md. Run '/sdd-task --init' to generate required project files. Workflow: --init → --next → --execute"
- MISSING_BEST_PRACTICES {{errors.next_spec_docs.ERR_007}} → "Missing best-practices.md. Run '/sdd-task --init' to generate required project files. Workflow: --init → --next → --execute"
- SCHEMA_VALIDATION_FAILED {{errors.shared.ERR_003}} → "Task schema validation failed. Retrying with simplified schema."
- DIRECTORY_PATTERN_FAILED {{errors.next_spec_docs.ERR_008}} → "Directory pattern validation failed. Using fallback naming pattern."

STEP_7_FINAL_VALIDATION:
- VALIDATE content completeness, consistency, technical feasibility