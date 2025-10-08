# {{platform_vars.command_prefix}}sdd-task --edit [<description>]

PURPOSE: Quickly apply safe, single-responsibility edits with minimal context and logging.

WORKFLOW_STEPS:

MANDATORY_FRAMEWORK_COMPLIANCE: All steps MUST use Task tool with specified agents. Direct file access PROHIBITED.

1. PARSE_DESCRIPTION: Extract optional edit description for context

SEQUENCE_GUARDS:
- PRE_FLIGHT:
  - REQUIRE dispatcher pre-flight validations completed
  - IF not → RETURN {{errors.shared.ERR_014}}
- AGENT_GATES:
  - REQUIRE logger (read) invoked before modifications
  - REQUIRE context_manager invoked before implementation
  - IF missing → RETURN {{errors.shared.ERR_011}} (logger) / {{errors.shared.ERR_013}} (context)
- ORDER_ENFORCEMENT:
  - IF steps executed out of order → RETURN {{errors.shared.ERR_012}}

2. MANDATORY_LOGGER_READ: READ {{agents.logger}} for logger guidance
- EXECUTE logger using appropriate platform tools → recent_changes
   - VALIDATION: Must complete before proceeding to step 3

3. TARGET_RESOLUTION: Determine files requiring modification
   - IF --file flag provided: use specified file
   - IF no file specified: prompt user to select target
   - SUPPORT multiple files for batch edits

4. MANDATORY_CONTEXT_GATHERING: READ {{agents.context_manager}} for context gathering guidance
- EXECUTE context gathering using read_file tool → minimal_context(target_files=[file_list])
   - VALIDATION: Must complete before proceeding to step 5

5. APPLY_CHANGES: Execute simple code modifications using file modification tools
   - SUPPORT common edit patterns (typos, formatting, simple refactoring)
   - APPLY changes directly to target files identified in context gathering
   - SKIP complex validation for speed

6. BASIC_VALIDATION: Run minimal checks
   - SYNTAX validation only
   - SKIP comprehensive testing for small edits
   - SKIP theme compliance checks

7. MANDATORY_LOGGER_WRITE: READ {{agents.logger}} for logger guidance
- EXECUTE logger using appropriate platform tools
   - VALIDATION: Must complete to finalize workflow

8. STATUS_UPDATE: Mark as completed with simple confirmation

ERROR_HANDLING:
- WORKFLOW_BYPASS {{errors.shared.ERR_010}}: Direct file modification detected
- MISSING_AGENT_INVOCATION {{errors.shared.ERR_011}}: Required agent not invoked
- STEP_SEQUENCE_VIOLATION {{errors.shared.ERR_012}}: Steps executed out of order
- CONTEXT_GATHERING_SKIPPED {{errors.shared.ERR_013}}: Context manager not invoked

CONSTRAINTS:
- NO complex logic changes
- SINGLE responsibility per edit
- NO new features
- SAFE operations only
- QUICK validation only
