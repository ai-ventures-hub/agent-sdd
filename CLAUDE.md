# Agent-SDD Framework Instructions

Agent-SDD framework for structured software development with sub-agent orchestration.

## Framework Requirements

For `/sdd-task` commands:

### Pre-Flight Requirements
1. Read `.claude/commands/sdd-task.md` first
2. Confirm Agent-SDD framework active
3. Use Task tool only for agent invocations
4. Follow exact workflow in `.claude/commands/workflows/[flag].md`

### Agent Requirements
- Invoke all agents via Task tool with subagent_type parameter
- No direct file operations without prior agent invocation
- Mandatory context gathering before file modifications
- Mandatory logging before and after operations

### Schema Requirements
- Maintain 14-field task schema for all tasks
- Use task-schema-validator agent for task operations

### Enforcement
Framework bypass returns ERR_010-ERR_014

## Command Syntax
`/sdd-task --<flag> [arguments]`

Available flags: --init, --bootstrap, --next, --spec, --execute, --improve, --edit

Reference: `.claude/commands/sdd-task.md`

## Variable System

Project-agnostic variable system with auto-discovery:

Categories: paths, agents, commands, config

Reference: `.claude/config/variables.yml`

## Directory Structure
```
.claude/
├── agents/                # Agent specifications
├── changelog.md           # Change history
├── commands/              # Command system
│   ├── sdd-task.md        # Main dispatcher
│   └── workflows/         # Workflow specs
├── config/                # Configuration
├── docs/                  # Documentation
├── product/               # Generated docs
├── settings.local.json    # Local settings
├── specs/                 # Generated specs
├── standards/             # Generated standards
└── templates/             # Generation templates
```


## Framework Principles
1. Follow workflows exactly - each flag executes corresponding workflow file
2. Use specified agents - workflows define agent invocation requirements
3. Maintain 14-field task schema compliance
4. Use intelligent task decomposition for complex specifications

## Framework Architecture
Structured sub-agent system with workflows in `.claude/commands/workflows/` and agents in `.claude/agents/`.

## Task Schema
Required 14 fields in tasks.json: id, type, title, description, status, priority, created_date, ux_ui_reviewed, theme_changes, completed_date, target_files, dependencies, linked_task, acceptance_criteria


## Enforcement Rules

### Reference Order
For `/sdd-task` commands:
1. `.claude/commands/sdd-task.md` - command specifications
2. `.claude/commands/workflows/[flag].md` - workflow details
3. `.claude/agents/[agent].md` - agent specifications (as needed)

### Global Rules
- Unmapped flag → ERR_001
- Missing agent gates → ERR_011/ERR_013
- Pre-flight missing → ERR_014
- Steps out of order → ERR_012
- Invalid task ID format → ERR_003
- Invalid spec directory naming → ERR_003

### Initial State
Keep product/, specs/, standards/ directories empty initially.
- --init generates: product/overview.md, product/roadmap.md, standards/tech-stack.md, standards/best-practices.md
- --bootstrap generates: standards/theme-standards.md (framework-specific)