# {{platform_vars.command_prefix}}sdd-task --agent <agent_name> [--tools Read,Write,Bash]

PURPOSE: Scaffold a new agent, register it in variables.yml, and validate registry integrity.

WORKFLOW_STEPS:

SEQUENCE_GUARDS:
- PRE_FLIGHT:
  - REQUIRE dispatcher pre-flight validations completed
  - IF not → RETURN {{errors.shared.ERR_014}}
- ORDER_ENFORCEMENT:
  - IF steps executed out of order → RETURN {{errors.shared.ERR_012}}

1. PARSE_ARGUMENTS:
   - agent_name: required (snake_case)
   - tools: optional list (default: [Read, Write])
   - IF missing agent_name → RETURN {{errors.shared.ERR_002}}

2. VALIDATE_NAME:
   - ENFORCE snake_case regex `^[a-z][a-z0-9_]*$`
   - REJECT reserved names: [system, core, base, default, test]
   - MAX length: 32 characters
   - IF invalid format → RETURN {{errors.agent.ERR_030}}
   - IF reserved name → RETURN {{errors.agent.ERR_031}}

3. VALIDATE_TOOLS:
   - ALLOWED tools: [Read, Write, Edit, Glob, Grep, Bash, Task, WebFetch, WebSearch]
   - PARSE comma-separated list
   - IF invalid tool → RETURN {{errors.agent.ERR_032}}
   - IF empty tools list → DEFAULT to [Read, Write]

4. COLLISION_CHECKS:
   - PATH: {{paths.agents_dir}}/<agent_name>.md must NOT exist
   - REGISTRY: variables.yml.agents.<agent_name> must NOT exist
   - IF file exists → RETURN {{errors.agent.ERR_033}}
   - IF registry exists → RETURN {{errors.agent.ERR_034}}

5. DIRECTORY_CHECK:
   - VERIFY {{paths.agents_dir}} exists
   - IF missing → CREATE directory
   - IF creation fails → RETURN {{errors.bootstrap.ERR_019}}

6. GENERATE_AGENT_FILE:
   - READ {{agents.file_creator}} for file_creator guidance
- EXECUTE file_creator using appropriate platform tools
   - REPLACE placeholders: <agent-name>, <Agent Name>, tools list
   - TARGET: {{paths.agents_dir}}/<agent_name>.md
   - IF file write fails → RETURN {{errors.bootstrap.ERR_018}}

7. REGISTER_IN_VARIABLES:
   - READ {{agents.file_creator}} for file_creator guidance
- EXECUTE file_creator using appropriate platform tools
   - APPEND mapping to variables.yml under agents:
     - <agent_name>: "{{paths.agents_dir}}/<agent_name>.md"
   - UPDATE system_counts.agents += 1
   - IF file write fails → RETURN {{errors.bootstrap.ERR_018}}

8. VALIDATE_REGISTRY:
   - READ {{agents.agent_registry_validator}} for agent_registry_validator guidance
- EXECUTE agent_registry_validator using appropriate platform tools → OK|violations
   - IF violations → RETURN {{errors.shared.ERR_014}}

9. LOG_COMPLETION:
   - READ {{agents.logger}} for logger guidance
- EXECUTE logger using appropriate platform tools

ERROR_HANDLING:
- MISSING_ARGUMENTS {{errors.shared.ERR_002}}
- INVALID_NAME_FORMAT {{errors.agent.ERR_030}}
- RESERVED_NAME {{errors.agent.ERR_031}}
- INVALID_TOOLS {{errors.agent.ERR_032}}
- FILE_EXISTS {{errors.agent.ERR_033}}
- REGISTRY_EXISTS {{errors.agent.ERR_034}}
- DIR_CREATION_FAILED {{errors.bootstrap.ERR_019}}
- FILE_WRITE_FAILED {{errors.bootstrap.ERR_018}}
- REGISTRY_VALIDATION_FAILED {{errors.shared.ERR_014}}
