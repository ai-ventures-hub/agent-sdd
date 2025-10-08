# Platform Detection & Adaptation System

PLATFORM_DETECTION_WITH_OVERRIDE (Framework workspace):

1. PLATFORM_OVERRIDE_CHECK:
   - CHECK {{paths.base_dir}}/config/platform-override.json
   - IF platform_override = "{{FRAMEWORK_FROM_SDDRC}}" → READ .sddrc FRAMEWORK value
   - IF override = "auto" → PROCEED to auto-detection
   - ELSE → USE explicit override value (for testing/development)

2. ENVIRONMENT_VARIABLE_CHECK (Auto-Detection):
   - IF {{CLAUDE_DIR}} exists → PLATFORM = claude
   - ELIF {{GROK_WORKSPACE}} exists → PLATFORM = grok
   - ELIF {{COPILOT_WORKSPACE}} exists → PLATFORM = codex
   - ELSE → FALLBACK_DETECTION

3. COMMAND_AVAILABILITY_CHECK (Fallback):
   - TEST #sdd-task command → CONFIRMS codex
   - TEST /sdd-task command → CONFIRMS claude
   - TEST @sdd-task command → CONFIRMS grok

4. CAPABILITY_ASSESSMENT:
   - DETECT available tools for selected platform
   - ASSESS command execution capabilities
   - IDENTIFY platform limitations

5. ADAPTER_LOADING (Framework directory):
   - Directory name is {{platform_vars.name}} (framework-specific, adapters maintain compatibility)
   - LOAD platform-specific configuration from {{paths.base_dir}}/platforms/{platform}/
   - INITIALIZE tool mappings for selected platform
   - SET command prefixes and execution model
   - CONFIGURE environment variable mappings

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
- VALIDATE platform_vars top-level variables match FRAMEWORK setting
- CHECK platform-specific variables resolve correctly
- VERIFY command_prefix matches detected platform
- CONFIRM workspace_root, project_root, current_dir are platform-appropriate
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
