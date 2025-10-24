# Agent-SDD Universal Templates Guide

## Overview
Agent-SDD Universal uses a comprehensive template system for generating consistent, high-quality documentation and code across all supported platforms (Claude, Grok, Codex).

## Template Categories

### Documentation Templates
**Project Analysis & Planning:**
- `overview.md`: Product mission, users, goals template
- `roadmap.md`: Development phases and milestones template
- `tech-stack.md`: Technology decisions template
- `best-practices.md`: Development workflow standards

**Design & Architecture:**
- `theme-standards.md`: Design system standards template
- `architecture.md`: System architecture diagrams template

**Development Artifacts:**
- `spec-template.md`: Software Design Document template
- `wireframe-templates.md`: UI/UX wireframe templates

### Agent Templates
**Agent Creation:**
- `agent-template.md`: Standardized agent specification template
- `agent-registry-validator.md`: Agent validation templates

**Workflow Templates:**
- `workflow-template.md`: Command workflow templates

## Template Architecture

### MCP Integration
**Component Installation:**
- PRIMARY: Natural language commands via MCP
- FALLBACK: Direct shadcn/ui commands
- EXAMPLES: "Install button component", "Add login form"

**Template vs Components:**
- Templates: Documentation and specification generation
- Components: UI/UX elements via MCP integration
- Hybrid: Templates reference component installation patterns

### Template Usage by Agents

**File Creator Agent:**
- Uses all documentation templates
- Generates spec.md from spec-template.md
- Creates project documentation from overview.md, roadmap.md, etc.

**Project Analyzer Agent:**
- References tech-stack.md for technology analysis
- Uses best-practices.md for workflow standards
- Applies architecture.md for system documentation

**Architecture Visualizer Agent:**
- Uses architecture.md template for Mermaid diagrams
- Generates living architecture documentation

**Project Starter Agent:**
- MCP-first component installation
- Uses theme-standards.md for design system setup

## Template Requirements

### Technical Standards
**File Size:** Under 5KB each for fast processing
**Format:** Valid Markdown with proper syntax
**Encoding:** UTF-8 with Unix line endings

### Placeholder System
**Syntax:** Use `{{variable}}` syntax for dynamic content
**Validation:** All placeholders must be resolvable
**Coverage:** 100% placeholder resolution required

**Common Placeholders:**
- `{{project_name}}`: Project title
- `{{date}}`: Current date (YYYY-MM-DD)
- `{{author}}`: Content creator
- `{{platform}}`: Current platform (claude|grok|codex)

### Content Standards
**Completeness:** Self-contained, no external dependencies
**Consistency:** Follow framework naming conventions
**Accessibility:** Clear, actionable content
**Platform Agnostic:** Work across all supported platforms

## Template Maintenance

### Version Control
**Location:** `{{paths.templates_dir}}` directory
**Updates:** Modify via `--evolve` command
**Validation:** Automatic syntax checking
**Backup:** Version history maintained

### Quality Assurance
**Automated Checks:**
- Markdown syntax validation
- Placeholder resolution testing
- File size verification
- Cross-platform compatibility

**Manual Review:**
- Content accuracy and completeness
- Platform-specific adaptations
- User experience validation

## Platform-Specific Considerations

### Claude Code
**Advantages:** Sub-agent orchestration enables parallel template processing
**Optimization:** Templates processed via Task tool for reliability
**Integration:** Automatic template selection based on workflow

### Grok
**Advantages:** Web access enables enhanced template content
**Optimization:** Streaming responses for large template generation
**Integration:** Context-aware template selection

### Codex
**Advantages:** VS Code integration enables workspace-aware templates
**Optimization:** Git-aware template content
**Integration:** Extension-based template enhancements

## Template Evolution

### Framework Improvements
**Analytics Integration:** Usage patterns inform template improvements
**Performance Monitoring:** Template generation speed and success rates
**User Feedback:** Template effectiveness and usability metrics

### Update Process
```bash
# Analyze template usage
sdd-task --evolve

# Update specific template
sdd-task --improve enhancement "Update spec-template.md with new fields"

# Validate template changes
sdd-task --validate_system
```

## Template Registry

### Current Template Inventory
```
Documentation Templates: 6 files
├── overview.md
├── roadmap.md
├── tech-stack.md
├── best-practices.md
├── theme-standards.md
└── architecture.md

Development Templates: 5 files
├── spec-template.md
├── wireframe-templates.md
├── agent-template.md
├── agent-registry-validator.md
└── workflow-template.md

Total: 11 template files
```

### Template Dependencies
**Initialization:** overview.md, roadmap.md, tech-stack.md, best-practices.md
**Specification:** spec-template.md
**Architecture:** architecture.md
**Design:** theme-standards.md, wireframe-templates.md
**Agents:** agent-template.md, agent-registry-validator.md

## Troubleshooting

### Common Issues
**Template Not Found:** Check {{paths.templates_dir}} directory structure
**Placeholder Errors:** Verify variable resolution in context
**Syntax Errors:** Validate Markdown syntax
**Performance Issues:** Check file size limits

### Recovery Procedures
**Template Corruption:** Restore from framework backup
**Missing Templates:** Reinitialize with `--init` command
**Variable Resolution:** Check platform variable mappings
**Performance Degradation:** Optimize template content

---

*Templates provide the foundation for consistent, automated content generation across all Agent-SDD Universal workflows.*
