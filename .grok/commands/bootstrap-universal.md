# Universal Framework Bootstrap

BOOTSTRAP_PROBLEM:
- Claude automatically loads framework specification and recognizes framework
- Grok and Codex require manual framework initialization
- Users need to "teach" these platforms about Agent-SDD

BOOTSTRAP_SOLUTIONS:

1. MANUAL_FRAMEWORK_LOADING:
   ```
   User: "Please read and understand this framework specification"
   [Paste framework specification content]
   User: "Now I can use #sdd-task commands"
   ```

2. GRADUAL_FRAMEWORK_DISCOVERY:
   ```
   User: "#sdd-task --help"
   AI: "I don't recognize this command. Please provide context."
   User: "Read {{paths.base_dir}}/commands/universal-dispatcher.md"
   AI: Learns about universal command structure
   ```

3. CONTEXT_INJECTION_COMMANDS:
   ```
   User: "Read {{paths.base_dir}}/README.md and understand this is Agent-SDD Universal"
   User: "Now process #sdd-task --init"
   ```

FRAMEWORK_INITIALIZATION_SEQUENCE:

For New Projects on Non-Claude Platforms:
1. USER: "I want to use Agent-SDD framework. Please read {{paths.base_dir}}/README.md"
2. AI: Learns about the framework
3. USER: "Now read {{paths.base_dir}}/commands/universal-dispatcher.md to understand commands"
4. AI: Learns command structure
5. USER: "Read {{paths.base_dir}}/config/platform-detection.md to understand platform adaptation"
6. AI: Learns platform handling
7. USER: "Now execute: #sdd-task --init"
8. AI: Processes command using learned framework knowledge

CONTEXT_PERSISTENCE_STRATEGIES:

1. SESSION_MEMORY:
   - Framework knowledge persists within conversation session
   - Re-bootstrap required for new sessions

2. WORKSPACE_LEARNING:
   - AI learns framework from workspace files
   - Subsequent commands leverage learned knowledge

3. HYBRID_APPROACH:
   - Initial bootstrap establishes framework understanding
   - Workspace files reinforce and maintain knowledge

PLATFORM_SPECIFIC_BOOTSTRAP:

Grok Bootstrap:
```
@grok I want to initialize the Agent-SDD framework in this workspace.
Please read these files in order:
1. {{paths.base_dir}}/README.md (framework overview)
2. {{paths.base_dir}}/commands/universal-dispatcher.md (command system)
3. {{paths.base_dir}}/config/platform-detection.md (platform adaptation)
4. {{paths.base_dir}}/config/universal-agent-spec.md (agent system)

Then I'll use commands like: @sdd-task --init
```

Codex Bootstrap:
```
#sdd-task Initialize Agent-SDD Universal framework.
Read and understand:
1. {{paths.base_dir}}/README.md
2. {{paths.base_dir}}/commands/universal-dispatcher.md
3. {{paths.base_dir}}/config/platform-detection.md
4. {{paths.base_dir}}/config/universal-agent-spec.md

Framework ready for commands like: #sdd-task --init
```

VALIDATION_PROTOCOLS:

Post-Bootstrap Verification:
1. COMMAND_RECOGNITION: AI recognizes sdd-task command structure
2. FILE_SYSTEM_AWARENESS: AI understands {{paths.base_dir}} directory structure
3. WORKFLOW_COMPREHENSION: AI can read and execute workflow files
4. AGENT_SYSTEM_UNDERSTANDING: AI comprehends agent invocation patterns

ERROR_RECOVERY:

Bootstrap Failure Scenarios:
- FILE_NOT_FOUND: Guide user to correct workspace setup
- CONTEXT_OVERLOAD: Break bootstrap into smaller chunks
- COMPREHENSION_ISSUES: Provide simplified explanations
- PLATFORM_LIMITATIONS: Identify and work around platform constraints

MAINTENANCE_UPDATES:

Framework Evolution Handling:
- VERSION_CHECK: Detect framework updates
- KNOWLEDGE_REFRESH: Re-read core files when changes detected
- BACKWARD_COMPATIBILITY: Ensure old knowledge still works
- FEATURE_DISCOVERY: Learn about new capabilities automatically
