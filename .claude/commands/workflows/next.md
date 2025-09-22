# /sdd-task --next Workflow

WORKFLOW_STEPS:

STEP_1_ROADMAP_ANALYSIS:
- READ {{paths.product_dir}}/roadmap.md
- IDENTIFY current phase and task completion status
- DETERMINE next logical task based on dependencies
- EXTRACT task requirements and specifications

STEP_2_CONTEXT_GATHERING:
- READ {{paths.product_dir}}/overview.md (project goals)
- READ {{paths.standards_dir}}/tech-stack.md (approved technologies)
- READ {{paths.standards_dir}}/best-practices.md (development standards)
- READ existing completed specifications for consistency

STEP_3_SPECIFICATION_GENERATION:
- EXTRACT functional requirements from roadmap task
- DEFINE technical specifications based on approved tech stack
- INCLUDE acceptance criteria from task requirements
- DOCUMENT implementation guidelines and standards compliance

STEP_4_TASK_DECOMPOSITION:
- EVALUATE scope, dependencies, technical requirements
- APPLY 1-8 task breakdown based on complexity analysis

STEP_5_SCHEMA_VALIDATION:
- CREATE tasks.json with full 14-field schema compliance
- ENFORCE task_id regex `^[A-Z]+-[0-9]{3}$`
- REJECT invalid formats with [ERR_003]

STEP_6_DIRECTORY_CREATION:
- CREATE specification directory `{slug}_{type}_{YYYY-MM-DD}`
- ENFORCE exact pattern; REJECT legacy formats
- RETURN [ERR_003] on mismatch

STEP_7_FINAL_VALIDATION:
- VALIDATE content completeness, consistency, technical feasibility