# Agent-SDD Universal Framework Directory

This directory contains the Agent-SDD Universal Framework, a multi-platform framework for structured software development that works across Claude, Grok, and GitHub Copilot (Codex).

## Quick Reference

For complete documentation, see the main project README.md in the parent directory.

### Key Features
- **Universal Compatibility**: Single framework works across all major AI coding assistants
- **Platform Auto-Detection**: Automatically adapts to your AI environment
- **16 Specialized Agents**: Comprehensive agent system for development workflows
- **11 Workflow Commands**: Structured development process from planning to deployment
- **Living Architecture**: Automatic Mermaid diagram generation and maintenance

### Getting Started
1. Use framework commands with `{{platform_vars.command_prefix}}sdd-task` syntax (universal alias still works)
2. Start with `{{platform_vars.command_prefix}}sdd-task --init` for project analysis
3. Follow the structured workflow: init → spec → execute → improve

### Platform Support
- **Framework Platforms**: `{{platform_vars.command_prefix}}sdd-task` (platform-adaptive execution)
- **Claude**: `/sdd-task` (automatic loading, sub-agent orchestration)
- **Grok/Codex**: `{{platform_vars.command_prefix}}sdd-task` (platform-specific syntax, sequential execution)

### Directory Structure
- `agents/` - Universal agent specifications
- `commands/` - Command dispatchers and workflows
- `config/` - Platform detection and configuration
- `platforms/` - Platform-specific adapters
- `templates/` - Generation templates
- `docs/` - Documentation and guides

## Development Status
✅ Framework Architecture Complete
✅ Platform Adapters Implemented
✅ Universal Command System Working
🚧 Real Platform Testing In Progress
🚧 Performance Optimization Ongoing

For detailed documentation, testing guides, and troubleshooting, see the main project README.md.
