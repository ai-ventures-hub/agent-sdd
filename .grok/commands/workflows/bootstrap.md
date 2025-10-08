# {{platform_vars.command_prefix}}sdd-task --bootstrap [--shadcn]

PURPOSE: Bootstrap a project with a Next.js + TypeScript + Tailwind setup, optionally with shadcn/ui; validate structure and document theme standards.

WORKFLOW_STEPS:

1. ARGUMENT_ANALYSIS:
   - Check for --shadcn flag
   - Branch to BRANCH_A if --shadcn present, BRANCH_B if not

2. PROJECT_STARTER_ACTIVATION: READ {{agents.project_starter}} for project initialization guidance
- EXECUTE project starter using run_terminal_cmd and search_replace tools → initial_structure
   - Generate initial project structure

3. PROJECT_INITIALIZATION:
   - `npm init -y`

4. NEXTJS_SETUP:
   - `npx create-next-app@latest . --typescript --tailwind --eslint --app --src-dir --import-alias "@/*"`

5. DEPENDENCIES_INSTALL:
   - `npm install next@latest react@latest react-dom@latest`
   - `npm install -D typescript @types/react @types/node`

6. SHADCN_INIT:
   - `npx shadcn-ui@latest init --yes`

7. ESSENTIAL_COMPONENTS:
   - `npx shadcn-ui@latest add button --yes`
   - `npx shadcn-ui@latest add input --yes`
   - `npx shadcn-ui@latest add card --yes`
   - `npx shadcn-ui@latest add dialog --yes`
SEQUENCE_GUARDS:
- PRE_FLIGHT:
  - REQUIRE dispatcher pre-flight validations completed
  - IF not → RETURN {{errors.shared.ERR_014}}
- ORDER_ENFORCEMENT:
  - IF steps executed out of order → RETURN {{errors.shared.ERR_012}}
- FLAG_GUARDS:
  - IF --shadcn absent → SKIP SHADCN steps
  - IF shadcn steps attempted without flag → RETURN {{errors.bootstrap.ERR_016}}

VALIDATION_CHECKS:
- package.json exists
- Next.js directories present
- components/ui/ directory exists
- Tailwind config functional
- TypeScript config valid

BRANCH_A_MCP_SHADCN:
- Verify MCP server connectivity
- UPDATE `{{paths.tech_stack_file}}` to reflect Next.js + shadcn/ui stack
- Execute component installation phases:
  - PHASE 1: "Install essential UI components: button, input, card, dialog"
  - PHASE 2: "Add sidebar that collapses to icons, navigation with breadcrumbs"
  - PHASE 3: "Add data table with sorting, chart components, forms with validation"
  - PHASE 4: "Add complete dashboard block, login page with background"
  - PHASE 5: Generate `{{paths.theme_standards_file}}` from `{{paths.templates_dir}}/theme-standards.md`

BRANCH_B_NO_FLAGS:
- For existing projects: analyze current setup and generate theme-standards.md (write to {{paths.theme_standards_file}})
- READ {{agents.designer}} for theme generation guidance
- EXECUTE theme standards generation using search_replace tool based on existing tech stack
- Use `{{paths.templates_dir}}/theme-standards.md` as base template

COMPONENT_VALIDATION:
- Verify button, input, card, dialog components functional

AGENT_INVOCATIONS:
- {{agents.project_starter}} - reference for bootstrap sequence and MCP component installation guidance
- {{agents.project_analyzer}} - reference for tech-stack analysis and updates when changing technology stacks via --shadcn

ERROR_HANDLING:
- MCP_UNREACHABLE {{errors.bootstrap.ERR_015}}: Retry failed MCP connectivity
- MCP_COMMAND_FAILED {{errors.bootstrap.ERR_016}}: Fallback to manual installation
- NETWORK_TIMEOUT {{errors.bootstrap.ERR_017}}: Retry network operations
- FILE_WRITE_FAILED {{errors.bootstrap.ERR_018}}: Generate installation scripts for failed components
- PERMISSION_DENIED {{errors.bootstrap.ERR_020}}: Document permission requirements
- DIR_CREATION_FAILED {{errors.bootstrap.ERR_019}}: Document completion status with manual steps
