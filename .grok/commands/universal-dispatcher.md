# Universal Command Dispatcher

COMMAND_PROCESSING_PIPELINE:

1. INPUT_PARSING:
   - ACCEPT universal command format: sdd-task --flag [args]
   - DETECT platform through auto-detection
   - LOAD appropriate platform adapter

2. COMMAND_TRANSLATION:
   - MAP universal command to platform-specific syntax
   - APPLY platform command prefix
   - TRANSLATE arguments to platform format

3. WORKFLOW_ROUTING:
   - RESOLVE workflow path using universal variables
   - LOAD workflow specification
   - TRANSLATE workflow steps to platform capabilities

4. AGENT_INVOCATION:

For Claude (Sub-Agent Support):
- RESOLVE agent references to universal specifications
- MAP agent capabilities to platform tools
- USE Task tool to invoke agent files directly
- PASS context and receive results automatically

For Grok/Codex (Sequential Simulation):
- READ agent file content directly
- PARSE agent instructions and logic
- EXECUTE agent logic inline within main workflow
- PASS results as context to next simulated invocation
- MAINTAIN workflow state across sequential steps

5. RESULT_PROCESSING:
   - NORMALIZE platform-specific results
   - APPLY universal error handling
   - RETURN consistent response format

PLATFORM_COMMAND_MAPPING:

Universal → Claude:
  sdd-task --init → /sdd-task --init
  sdd-task --execute TASK-001 → /sdd-task --execute TASK-001
  output-style ai-to-ai-strict → /output-style ai-to-ai-strict

Universal → Grok:
  sdd-task --init → @sdd-task --init
  sdd-task --execute TASK-001 → @sdd-task --execute TASK-001
  output-style ai-to-ai-strict → @set-output-style ai-to-ai-strict

Universal → Codex:
  sdd-task --init → #sdd-task --init
  sdd-task --execute TASK-001 → #sdd-task --execute TASK-001
  output-style ai-to-ai-strict → #output-style ai-to-ai-strict

PATH_RESOLUTION:

Runtime Detection (No Environment Variables):
  - AI detects current working directory via pwd
  - Constructs base_dir: .{platform_name} (e.g., .grok, .claude, .codex)
  - All paths relative to detected working directory
  - No environment variable dependencies
  - Consistent behavior across all platforms

AGENT_COMPATIBILITY_LAYER:

For Legacy Claude Agents:
- AUTOMATICALLY convert YAML frontmatter to universal spec
- MAP legacy tools to universal capabilities
- MAINTAIN backward compatibility

For Universal Agents:
- DIRECT mapping to platform tools
- PLATFORM-specific optimizations
- ENHANCED error handling

ERROR_NORMALIZATION:

Platform Errors → Universal Errors:
- Claude: ERR_001 → Universal: ERR_INVALID_COMMAND
- Grok: CommandFailed → Universal: ERR_EXECUTION_FAILED
- Codex: ToolUnavailable → Universal: ERR_CAPABILITY_MISSING

FALLBACK_MECHANISMS:

1. PLATFORM_UNDETECTED:
   - DEFAULT to Claude compatibility mode
   - DISPLAY platform setup instructions
   - CONTINUE with reduced functionality

2. CAPABILITY_MISSING:
   - ATTEMPT alternative implementation
   - PROVIDE manual workaround instructions
   - LOG for framework improvement

3. COMMAND_FAILURE:
   - RETRY with platform-specific parameters
   - ESCALATE to user with diagnostic information
   - SUGGEST platform-specific solutions

PERFORMANCE_OPTIMIZATIONS:

- COMMAND_CACHING: Cache translated commands per platform
- TOOL_MAPPING_CACHE: Store capability mappings
- LAZY_LOADING: Load platform adapters on first use
- RESULT_MEMOIZATION: Cache successful translations

MONITORING_AND_ANALYTICS:

- TRACK platform usage patterns
- MONITOR translation success rates
- COLLECT platform capability data
- ENABLE A/B testing of optimizations
- PROVIDE usage analytics to improve mappings
