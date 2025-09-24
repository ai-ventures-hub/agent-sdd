# sdd-task --init

PURPOSE: Initialize SDD for a new or existing project; analyze state, generate overview, recommend tech stack, plan roadmap, and validate setup.

WORKFLOW_STEPS:

SEQUENCE_GUARDS:
- PRE_FLIGHT:
  - REQUIRE dispatcher pre-flight validations completed
  - IF not → RETURN {{errors.shared.ERR_014}}
- AGENT_GATES:
  - REQUIRE project_analyzer/context_manager invoked before recommendations
  - IF missing → RETURN {{errors.shared.ERR_013}}
- ORDER_ENFORCEMENT:
  - IF steps executed out of order → RETURN {{errors.shared.ERR_012}}

FRAMEWORK_VALIDATION:
- VALIDATE framework integrity: {{agents.agent_registry_validator}}(mode="validate") → registry_status|paths_status|framework_status
- IF any invalid → RETURN {{errors.shared.ERR_014}}
- LOG validation results for framework health monitoring

1. PROJECT_STATE_ANALYSIS:
   - CHECK {{paths.product_dir}}/overview.md existence
   - DETECT project type: empty vs existing
   - FOR EMPTY PROJECTS:
     - {{agents.project_analyzer}}(mode="prompt") → overview_fields
     - IF analysis_fails → FALLBACK to {{templates.project.overview}} defaults
   - FOR EXISTING PROJECTS:
     - {{agents.project_analyzer}}(mode="scan") → tech_stack, patterns
     - IF scan_fails → FALLBACK to manual_detection_mode
   - DETERMINE routing strategy
   - IF routing_fails → DEFAULT to empty_project_flow

2. OVERVIEW_GENERATION:
   - PARSE arguments: project_name (optional)
   - IF missing_arguments → TRIGGER {{agents.project_analyzer}}(mode="interactive_prompt")
   - {{agents.file_creator}}(mode="overview", template="{{templates.project.overview}}")
   - POPULATE: mission, goals, target_users, success_criteria
   - IF generation_fails → RETURN {{errors.init.ERR_040}}
   - VALIDATE completeness → minimum_required_fields

3. TECH_STACK_ANALYSIS:
   - {{agents.project_analyzer}}(mode="tech_recommendations") → framework_suggestions
   - IF analysis_fails → FALLBACK to {{framework.supported_types}} defaults
   - {{agents.file_creator}}(mode="tech_stack", template="{{templates.project.standards}}")
   - IF creation_fails → RETURN {{errors.init.ERR_041}}
   - DOCUMENT: frameworks, styling, testing, build_tools

4. ROADMAP_PLANNING:
   - {{agents.file_creator}}(mode="roadmap", template="{{templates.project.roadmap}}")
   - ANALYZE project_complexity → phase_breakdown
   - IF complexity_analysis_fails → DEFAULT to 3_phase_structure
   - IF creation_fails → RETURN {{errors.init.ERR_042}}
   - VALIDATE: phases, milestones, dependencies

5. USER_REVIEW:
   - PRESENT overview.md content
   - SHOW tech stack recommendations
   - DISPLAY roadmap
   - COLLECT approval for each section
   - ALLOW modifications

6. DIRECTORY_SETUP:
   - ENSURE {{paths.product_dir}} exists
   - ENSURE {{paths.standards_dir}} exists
   - IF directory_creation_fails → RETURN {{errors.bootstrap.ERR_019}}

7. FILE_CREATION_SEQUENCE:
   - CREATE overview.md → IF fails → RETRY with minimal_template
   - CREATE roadmap.md → IF fails → RETRY with basic_roadmap
   - CREATE tech-stack.md → IF fails → RETRY with default_stack
   - CREATE best-practices.md → IF fails → RETRY with generic_practices
   - IF all_retries_fail → RETURN {{errors.init.ERR_043}}

8. FINAL_VALIDATION:
   - {{agents.logger}}(mode="write", summary="init completed")
   - VERIFY minimum_files_created: [overview.md, roadmap.md]
   - IF critical_files_missing → RETURN {{errors.init.ERR_044}}
   - CONFIRM framework_ready_state

AGENT_INVOCATIONS:
- {{agents.project_analyzer}} - analyze existing projects; prompt for overview fields when project lacks source files
- {{agents.file_creator}} - create overview.md, roadmap.md, tech-stack.md, best-practices.md files
- FOR EMPTY PROJECTS: Use project_analyzer responses to populate overview template before continuing

ERROR_HANDLING:
- ANALYSIS_FAILURE: {{errors.init.ERR_035}} → fallback_to_defaults
- MISSING_ARGUMENTS: {{errors.init.ERR_036}} → interactive_prompt_mode
- OVERVIEW_GENERATION_FAILED: {{errors.init.ERR_040}} → minimal_template_fallback
- TECH_STACK_CREATION_FAILED: {{errors.init.ERR_041}} → default_recommendations
- ROADMAP_CREATION_FAILED: {{errors.init.ERR_042}} → basic_3phase_template
- FILE_CREATION_FAILED: {{errors.init.ERR_043}} → retry_with_fallbacks
- CRITICAL_FILES_MISSING: {{errors.init.ERR_044}} → incomplete_init_warning
- DIRECTORY_CREATION_FAILED: {{errors.bootstrap.ERR_019}} → permission_check_required

FALLBACK_STRATEGIES:
- analysis_fails → use_framework_defaults
- file_creation_fails → retry_with_simpler_templates
- missing_arguments → trigger_interactive_prompts
- directory_fails → suggest_manual_creation