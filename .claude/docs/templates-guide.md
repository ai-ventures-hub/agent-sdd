TEMPLATE_FILES:
- best-practices.md: Development workflow standards
- overview.md: Product mission, users, goals template
- roadmap.md: Development phases and milestones template
- spec-template.md: Software Design Document template
- tech-stack.md: Technology decisions template
- theme-standards.md: Design system standards template

MCP_COMPONENT_INSTALLATION:
- PRIMARY: Natural language commands via MCP
- FALLBACK: Direct shadcn/ui commands
- EXAMPLES: "Install button component", "Add login form"

TEMPLATE_USAGE:
- FILE_CREATOR: Uses all documentation templates
- BOILERPLATE_CREATOR: MCP-first component installation
- PROJECT_ANALYZER: References tech-stack.md, best-practices.md

TEMPLATE_REQUIREMENTS:
- PLACEHOLDERS: Use {{variable}} syntax
- VALIDATION: Markdown syntax, placeholder coverage
- PERFORMANCE: Under 5KB each, fast processing