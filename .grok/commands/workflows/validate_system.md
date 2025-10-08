# {{platform_vars.command_prefix}}sdd-task --validate_system

PURPOSE: Comprehensive framework validation and health check. Validates agent registry, path variables, and framework integrity.

WORKFLOW_STEPS:

SEQUENCE_GUARDS:
- PRE_FLIGHT:
  - REQUIRE dispatcher pre-flight validations completed
  - IF not → RETURN {{errors.shared.ERR_014}}

FRAMEWORK_VALIDATION:
1. AGENT_REGISTRY_CHECK:
   - READ {{agents.agent_registry_validator}} for agent_registry_validator guidance
- EXECUTE agent_registry_validator using appropriate platform tools → registry_status|paths_status|framework_status
   - CHECK all agent files exist and are properly formatted
   - VERIFY agent registry mappings in variables.yml
   - VALIDATE required agent metadata: name, description, tools

2. PATH_VARIABLES_CHECK:
   - RESOLVE all {{paths.*}} variables
   - VERIFY all resolved paths exist and are accessible
   - CHECK directory permissions (read/write access)
   - TEST file creation in log directories

3. FRAMEWORK_INTEGRITY_CHECK:
   - VERIFY {{paths.base_dir}} base directory structure
   - CHECK required subdirectories exist: agents/, analytics/, commands/, config/, etc.
   - VALIDATE config files: variables.yml, config.json, mcp-config.yml
   - ENSURE workflow files exist for all commands

4. DEPENDENCY_VALIDATION:
   - CHECK MCP connectivity if configured
   - VERIFY template files exist
   - VALIDATE error code mappings:
     * CHECK all {{errors.*}} variables resolve correctly
     * VERIFY error codes referenced in workflows exist in variables.yml
     * VALIDATE error code format consistency
     * CONFIRM no duplicate error codes
   - CONFIRM system counts accuracy
   - CROSS-REFERENCE workflow error references against variables.yml

5. HEALTH_REPORTING:
   - COMPILE comprehensive health report
   - LOG validation results to analytics
   - DISPLAY status summary to user
   - SUGGEST remediation for any issues found

AGENT_INVOCATIONS:
- {{agents.agent_registry_validator}} - performs registry and path validation
- {{agents.logger}} - logs validation results

OUTPUT_FORMAT:
{
  "validation_timestamp": "ISO_DATE",
  "overall_status": "healthy|warning|critical",
  "registry_status": "valid|invalid",
  "paths_status": "valid|invalid",
  "framework_status": "valid|invalid",
  "details": {
    "agents_checked": COUNT,
    "paths_validated": COUNT,
    "directories_verified": COUNT
  },
  "issues": ["[specific validation errors]"],
  "recommendations": ["[suggested fixes]"]
}

ERROR_HANDLING:
- REGISTRY_INVALID: {{errors.shared.ERR_014}} → agent registry corrupted
- PATHS_INVALID: {{errors.shared.ERR_014}} → path resolution failed
- FRAMEWORK_INVALID: {{errors.shared.ERR_014}} → framework structure corrupted
- VALIDATION_TIMEOUT: [ERR_017] → validation process timed out
