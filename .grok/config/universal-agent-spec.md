# Universal Agent Specification v1.0

UNIVERSAL_AGENT_FORMAT:
---
universal_agent_spec: "1.0"
name: [agent_name]
description: [agent_purpose]
capabilities: [universal_capability_list]

# Optional: Platform-specific overrides
platform_overrides:
  codex: {custom_config}
  claude: {custom_config}
  grok: {custom_config}
---

UNIVERSAL_CAPABILITIES:
- file_read: Read file contents
- file_write: Write/modify files
- terminal_exec: Execute terminal commands
- search_glob: Glob pattern file searching
- search_grep: Text searching with regex
- web_request: HTTP requests (if available)
- task_invoke: Invoke other agents/tasks

PLATFORM_TOOL_MAPPING:
claude:
  file_read: Read
  file_write: Write
  terminal_exec: Bash
  search_glob: Glob
  search_grep: Grep
  web_request: null
  task_invoke: Task

grok:
  file_read: read_file
  file_write: write_file
  terminal_exec: run_command
  search_glob: glob_search
  search_grep: grep_search
  web_request: http_request
  task_invoke: invoke_agent

codex:
  file_read: readFile
  file_write: writeFile
  terminal_exec: execTerminal
  search_glob: findFiles
  search_grep: searchText
  web_request: fetchUrl
  task_invoke: callAgent

AGENT_EXECUTION_MODEL:

For Claude (Sub-Agent Native):
1. PLATFORM_DETECTION: Identify running platform
2. CAPABILITY_MAPPING: Map universal capabilities to platform tools
3. SUB_AGENT_INVOCATION: Use Task tool to invoke agent files directly
4. RESULT_NORMALIZATION: Convert platform-specific results to universal format

For Codex/Grok (Sequential Simulation):
1. PLATFORM_DETECTION: Identify running platform
2. WORKFLOW_PARSING: Read workflow instructions and agent references
3. INLINE_EXECUTION: Main agent reads agent files and executes logic sequentially
4. CONTEXT_PASSING: Results passed between simulated "agent invocations"
5. RESULT_SYNTHESIS: Combine outputs into unified workflow result

HYBRID_EXECUTION_STRATEGY:
- Claude: True sub-agent orchestration with Task tool
- Codex/Grok: Sequential workflow simulation with context passing
- Universal Interface: Same workflow definitions work across all platforms

PLATFORM_CAPABILITY_MATRIX:
claude:
  sub_agent_support: true
  execution_model: parallel_orchestration
  context_sharing: automatic

codex:
  sub_agent_support: false
  execution_model: sequential_simulation
  context_sharing: manual_passing

grok:
  sub_agent_support: false
  execution_model: sequential_simulation
  context_sharing: manual_passing

ERROR_HANDLING:
- SUB_AGENT_UNAVAILABLE: Switch to sequential simulation mode
- CAPABILITY_LIMITATION: Clear platform-specific workarounds provided
- EXECUTION_FAILURE: Comprehensive error reporting with recovery suggestions
- INCOMPATIBLE_FEATURE: Feature detection with graceful degradation
