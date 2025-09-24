# Agent-SDD Framework Changelog

### 2025-09-24 | Framework Validation Optimization
Framework efficiency improvements: validation now runs once per project during --init instead of every command. Added --validate_system for comprehensive health checks.
- Removed agent_registry_validator from general pre-flight validation in sdd-task.md
- Added validation to --init workflow specifically
- Created new --validate_system command with dedicated workflow
- Updated system counts: workflows=11
- Files: sdd-task.md, init.md, validate_system.md (new), variables.yml, config.json, CLAUDE.md

### 2025-09-23 | /sdd-task --agent style --tools Read,Write,Run_terminal_cmd
Agent creation workflow completed: style agent for theme standards enforcement (AI-to-AI communication)
- Files: .claude/agents/style.md, .claude/commands/workflows/style.md, .claude/config/variables.yml, .claude/config/config.json
- Registry updated with new agent and workflow mappings
- New command: /sdd-task --style [file_path]
- System counts: agents=15, workflows=10 (now 11 with validate_system)
- Purpose: Theme standards enforcement with automated file validation