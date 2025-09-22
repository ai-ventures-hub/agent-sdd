# sdd-task --init

PURPOSE: Initialize SDD for a new or existing project; analyze state, generate overview, recommend tech stack, plan roadmap, and validate setup.

WORKFLOW_STEPS:

1. PROJECT_STATE_ANALYSIS:
   - CHECK {{paths.product_dir}}/overview.md existence
   - DETECT project type: empty vs existing
   - FOR EMPTY PROJECTS: Invoke project-analyzer in prompt mode to gather overview fields before documentation generation
   - FOR EXISTING PROJECTS: SCAN project files (package.json, src/, components/) EXCLUDING .claude/
   - DETECT existing tech stack and frameworks
   - DETERMINE routing strategy

2. OVERVIEW_GENERATION:
   - EXTRACT project name and description from arguments OR gather interactively
   - IF no arguments provided: Prompt for project details or use template defaults
   - GENERATE/UPDATE mission, goals, target users
   - DEFINE success criteria and scope boundaries
   - DOCUMENT assumptions and constraints
   - VALIDATE completeness

3. TECH_STACK_ANALYSIS:
   - ANALYZE project type from overview
   - GENERATE framework recommendations
   - SUGGEST styling solutions
   - RECOMMEND UI libraries
   - PROPOSE backend/database options
   - DOCUMENT testing strategies

4. ROADMAP_PLANNING:
   - ANALYZE project complexity
   - DEFINE development phases
   - ESTABLISH milestones and deliverables
   - CREATE dependency mapping
   - SET realistic timelines

5. USER_REVIEW:
   - PRESENT overview.md content
   - SHOW tech stack recommendations
   - DISPLAY roadmap
   - COLLECT approval for each section
   - ALLOW modifications

6. IMPLEMENTATION:
   - IF approved: Execute recommendations
   - IF modified: Update and re-present
   - IF rejected: Generate alternatives
   - BOOTSTRAP project if needed
   - INSTALL approved technologies

7. FINAL_VALIDATION:
   - VERIFY all files created
   - CHECK technology installations
   - VALIDATE development environment
   - CONFIRM documentation complete

AGENT_INVOCATIONS:
- {{agents.project_analyzer}} - analyze existing projects; prompt for overview fields when project lacks source files
- {{agents.file_creator}} - create overview.md, roadmap.md, tech-stack.md, best-practices.md files
- FOR EMPTY PROJECTS: Use project-analyzer responses to populate overview template before continuing

ERROR_RECOVERY:
- MISSING_OVERVIEW: Use basic template
- NO_ARGUMENTS_PROVIDED: Prompt user for project details or use interactive gathering
- ANALYSIS_FAILURE: Use default recommendations
- INSTALLATION_FAILURE: Document manual steps
- APPROVAL_INTERRUPTED: Save state for resume