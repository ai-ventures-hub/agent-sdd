# sdd-task --agent <agent_name> [--tools Read,Write,Run_terminal_cmd]

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

2. VALIDATE_NAME:
   - ENFORCE snake_case regex `^[a-z0-9_]+$`
   - IF invalid → RETURN {{errors.shared.ERR_003}}

3. COLLISION_CHECKS:
   - PATH: {{paths.agents_dir}}/<agent_name>.md must NOT exist
   - REGISTRY: variables.yml.agents.<agent_name> must NOT exist
   - IF collision → RETURN {{errors.shared.ERR_003}}

4. GENERATE_AGENT_FILE:
   - SOURCE: {{templates.agents.agent_template}}
   - TARGET: {{paths.agents_dir}}/<agent_name>.md
   - REPLACE placeholders: <agent-name>, <Agent Name>, tools list
   - IF file write fails → RETURN {{errors.bootstrap.ERR_018}}

5. REGISTER_IN_VARIABLES:
   - APPEND mapping to variables.yml under agents:
     - <agent_name>: "{{paths.agents_dir}}/<agent_name>.md"
   - IF file write fails → RETURN {{errors.bootstrap.ERR_018}}

6. VALIDATE_REGISTRY:
   - {{agents.agent_registry_validator}}(mode="validate") → OK|violations
   - IF violations → RETURN {{errors.shared.ERR_014}}

7. LOG_COMPLETION:
   - {{agents.logger}}(mode="write", summary="agent:<agent_name>")

ERROR_HANDLING:
- INVALID_NAME {{errors.shared.ERR_003}}
- FILE_WRITE_FAILED {{errors.bootstrap.ERR_018}}
- DIR_CREATION_FAILED {{errors.bootstrap.ERR_019}}
- PRE_FLIGHT_FAILED {{errors.shared.ERR_014}}
