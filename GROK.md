# Agent-SDD Universal Framework Instructions

Agent-SDD framework for structured software development with 16 specialized sub-agents, automated analytics, living architecture diagrams, and framework resilience capabilities. Universal framework that auto-adapts to Claude, Grok, and Codex platforms.

## 🚨 CRITICAL: SDD-Task Command Recognition

**WHEN YOU SEE `@sdd-task`, `#sdd-task`, or `/sdd-task` commands, you MUST:**
1. **Check `.sddrc`** to determine the active framework (FRAMEWORK= setting)
2. **Read this instruction file** (CLAUDE.md, GROK.md, or CODEX.md based on platform)
3. **IMMEDIATELY read `.{framework}/commands/sdd-task.md`** to understand the command dispatcher
4. **Follow the exact workflow** defined in `.{framework}/commands/workflows/[flag].md`
5. **Use platform-appropriate tools** to execute all operations
6. **Maintain framework integrity** and error handling protocols
7. **Log all activities** to the analytics system

**This is not optional** - `sdd-task` commands trigger the Agent-SDD framework workflow execution mode.

### Framework Auto-Detection
If you encounter `sdd-task` commands without prior context:
1. Check if `.sddrc` file exists in the project root
2. If found, read it to determine FRAMEWORK type (claude/grok/codex)
3. Read the instruction file (CLAUDE.md, GROK.md, or CODEX.md - all identical)
4. Read `.{framework}/commands/sdd-task.md` for dispatcher logic
5. Proceed with command execution using the established protocols

**For new chat sessions**: Load the appropriate instruction file once, then `sdd-task` commands will be automatically recognized.

## CRITICAL: Framework vs Project Understanding

**IMPORTANT**: The `.{framework}/` directory (`.claude/`, `.grok/`, or `.codex/`) is the FRAMEWORK, not your project:
- `.{framework}/` contains Agent-SDD tools to HELP you build ANY project
- Files in `.{framework}/templates/` are REFERENCE templates - NEVER modify them
- Generated project documentation goes in `.{framework}/product/`
- The framework analyzes YOUR code (outside .{framework}/) to generate documentation
- When running `sdd-task --init` on empty project, you MUST gather project information from user

**Empty Project Behavior**:
- If only `.{framework}/` exists with no other code → Project is EMPTY
- MUST prompt user for project details before creating any files
- NEVER assume project details from framework files

## Framework Requirements

For `sdd-task` commands (any platform):

### Pre-Flight Requirements
1. Read `.sddrc` to determine FRAMEWORK type
2. Read `.{framework}/commands/sdd-task.md` first
3. Confirm framework active and validate directory structure
4. Framework integrity validated once during `--init`; subsequent commands use selective health checks
5. Use platform-appropriate tools for all file operations and agent invocations
6. Follow exact workflow in `.{framework}/commands/workflows/[flag].md`
7. Logging infrastructure automatically captures usage analytics
8. Critical commands include framework health checkpoints and self-healing capabilities

