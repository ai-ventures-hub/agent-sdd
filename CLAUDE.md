# Agent-SDD Framework Instructions

Agent-SDD framework for structured software development with 14 specialized sub-agents and automated analytics.

## Framework Requirements

For `/sdd-task` commands:

### Pre-Flight Requirements
1. Read `.claude/commands/sdd-task.md` first
2. Confirm .claude framework active and validate directory structure
3. Validate path variables and file accessibility for all agents
4. Use Task tool only for agent invocations
5. Follow exact workflow in `.claude/commands/workflows/[flag].md`
6. Logging infrastructure automatically captures usage analytics

### Agent Requirements
- Invoke all agents via {{agents.*}} references (centralized in variables.yml)
- No direct file operations without prior agent invocation
- Mandatory context gathering before file modifications
- Mandatory logging before and after operations

### Schema Requirements
- Maintain 14-field task schema for all tasks
- Use task_schema_validator agent for task operations

### Enforcement
Framework bypass returns {{errors.shared.ERR_010}}-{{errors.shared.ERR_014}}

## Command Syntax
`/sdd-task --<flag> [arguments]`

Available flags: --init, --bootstrap, --next, --spec, --execute, --improve, --edit, --evolve, --agent, --validate_system

Reference: `.claude/commands/sdd-task.md`

### Add a new agent
```bash
/sdd-task --agent my_agent --tools Read,Write,Run_terminal_cmd
```

## Variable System

Project-agnostic variable system with auto-discovery:

Categories: paths, agents, commands, constraints, errors, config

Reference: `.claude/config/variables.yml`

## Path Variables (Centralized)
All file paths are now centralized in variables.yml for maintainability:
- `{{paths.base_dir}}` - Root .claude directory
- `{{paths.product_dir}}` - Generated product docs
- `{{paths.specs_dir}}` - Generated specifications
- `{{paths.standards_dir}}` - Generated standards
- `{{paths.analytics_dir}}` - Analytics and metrics
- `{{paths.logs_dir}}` - JSON Lines log files
- `{{paths.commands_log}}` - Command execution logs
- `{{paths.errors_log}}` - Error event logs

Centralized keys used by workflows:
- constraints.task_id_regex → `{{constraints.task_id_regex}}`
- constraints.spec_dir_pattern → `{{constraints.spec_dir_pattern}}`
- errors.shared.* → `{{errors.shared.ERR_003}}`, `{{errors.shared.ERR_010}}`-`{{errors.shared.ERR_014}}`
- errors.next_spec_docs.* → `{{errors.next_spec_docs.ERR_004}}`-`{{errors.next_spec_docs.ERR_007}}`
- errors.bootstrap.* → `{{errors.bootstrap.ERR_015}}`-`{{errors.bootstrap.ERR_020}}`
- errors.improve.* → `{{errors.improve.ERR_021}}`-`{{errors.improve.ERR_024}}`
- errors.evolve.* → `{{errors.evolve.ERR_025}}`-`{{errors.evolve.ERR_028}}`

## Directory Structure
```
.claude/
├── agents/                # Agent specifications
├── analytics/             # Usage analytics & metrics
│   ├── logs/              # JSON Lines log files
│   │   ├── commands.jsonl # Command execution logs
│   │   └── errors.jsonl   # Error event logs
│   ├── history/           # Archived log files
│   ├── reports/           # Generated analytics reports
│   └── metrics.json       # Aggregated usage metrics
├── changelog.md           # Change history
├── commands/              # Command system
│   ├── sdd-task.md        # Main dispatcher
│   └── workflows/         # Workflow specs (9 workflows)
├── config/                # Configuration
│   ├── variables.yml      # Centralized path variables
│   ├── config.json        # Runtime configuration
│   └── mcp-config.yml     # MCP integration settings
├── docs/                  # Documentation
├── product/               # Generated product docs
├── specs/                 # Generated specifications
├── standards/             # Generated standards
└── templates/             # Generation templates
```


## Framework Principles
1. Follow workflows exactly - each flag executes corresponding workflow file
2. Use specified agents - workflows define agent invocation requirements
3. Maintain 14-field task schema compliance
4. Use intelligent task decomposition for complex specifications
5. Automatic analytics logging - all commands tracked in JSON Lines format
6. Centralized path variables - all file paths managed through variables.yml

## Framework Architecture
Structured sub-agent system with workflows in `.claude/commands/workflows/` and agents in `.claude/agents/`. Agent templates and validator are centralized in `.claude/templates/`.

## Analytics & Logging System
Automatic usage tracking and framework evolution capabilities:

### JSON Lines Logging
- **commands.jsonl**: Single-line JSON entries for every command execution
- **errors.jsonl**: Single-line JSON entries for error events
- **Archiving**: Automatic archiving when files exceed 1000 lines (commands) or 500 lines (errors)
- **Lean Format**: Each log entry is exactly one line for optimal performance

### Analytics Processing
- **analytics_collector**: Aggregates JSON Lines data into metrics.json
- **Framework Evolution**: `--evolve` analyzes usage patterns for improvements
- **Performance Tracking**: Execution times, error rates, agent performance metrics
- **Trend Analysis**: Historical data preserved in analytics/history/

### Path Variable System
All file paths are centralized in `variables.yml` for maintainability:
- Change any path in one location
- Consistent path references across all agents
- Project-agnostic configuration

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
- Missing agent gates → {{errors.shared.ERR_011}}/{{errors.shared.ERR_013}}
- Pre-flight missing → {{errors.shared.ERR_014}}
- Steps out of order → {{errors.shared.ERR_012}}
- Invalid task ID format ({{constraints.task_id_regex}}) → {{errors.shared.ERR_003}}
- Invalid spec directory naming ({{constraints.spec_dir_pattern}}) → {{errors.shared.ERR_003}}

### Initial State
Keep product/, specs/, standards/ directories empty initially.
- --init generates: product/overview.md, product/roadmap.md, standards/tech-stack.md, standards/best-practices.md
- --bootstrap generates: standards/theme-standards.md (framework-specific)