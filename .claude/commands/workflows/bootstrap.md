# sdd-task --bootstrap [--shadcn]

PURPOSE: Bootstrap a project with a Next.js + TypeScript + Tailwind setup, optionally with shadcn/ui; validate structure and document theme standards.

WORKFLOW_STEPS:

1. ARGUMENT_ANALYSIS:
   - Check for --shadcn flag
   - Branch to BRANCH_A if --shadcn present, BRANCH_B if not

PROJECT_STARTER_ACTIVATION:
   - Execute `{{agents.project_starter}}`
   - Generate initial project structure

2. PROJECT_INITIALIZATION:
   - `npm init -y`

3. NEXTJS_SETUP:
   - `npx create-next-app@latest . --typescript --tailwind --eslint --app --src-dir --import-alias "@/*"`

4. DEPENDENCIES_INSTALL:
   - `npm install next@latest react@latest react-dom@latest`
   - `npm install -D typescript @types/react @types/node`

5. SHADCN_INIT:
   - `npx shadcn-ui@latest init --yes`

6. ESSENTIAL_COMPONENTS:
   - `npx shadcn-ui@latest add button --yes`
   - `npx shadcn-ui@latest add input --yes`
   - `npx shadcn-ui@latest add card --yes`
   - `npx shadcn-ui@latest add dialog --yes`

VALIDATION_CHECKS:
- package.json exists
- Next.js directories present
- components/ui/ directory exists
- Tailwind config functional
- TypeScript config valid

BRANCH_A_MCP_SHADCN:
- Verify MCP server connectivity
- UPDATE `{{paths.standards_dir}}/tech-stack.md` to reflect Next.js + shadcn/ui stack
- Execute component installation phases:
  - PHASE 1: "Install essential UI components: button, input, card, dialog"
  - PHASE 2: "Add sidebar that collapses to icons, navigation with breadcrumbs"
  - PHASE 3: "Add data table with sorting, chart components, forms with validation"
  - PHASE 4: "Add complete dashboard block, login page with background"
  - PHASE 5: Generate `{{paths.standards_dir}}/theme-standards.md` from `{{paths.templates_dir}}/theme-standards.md`

BRANCH_B_NO_FLAGS:
- For existing projects: analyze current setup and generate theme-standards.md
- Use `{{agents.designer}}` to generate theme-standards.md based on existing tech stack
- Use `{{paths.templates_dir}}/theme-standards.md` as base template

COMPONENT_VALIDATION:
- Verify button, input, card, dialog components functional

AGENT_INVOCATIONS:
- {{agents.project_starter}} - execute bootstrap sequence and MCP component installation
- {{agents.project_analyzer}} - update tech-stack.md when changing technology stacks via --shadcn

ERROR_HANDLING:
- MCP_UNREACHABLE [ERR_015]: Retry failed MCP connectivity
- MCP_COMMAND_FAILED [ERR_016]: Fallback to manual installation
- NETWORK_TIMEOUT [ERR_017]: Retry network operations
- FILE_WRITE_FAILED [ERR_018]: Generate installation scripts for failed components
- PERMISSION_DENIED [ERR_020]: Document permission requirements
- DIR_CREATION_FAILED [ERR_019]: Document completion status with manual steps