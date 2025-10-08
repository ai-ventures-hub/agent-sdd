# {{platform_vars.command_prefix}}sdd-task --init [project-name] [--mission "mission statement"] [--goals "goal1,goal2,goal3"]

PURPOSE: Initialize SDD for a new or existing project; analyze state, generate overview, recommend tech stack, plan roadmap, and validate setup.

PARAMETERS (Optional for existing projects, MANDATORY prompts for empty projects):
- project-name: Project name or title
- --mission: Mission statement or elevator pitch
- --goals: Comma-separated primary goals
- --users: Target users or personas
- --metrics: Success metrics or KPIs

IMPORTANT: For empty projects without parameters, interactive prompts are MANDATORY.

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

FILE_LOCKING_PROTOCOL:
- CHECK for existing locks: {{paths.base_dir}}/.init.lock
- ACQUIRE lock with process ID and timestamp before interactive prompting
- WAIT up to 30 seconds for acquisition (interactive operations)
- VALIDATE lock file contents and ownership
- RELEASE lock after all file creation completes
- FAIL with {{errors.shared.ERR_009}} if lock cannot be acquired
- CLEANUP: Remove stale locks (>5 minutes old)

FRAMEWORK_VALIDATION:
- IF first_run → EXECUTE full validation
- ELSE → SKIP (validated during --init)
- CHECKPOINT: Verify critical paths only ({{paths.base_dir}}, variables.yml)
- LOG health status

1. PROJECT_STATE_ANALYSIS:
   - CRITICAL: Framework directories (.grok/, .claude/, .codex/) are NOT the project
   - CHECK for source code OUTSIDE framework directory:
     * Exclude: {{paths.base_dir}}, node_modules/, .git/
     * Look for: *.js, *.ts, *.py, *.go, package.json, etc.
   - DETECT project type:
     * EMPTY: Only framework files exist → REQUIRE user input
     * EXISTING: Source code found → Analyze and enhance
   - FOR EMPTY PROJECTS:
     - DO NOT analyze framework directory
     - DO NOT modify templates in {{paths.templates_dir}}
     - INVOKE {{agents.project_analyzer}} → triggers prompts
     - WAIT for user input before ANY file creation
   - FOR EXISTING PROJECTS:
     - INVOKE {{agents.project_analyzer}}
     - SCAN tech_stack OUTSIDE framework directory
     - ENHANCE based on actual project code

2. OVERVIEW_GENERATION:
   - PARSE arguments: project_name (optional)
   - IF EMPTY PROJECT AND no arguments:
     - ACQUIRE_INIT_LOCK: Create {{paths.base_dir}}/.init.lock with process info
     - IF lock_acquisition_fails → RETURN {{errors.shared.ERR_009}}
     - MANDATORY: Interactive prompting for ALL fields:
       * project_name: "What is the project name?"
       * mission: "What is the mission/purpose of this project?"
       * target_users: "Who are the target users?"
       * primary_goals: "What are the top 3 goals?"
       * success_criteria: "How will success be measured?"
     - NEVER assume or auto-generate without user input
     - IF user skips prompt → RELEASE_INIT_LOCK → RETURN {{errors.init.ERR_036}}
   - ONLY after collecting ALL required fields:
     - INVOKE {{agents.file_creator}}
     - CREATE {{paths.product_dir}}/overview.md
     - POPULATE with user-provided content
     - RELEASE_INIT_LOCK: Remove {{paths.base_dir}}/.init.lock
   - VALIDATE completeness → ALL fields must have user input

3. TECH_STACK_ANALYSIS:
   - READ {{agents.project_analyzer}} for tech recommendations guidance
   - EXECUTE tech analysis using read_file and grep tools → framework_suggestions
   - IF analysis_fails → FALLBACK to {{framework.supported_types}} defaults
   - READ {{agents.file_creator}} for file creation guidance
   - EXECUTE file creation using search_replace tool with template="{{templates.project.tech_stack}}"
   - IF creation_fails → RETURN {{errors.init.ERR_041}}
   - DOCUMENT: frameworks, styling, testing, build_tools

4. ROADMAP_PLANNING:
   - READ {{agents.file_creator}} for roadmap creation guidance
   - EXECUTE file creation using search_replace tool with template="{{templates.project.roadmap}}"
   - ANALYZE project_complexity → phase_breakdown
   - IF complexity_analysis_fails → DEFAULT to 3_phase_structure
   - IF creation_fails → RETURN {{errors.init.ERR_042}}
   - VALIDATE: phases, milestones, dependencies

4.5. ARCHITECTURE_INITIALIZATION:
   - READ {{agents.architecture_visualizer}} for architecture guidance
   - EXECUTE architecture visualization using read_file and search_replace tools → initial_architecture
   - GENERATE Mermaid diagrams based on tech stack analysis
   - CREATE living architecture documentation
   - IF generation_fails → FALLBACK to basic_template
   - INTEGRATE component relationships from tech_stack analysis

5. USER_REVIEW:
   - PRESENT overview.md content
   - SHOW tech stack recommendations
   - DISPLAY roadmap
   - COLLECT approval for each section
   - ALLOW modifications

6. DIRECTORY_SETUP:
   - ENSURE {{paths.product_dir}} exists
   - IF directory_creation_fails → RETURN {{errors.bootstrap.ERR_019}}

7. FILE_CREATION_SEQUENCE:
   - CREATE overview.md (template={{templates.project.overview}}) → IF fails → RETRY with minimal_template
   - CREATE roadmap.md (template={{templates.project.roadmap}}) → IF fails → RETRY with basic_roadmap
   - CREATE tech-stack.md (template={{templates.project.tech_stack}}) → IF fails → RETRY with default_stack
   - CREATE best-practices.md (template={{templates.project.best_practices}}) → IF fails → RETRY with generic_practices
   - CREATE architecture.md (template={{templates.project.architecture}}) → IF fails → RETRY with basic_architecture
   - IF all_retries_fail → RETURN {{errors.init.ERR_043}}

8. FINAL_VALIDATION:
   - READ {{agents.logger}} for logging guidance
   - EXECUTE logging using search_replace tool with summary="init completed"
   - VERIFY minimum_files_created: [overview.md, roadmap.md]
   - IF critical_files_missing → RETURN {{errors.init.ERR_044}}
   - CONFIRM framework_ready_state

AGENT_SPEC_REFERENCES:
- {{agents.project_analyzer}} - reference for project analysis guidance and tool execution patterns
- {{agents.file_creator}} - reference for file creation guidance and search_replace tool usage
- {{agents.architecture_visualizer}} - reference for architecture visualization guidance and diagram generation
- FOR EMPTY PROJECTS: Use project_analyzer guidance to populate overview template before continuing

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
