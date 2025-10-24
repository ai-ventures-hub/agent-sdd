# Set Platform Command

COMMAND: set-platform [platform]
PURPOSE: Configure Agent-SDD to use a specific AI assistant platform

USAGE:
- set-platform codex     # Configure for Codex
- set-platform claude    # Configure for Claude Code
- set-platform grok      # Configure for Grok

PLATFORM_CONFIGURATION:

claude:
  - Sets platform_override to "claude"
  - Enables full sub-agent support
  - Configures slash command syntax (/)
  - Optimizes for Claude Code environment

grok:
  - Sets platform_override to "grok"
  - Enables sequential agent execution adapter
  - Configures Grok command syntax (@)
  - Optimizes for web access and streaming fallbacks

codex:
  - Sets platform_override to "codex"
  - Enables sequential agent execution
  - Configures Codex command syntax (#)
  - Optimizes for VS Code workspace integration

auto:
  - Sets platform_override to "auto"
  - Enables automatic platform detection
  - Adapts based on environment and available tools

IMPLEMENTATION:
1. UPDATE {{paths.base_dir}}/config/platform-override.json
2. SET platform_override field to specified platform
3. UPDATE override_timestamp and companion_app_version
4. LOG platform change in analytics
5. PROVIDE confirmation message

COMPANION_APP_INTEGRATION:
- Call: set-platform [preferred_platform]
- Framework immediately switches to specified platform
- All subsequent commands use new platform configuration
- No restart required

PLATFORM_SWITCHING:
- Users can switch platforms anytime
- Configuration persists across sessions
- Automatic validation of platform capabilities
- Graceful fallback if platform unavailable
