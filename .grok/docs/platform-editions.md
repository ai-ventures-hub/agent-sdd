# Universal Framework: Single Framework Directory

Agent-SDD Universal uses one framework directory (`.claude`, `.grok`, or `.codex`) that automatically adapts to Claude, Grok, and Codex through intelligent platform detection.

## Universal Directory Strategy

### Single Framework Directory for All Platforms
One directory serves all platforms through adaptive configuration:

- **`{{paths.base_dir}}`** - Framework directory (automatic platform detection)
- **Framework Platforms** - Adaptive execution based on detected platform
- **Claude Code** - Automatic loading + slash commands (native support)
- **Grok/Codex** - Manual bootstrap required, sequential execution

### Adaptive Internal Structure
The same directory structure works across all platforms:

```
{{paths.base_dir}}/
├── platforms/        # Platform adapters (auto-selected based on detection)
│   ├── claude/       # Claude Code configuration
│   ├── grok/         # Grok configuration
│   └── codex/        # Codex configuration
├── agents/          # Universal agents (adapt to platform capabilities)
├── commands/        # Workflows and dispatchers (platform-aware)
├── config/          # Configuration (platform-specific loading)
├── templates/       # Generation templates (universal)
└── [all other files] # Identical across platforms
```

## Distribution Model

### Simplified GitHub Strategy
Single repository with universal directory:

```
Agent-SDD/
├── main (development)
└── {{paths.base_dir}}         # Framework directory for all platforms
```

### Companion App Integration
Your companion app installs the same framework directory for all users:

1. **Single Download**: Always download framework directory
2. **Automatic Adaptation**: Framework detects platform and adapts automatically  
3. **Bootstrap Guidance**: Guide Grok/Codex users through initial setup

## Platform-Specific Behavior

### Framework Platforms
- Directory: `{{paths.base_dir}}` (universal workspace)
- Commands: `{{platform_vars.command_prefix}}sdd-task --init` (platform-specific syntax)
- Agent Execution: Platform-adaptive (native orchestration or sequential simulation)
- Setup: Automatic detection with optional manual bootstrap for some platforms

## Benefits of Universal Approach

### For Users
- **Consistent Directory**: Framework directory adapts to platform (`.claude`, `.grok`, or `.codex`)
- **Clear Expectations**: Same directory structure everywhere
- **Automatic Adaptation**: Framework handles platform differences
- **Future-Proof**: Easy to add new platforms without directory changes

### For Companion App
- **Platform-Specific Distribution**: Framework directory matches target platform
- **No Platform Detection**: Framework handles platform adaptation
- **Unified Updates**: Same functionality across all platforms
- **Easier Maintenance**: One codebase, multiple platform behaviors

### For Framework Development
- **Unified Codebase**: Single implementation with platform adapters
- **Centralized Logic**: Core functionality in one place
- **Platform Extensions**: Easy to add platform-specific features
- **Testing Efficiency**: Test platform behaviors within single directory
