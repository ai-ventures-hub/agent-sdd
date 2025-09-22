# sdd-task --improve <type> <description> [target]

PURPOSE: Implement targeted enhancements or fixes with risk-based validation and logging.

SUPPORTED_TYPES: enhancement, fix, refactor, performance, accessibility

WORKFLOW_STEPS:

1. PARSE_ARGUMENTS: Extract improvement type, description, optional target

2. CONTEXT_GATHERING: {{agents.context_manager}} → collect relevant standards and codebase context

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

7. THEME_COMPLIANCE: {{agents.code_reviewer}} → validate UI changes against {{paths.standards_dir}}/theme-standards.md

8. USER_VERIFICATION: Require approval for medium/high-risk changes

9. LOG_COMPLETION: {{agents.logger}} → record improvement with change summary

VALIDATION_LEVELS:
- ENHANCEMENT: Medium (syntax, import, basic functionality, theme compliance)
- FIX: High (syntax, import, unit tests, integration, regression)
- REFACTOR: Medium (syntax, type safety, performance, maintainability)
- PERFORMANCE: High (syntax, benchmarking, memory, load testing)
- ACCESSIBILITY: High (syntax, WCAG, screen reader, keyboard navigation)

ERROR_HANDLING:
- INVALID_WORKFLOW_TYPE [ERR_021]: Type must be enhancement|fix|refactor|performance|accessibility
- TARGET_NOT_FOUND [ERR_023]: Cannot locate target file or directory
- HIGH_RISK_REJECTED [ERR_022]: High-risk change requires --execute workflow
- VALIDATION_FAILED: Improvement failed validation, changes reverted
