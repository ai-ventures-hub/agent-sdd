# {{platform_vars.command_prefix}}sdd-task --improve <type> <description> [target]

PURPOSE: Implement targeted enhancements or fixes with risk-based validation and logging.

SUPPORTED_TYPES: enhancement, fix, refactor, performance, accessibility

WORKFLOW_STEPS:

SEQUENCE_GUARDS:
- PRE_FLIGHT:
  - REQUIRE dispatcher pre-flight validations completed
  - IF not → RETURN {{errors.shared.ERR_014}}
- AGENT_GATES:
  - REQUIRE context_manager invoked before apply
  - REQUIRE logger (read) invoked before modifications
  - IF missing → RETURN {{errors.shared.ERR_013}} (context) / {{errors.shared.ERR_011}} (logger)
- ORDER_ENFORCEMENT:
  - IF steps executed out of order → RETURN {{errors.shared.ERR_012}}

0. LOGGER_READ: READ {{agents.logger}} for logger guidance
- EXECUTE logger using appropriate platform tools → recent_changes

1. PARSE_ARGUMENTS: Extract improvement type, description, optional target

2. CONTEXT_GATHERING: READ {{agents.context_manager}} for context gathering guidance
- EXECUTE context gathering using read_file tool → collect relevant standards and codebase context

3. TARGET_RESOLUTION: Determine specific files/components to modify
   - AUTO_DETECT target if not specified
   - SUPPORT file patterns and directory scopes
   - VALIDATE target accessibility

4. IMPACT_ASSESSMENT: Evaluate change complexity and risk level
   - LOW_RISK: Single file, simple changes
   - MEDIUM_RISK: Multiple files, logic changes
   - HIGH_RISK: Core functionality, dependencies

5. APPLY_CHANGES: Implement improvements based on specified type
   - USE targeted modification patterns
   - APPLY best practices automatically
   - PRESERVE existing functionality

6. QUALITY_ASSURANCE: Run validation based on type
   - SYNTAX validation: Always performed
   - TYPE_SPECIFIC checks: Based on improvement type
   - SELECTIVE testing: For high-risk changes

7. THEME_COMPLIANCE: READ {{agents.code_reviewer}} for code review guidance
- EXECUTE theme compliance validation using read_file and grep tools → validate UI changes against {{paths.theme_standards_file}}

8. USER_VERIFICATION: Require approval for medium/high-risk changes

9. LOG_COMPLETION: READ {{agents.logger}} for logging guidance
- EXECUTE logging using search_replace tool → record improvement with change summary

VALIDATION_LEVELS:
- ENHANCEMENT: Medium (syntax, import, basic functionality, theme compliance)
- FIX: High (syntax, import, unit tests, integration, regression)
- REFACTOR: Medium (syntax, type safety, performance, maintainability)
- PERFORMANCE: High (syntax, benchmarking, memory, load testing)
- ACCESSIBILITY: High (syntax, WCAG, screen reader, keyboard navigation)

ERROR_HANDLING:
- INVALID_WORKFLOW_TYPE {{errors.improve.ERR_021}}: Type must be enhancement|fix|refactor|performance|accessibility
- TARGET_NOT_FOUND {{errors.improve.ERR_023}}: Cannot locate target file or directory
- HIGH_RISK_REJECTED {{errors.improve.ERR_022}}: High-risk change requires --execute workflow
- VALIDATION_FAILED {{errors.improve.ERR_024}}: Improvement failed validation, changes reverted
