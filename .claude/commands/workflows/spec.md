# /sdd-task --spec Workflow

WORKFLOW_STEPS:

STEP_1_PROJECT_VALIDATION:
- VERIFY {{paths.product_dir}}/overview.md exists and approved
- VERIFY {{paths.product_dir}}/roadmap.md exists with phases
- VERIFY {{paths.standards_dir}}/tech-stack.md exists
- VERIFY {{paths.standards_dir}}/best-practices.md exists
- VERIFY design artifacts in {{paths.product_dir}}/pages/ present
- CONFIRM user approval status for all recommendations

STEP_2_DOCUMENT_REVIEW:
- REVIEW {{paths.product_dir}}/overview.md (mission, goals, personas)
- REVIEW {{paths.product_dir}}/roadmap.md (phases, milestones, criteria)
- REVIEW {{paths.product_dir}}/pages/*/wireframe.md (UI specs, interactions)
- REVIEW {{paths.product_dir}}/pages/*/user-journey.md (flows, scenarios)
- REVIEW {{paths.standards_dir}}/tech-stack.md (approved technologies)
- REVIEW {{paths.standards_dir}}/best-practices.md (standards, patterns)

STEP_3_TASK_IDENTIFICATION:
- PARSE {{paths.product_dir}}/roadmap.md for phase structure
- IDENTIFY Phase 1 tasks and deliverables
- DETERMINE logical starting point for development
- CONSIDER dependencies and prerequisites

STEP_4_SPECIFICATION_GENERATION:
- EXTRACT functional requirements from overview.md and design artifacts
- DEFINE technical specifications based on approved tech stack
- INCLUDE acceptance criteria from success metrics
- DOCUMENT implementation guidelines and standards compliance

STEP_5_TASK_DECOMPOSITION:
- EVALUATE scope, dependencies, technical requirements
- APPLY 1-8 task breakdown based on complexity analysis

STEP_6_SCHEMA_VALIDATION:
- CREATE tasks.json with full 14-field schema compliance
- ENFORCE task_id regex `^[A-Z]+-[0-9]{3}$`
- REJECT invalid formats with [ERR_003]

STEP_7_DIRECTORY_CREATION:
- CREATE specification directory `{slug}_{type}_{YYYY-MM-DD}`
- ENFORCE exact pattern; REJECT legacy formats
- RETURN [ERR_003] on mismatch

STEP_8_FINAL_VALIDATION:
- VALIDATE content completeness, consistency, technical feasibility

