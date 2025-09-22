# /sdd-task --edit [<description>] Workflow

WORKFLOW_STEPS:

MANDATORY_FRAMEWORK_COMPLIANCE: All steps MUST use Task tool with specified agents. Direct file access PROHIBITED.

1. PARSE_DESCRIPTION: Extract optional edit description for context

2. MANDATORY_LOGGER_READ:
   <invoke name="Task">
   <parameter name="subagent_type">logger</parameter>
   <parameter name="description">Read recent changes</parameter>
   <parameter name="prompt">Read recent project changes from changelog for edit context: [description].</parameter>
   </invoke>
   ```
   VALIDATION: Must complete before proceeding to step 3

3. TARGET_RESOLUTION: Determine files requiring modification
   - IF --file flag provided: use specified file
   - IF no file specified: prompt user to select target
   - SUPPORT multiple files for batch edits

4. MANDATORY_CONTEXT_GATHERING:
   <invoke name="Task">
   <parameter name="subagent_type">context-manager</parameter>
   <parameter name="description">Gather minimal context</parameter>
   <parameter name="prompt">Gather minimal context for edit: [description]. Target files: [file_list]</parameter>
   </invoke>
   ```
   VALIDATION: Must complete before proceeding to step 5

5. APPLY_CHANGES: Execute simple code modifications using file modification tools
   - SUPPORT common edit patterns (typos, formatting, simple refactoring)
   - APPLY changes directly to target files identified in context gathering
   - SKIP complex validation for speed

6. BASIC_VALIDATION: Run minimal checks
   - SYNTAX validation only
   - SKIP comprehensive testing for small edits
   - SKIP theme compliance checks

7. MANDATORY_LOGGER_WRITE:
   <invoke name="Task">
   <parameter name="subagent_type">logger</parameter>
   <parameter name="description">Log edit completion</parameter>
   <parameter name="prompt">Record edit completion in changelog: [description]. Files modified: [file_list]. Changes: [summary].</parameter>
   </invoke>
   ```
   VALIDATION: Must complete to finalize workflow

8. STATUS_UPDATE: Mark as completed with simple confirmation

ERROR_HANDLING:
- WORKFLOW_BYPASS [ERR_010]: Direct file modification detected
- MISSING_AGENT_INVOCATION [ERR_011]: Required agent not invoked
- STEP_SEQUENCE_VIOLATION [ERR_012]: Steps executed out of order
- CONTEXT_GATHERING_SKIPPED [ERR_013]: Context manager not invoked

CONSTRAINTS:
- NO complex logic changes
- SINGLE responsibility per edit
- NO new features
- SAFE operations only
- QUICK validation only