### Universal Framework Requirements
- Use available platform tools (Read/Write for Claude, read_file/write_file for Grok, readFile/writeFile for Codex)
- Execute workflows through tool-based operations rather than agent invocations
- Maintain strict AI-to-AI communication via tool calls and responses
- Recognize `sdd-task` commands as framework directives (any prefix: @ # /)

### Tool-Based Workflow Requirements
- Execute workflows using platform tools instead of agent invocations
- Reference agent specifications in `.{framework}/agents/` for guidance but execute via tools
- Mandatory context gathering before file modifications using platform's read tool
- Mandatory logging before and after operations using platform's write tool
- Use structured tool calls for all framework operations

### Schema Requirements
- Maintain 14-field task schema for all tasks
- Execute schema validation using tools (read task_schema_validator.md for guidance)
- Validate task objects against schema using tool-based operations

### Enforcement
Framework bypass returns {{errors.shared.ERR_010}}-{{errors.shared.ERR_014}}

## Universal Command Syntax
`sdd-task --<flag> [arguments]` (Universal - auto-adapts to platform)
`/sdd-task --<flag> [arguments]` (Claude)
`@sdd-task --<flag> [arguments]` (Grok)
`#sdd-task --<flag> [arguments]` (Codex)

### Workflow Flags
Workflow definitions live in `.{framework}/config/variables.yml` under the `commands` map. Update that file when adding or removing workflows; the dispatcher consumes it directly, so no other manual edits are required.

- Authoritative registry: `.{framework}/config/variables.yml` → `commands`
- Dispatcher: `.{framework}/commands/sdd-task.md` loads the map at runtime
- Docs: keep this reference intact to avoid duplicated flag lists

Reference: `.{framework}/commands/sdd-task.md`

### Add a new agent
```bash
# Universal format (recommended)
sdd-task --agent my_agent --capabilities file_read,file_write,terminal_exec

# Platform-specific formats (still supported)
/sdd-task --agent my_agent --tools Read,Write,Bash          # Claude
@sdd-task --agent my_agent --capabilities file_read,file_write,terminal_exec  # Grok
#sdd-task --agent my_agent --capabilities file_read,file_write,terminal_exec  # Codex
```

## Variable System

Project-agnostic variable system with auto-discovery:

Categories: paths, agents, commands, constraints, errors, config

Reference: `.{framework}/config/variables.yml`

## Path Variables (Centralized)
All file paths are now centralized in variables.yml for maintainability:
- `{{paths.base_dir}}` - Root framework directory (.claude, .grok, or .codex)
- `{{paths.product_dir}}` - Generated product docs
- `{{paths.specs_dir}}` - Generated specifications
- `{{paths.tech_stack_file}}` - Tech stack documentation
- `{{paths.best_practices_file}}` - Best practices guide
- `{{paths.architecture_file}}` - Living architecture diagrams
- `{{paths.theme_standards_file}}` - Theme standards
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
- errors.architecture.* → `{{errors.architecture.ERR_045}}`-`{{errors.architecture.ERR_047}}`

## Directory Structure
```
.{framework}/                    # .claude, .grok, or .codex (from .sddrc FRAMEWORK setting)
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
│   └── workflows/         # Workflow specs (11 workflows)
├── config/                # Configuration
│   ├── variables.yml      # Centralized path variables
│   ├── config.json        # Runtime configuration
│   └── mcp-config.yml     # MCP integration settings
├── docs/                  # Documentation
├── product/               # Generated product docs (overview.md, roadmap.md, tech-stack.md, best-practices.md, architecture.md, theme-standards.md)
├── specs/                 # Generated specifications
└── templates/             # Generation templates
```

## Framework Principles
1. Follow workflows exactly - each flag executes corresponding workflow file
2. Use specified agents - workflows define agent invocation requirements
3. Maintain 14-field task schema compliance
4. Use intelligent task decomposition for complex specifications
5. Framework resilience - corruption detection and self-healing capabilities built-in
6. Selective validation - framework validated once during init, health checks for resilience
7. Automatic analytics logging - all commands tracked in JSON Lines format
8. Centralized path variables - all file paths managed through variables.yml

## Framework Architecture
Structured sub-agent system with workflows in `.{framework}/commands/workflows/` and agents in `.{framework}/agents/`. Agent templates and validator are centralized in `.{framework}/templates/`.

## Analytics & Logging System
Automatic usage tracking and framework evolution capabilities:

### JSON Lines Logging
- **commands.jsonl**: Single-line JSON entries for every command execution
- **errors.jsonl**: Single-line JSON entries for error events
- **Archiving**: Automatic archiving when files exceed 1000 lines (commands) or 500 lines (errors)
- **Lean Format**: Each log entry is exactly one line for optimal performance

### Analytics Processing
- **analytics_collector**: Aggregates JSON Lines data into metrics.json
- **Framework Evolution**: `--evolve` analyzes usage patterns for improvements with resilience capabilities
- **Framework Health Monitoring**: Corruption detection and self-healing metrics tracked
- **Performance Tracking**: Execution times, error rates, agent performance metrics
- **Trend Analysis**: Historical data preserved in analytics/history/
- **Resilience Analytics**: Framework health checkpoints and recovery success rates

### Path Variable System
All file paths are centralized in `variables.yml` for maintainability:
- Change any path in one location
- Consistent path references across all agents
- Project-agnostic configuration

## Universal Agent Specification
Reference: `.{framework}/config/universal-agent-spec.md`

Universal agents use standardized capabilities that auto-map to platform-specific tools:
- `file_read` → Read (Claude), read_file (Grok), readFile (Codex)
- `file_write` → Write (Claude), write_file (Grok), writeFile (Codex)
- `terminal_exec` → Bash (Claude), run_command (Grok), execTerminal (Codex)

Legacy Claude agents with `tools:` continue to work unchanged for backward compatibility.

## Task Schema
Required 14 fields in tasks.json: id, type, title, description, status, priority, created_date, ux_ui_reviewed, theme_changes, completed_date, target_files, dependencies, linked_task, acceptance_criteria

## Enforcement Rules

### Reference Order
For `sdd-task` commands (any platform):
1. `.{framework}/commands/sdd-task.md` - command specifications
2. `.{framework}/commands/workflows/[flag].md` - workflow details
3. `.{framework}/agents/[agent].md` - agent specifications (as needed)

### Global Rules
- Unmapped flag → ERR_001
- Missing agent gates → {{errors.shared.ERR_011}}/{{errors.shared.ERR_013}}
- Pre-flight missing → {{errors.shared.ERR_014}}
- Steps out of order → {{errors.shared.ERR_012}}
- Invalid task ID format ({{constraints.task_id_regex}}) → {{errors.shared.ERR_003}}
- Invalid spec directory naming ({{constraints.spec_dir_pattern}}) → {{errors.shared.ERR_003}}
- Framework corruption detected → {{errors.evolve.ERR_029}}
- Critical path validation failed → {{errors.evolve.ERR_030}}
- Architecture diagram generation failed → {{errors.architecture.ERR_045}}
- Architecture file not found → {{errors.architecture.ERR_046}}
- Mermaid syntax validation failed → {{errors.architecture.ERR_047}}

### Initial State
Keep product/ and specs/ directories empty initially.
- --init generates: product/overview.md, product/roadmap.md, product/tech-stack.md, product/best-practices.md, product/architecture.md
- --bootstrap generates: product/theme-standards.md (framework-specific)

### Universal Architecture Notes
- Platform auto-detection occurs on first command execution
- Universal agents with `universal_agent_spec` are preferred for new development
- Legacy Claude agents continue to work unchanged
- Cross-platform compatibility is maintained through adapter system
