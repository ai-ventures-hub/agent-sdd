# Platform Detection & Adaptation System

PLATFORM_DETECTION_WITH_OVERRIDE (Framework workspace):

1. PLATFORM_OVERRIDE_CHECK:
   - CHECK {{paths.base_dir}}/config/platform-override.json
   - IF platform_override = "{{FRAMEWORK_FROM_SDDRC}}" → READ .sddrc FRAMEWORK value
   - IF override = "auto" → PROCEED to auto-detection
   - ELSE → USE explicit override value (for testing/development)

2. FRAMEWORK_DIRECTORY_CHECK (Primary Detection):
   - CHECK for .sddrc file in current directory
   - READ FRAMEWORK value from .sddrc
   - VALIDATE corresponding directory exists (.claude/, .grok/, or .codex/)
   - PLATFORM = FRAMEWORK value from .sddrc

3. RUNTIME_PATH_DETECTION:
   - USE current working directory (pwd) as project root
   - CONSTRUCT base_dir from platform name: .{platform_name}/
   - NO environment variable dependencies
   - Works consistently across all platforms

4. COMMAND_PREFIX_MAPPING:
   - READ platform_vars.command_prefix from variables.yml
   - APPLY correct prefix for detected platform:
     * Claude: /sdd-task
     * Grok: @sdd-task
     * Codex: #sdd-task

5. ADAPTER_LOADING (Framework directory):
   - Directory name is {{platform_vars.name}}
   - LOAD platform-specific configuration from {{paths.base_dir}}/platforms/{platform}/
   - INITIALIZE tool mappings for selected platform
   - SET command prefixes based on platform_vars
   - USE runtime path detection (no env var resolution needed)

PLATFORM_CAPABILITIES:
- CLAUDE: Full feature support, sub-agent orchestration, advanced tooling
- GROK: Standard tooling, adapted command syntax, sequential adapter optimizations
- CODEX: VS Code integration, GitHub Copilot features, workspace awareness

FALLBACK_STRATEGIES:
- IF platform undetected → DEFAULT to {{platform_vars.name}} (framework edition baseline)
- IF tools unavailable → GRACEFUL_DEGRADATION with reduced functionality
- IF commands fail → PROVIDE platform-specific setup instructions

ADAPTATION_RULES:
1. MAINTAIN backward compatibility with existing Claude workflows
2. TRANSPARENT platform switching (no user configuration required)
3. GRACEFUL feature degradation for limited platforms
4. PRESERVE all existing Agent-SDD functionality across platforms

CONFIGURATION_VALIDATION_POST_SWITCH:
- VALIDATE platform_vars.name matches .sddrc FRAMEWORK setting
- VERIFY command_prefix is correct for platform (/, @, or #)
- CONFIRM framework directory exists (.claude/, .grok/, or .codex/)
- TEST path construction works (base_dir resolution)
- TEST file operations with platform tools
- LOG configuration validation results
- SUGGEST manual fixes if validation fails

PLATFORM_SWITCH_VALIDATION_SEQUENCE:
1. READ .sddrc FRAMEWORK setting
2. VALIDATE top-level platform_vars against framework
3. TEST platform-specific tool availability
4. VERIFY framework directory structure
5. CHECK instruction file existence (CLAUDE.md/GROK.md/CODEX.md)
6. LOG validation results to analytics
