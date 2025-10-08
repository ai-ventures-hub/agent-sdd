# Agent-SDD Universal Error Codes

ERROR_CODES:
- ERR_001: Invalid flag
- ERR_002: Missing required arguments
- ERR_002A: Invalid optional parameter format
- ERR_003: Invalid task schema
- ERR_004: Required file not found
- ERR_005: Task ID not found
- ERR_006: Git operation failed
- ERR_007: Tests failed
- ERR_008: Directory pattern validation failed
- ERR_009: Cannot acquire file lock
- ERR_010: Direct file modification detected
- ERR_011: Required agent not invoked
- ERR_012: Workflow steps executed out of order
- ERR_013: Context manager not invoked
- ERR_014: Pre-flight validation failed
- ERR_015: MCP server unreachable
- ERR_016: MCP command execution failed
- ERR_017: Network timeout
- ERR_018: File write failure
- ERR_019: Directory creation failed
- ERR_020: Permission denied
- ERR_021: Invalid workflow type
- ERR_022: High-risk change rejected
- ERR_023: Target not found
- ERR_024: Date format error
- ERR_025: Framework evolution initialization failed
- ERR_026: Evolution pattern analysis failed
- ERR_027: Self-improvement application failed
- ERR_028: Framework validation post-evolution failed
- ERR_029: Framework corruption detected, self-healing failed
- ERR_030: Invalid agent name format
- ERR_031: Reserved agent name
- ERR_032: Invalid tools specification
- ERR_033: Agent file already exists
- ERR_034: Agent registry entry exists
- ERR_035: Project analysis failure
- ERR_036: Missing required arguments
- ERR_040: Overview generation failed
- ERR_041: Tech stack creation failed
- ERR_042: Roadmap creation failed
- ERR_043: File creation sequence failed
- ERR_044: Critical files missing after init
- ERR_045: Architecture diagram generation failed
- ERR_046: Architecture file not found
- ERR_047: Mermaid syntax validation failed

FRAMEWORK_CRITICAL: ERR_010-014 (workflows must fail immediately)
INFRASTRUCTURE_ERRORS: ERR_015-017 (require infrastructure fixes)
OPERATION_ERRORS: ERR_018-020 (require permission/access fixes)
VALIDATION_ERRORS: ERR_021-024 (require input corrections)
EVOLUTION_ERRORS: ERR_025-029 (framework self-improvement failures)
AGENT_CREATION_ERRORS: ERR_030-034 (agent scaffolding issues)
INIT_WORKFLOW_ERRORS: ERR_035-036, ERR_040-044 (initialization failures)
ARCHITECTURE_ERRORS: ERR_045-047 (diagram and visualization failures)

## Platform-Specific Recovery Strategies

### Claude-Specific Recovery (Sub-agent orchestration)
**ERR_010**: Use `{{platform_vars.command_prefix}}sdd-task --edit` for changes, `{{platform_vars.command_prefix}}sdd-task --improve` for enhancements
**ERR_011**: Re-run with Task tool agent invocation
**ERR_015**: Check network, restart MCP server
**ERR_018**: Task tool verifies file operations

### Grok-Specific Recovery (Sequential execution)
**ERR_010**: Restore from backup, re-execute workflow
**ERR_011**: Manual agent sequence re-run
**ERR_015**: Web access alternatives, local component setup
**ERR_017**: Streaming response handling, context preservation

### Codex-Specific Recovery (VS Code integration)
**ERR_010**: Git revert changes, follow workflow sequence
**ERR_011**: VS Code workspace re-initialization
**ERR_015**: Extension restart, workspace reload
**ERR_018**: VS Code file permissions, Git conflict resolution

## Error Recovery Workflows

### Bootstrap Recovery
```
Error: Framework not recognized on platform
1. Verify platform override in {{paths.base_dir}}/config/platform-override.json
2. Re-run bootstrap with progressive disclosure
3. Test basic command: sdd-task --help
4. Check platform-specific documentation
```

### Workflow Sequence Recovery
```
Error: ERR_012 - Steps out of order
Current: --init completed, trying --execute
Required: --init → --spec → --execute
Action: Run sdd-task --spec TASK-001 "description"
```

### File System Recovery
```
Error: ERR_018 - File write failure
1. Check permissions: ls -la {file}
2. Verify disk space: df -h
3. Test write: touch {file}.test
4. Platform-specific: Claude=Task tool, Codex=VS Code perms
```

---

*Universal error handling with platform-aware recovery strategies*
