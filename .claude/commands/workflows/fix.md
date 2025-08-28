# /sdd-task --fix [<task-id>] Workflow

Applies targeted fixes to resolve bugs, issues, or inconsistencies when `/sdd-task --fix [<task-id>]` is invoked. Operates within the `.claude/` directory structure and integrates with the Agent-SDD Dashboard.

## Purpose
- Address bugs, errors, or inconsistencies in existing code.
- **Bug-focused**: Resolves broken functionality rather than enhancing working code (use `--update` for enhancements).
- Provide contextual fixes when linked to an existing task via `<task-id>`.
- Create standalone fix specifications when no `<task-id>` is provided.
- Ensure fixes align with `.claude/standards/theme-standards.md` and maintain code quality.

## --fix vs --update Distinction
- **--fix**: Use for bugs, errors, broken functionality, or inconsistencies that need correction
- **--update**: Use for enhancements, improvements, styling changes, or feature additions to working code

### When to Use --fix
- ✅ **Broken functionality**: Button doesn't click, form doesn't submit
- ✅ **Runtime errors**: JavaScript errors, crashes, exceptions
- ✅ **Visual bugs**: Layout breaks, elements overlap incorrectly
- ✅ **Logic errors**: Wrong calculations, incorrect data flow
- ✅ **Integration failures**: API calls fail, database connections break
- ✅ **Regression fixes**: Features that worked before but now don't

### When to Use --update Instead
- ❌ **Styling improvements**: Better colors, spacing, typography
- ❌ **Accessibility enhancements**: Adding ARIA labels, improving focus states
- ❌ **Performance optimizations**: Reducing bundle size, lazy loading
- ❌ **UX improvements**: Better animations, smoother interactions
- ❌ **Feature additions**: Adding new props, extending functionality
- ❌ **Code refactoring**: Cleaner code structure while maintaining behavior

## Examples

### Typical --fix Scenarios:
```
"Login button throws error when clicked"
"Form validation doesn't work on mobile devices"
"Navigation menu disappears on window resize"
"Search results showing incorrect data"
"Payment processing fails with credit cards"
"Dark mode toggle breaks layout in sidebar"
```

### Use --update Instead For:
```
"Increase button padding for better touch targets" → Use /sdd-task --update
"Add hover animation to navigation links" → Use /sdd-task --update
"Implement dark mode variant for cards" → Use /sdd-task --update
```

## Directory Context
Uses the `.claude/` structure:
- **Standards**: `.claude/standards/` (theme-standards.md, best-practices.md)
- **Agents**: `.claude/agents/` (context-fetcher.md, code-reviewer.md, test-runner.md, date-checker.md, logger.md)

## Command Syntax
```
/sdd-task --fix [task-id]
```
- **Arguments**: Optional parameter that can be either:
  - A `task-id` (e.g., `BTN-012`) to provide context from existing task
  - A description string (e.g., `"Login button error"`) for immediate standalone fix
  - Omitted entirely, which will prompt for description
- **CLI Parsing**: The optional parameter uses square brackets `[parameter]` syntax. Parser intelligently handles:
  - `/sdd-task --fix` → Standalone fix mode (prompts for description)
  - `/sdd-task --fix BTN-012` → Context-aware fix mode (task-id detected)
  - `/sdd-task --fix "Login button throws error"` → Standalone fix with description

## Critical Workflow Requirements
**IMPORTANT**: The workflow MUST start with logger.md invocation and end with logger.md completion. These are not optional steps - they are critical for maintaining workflow continuity and context awareness across the Agent-SDD system.

## Workflow
1. **Initialize Logger Context**:
   - **MUST INVOKE**: Use `.claude/agents/logger.md` in read mode to gather recent project changes and establish context awareness.
   - This step is CRITICAL and must execute before any other operations.
2. **Parse Input**:
   - Read optional parameter from `/sdd-task --fix [parameter]` via CLI or dashboard.
   - **Parameter Detection Logic**:
     a. Check if argument following `--fix` exists and is not another flag (starts with `--`).
     b. If parameter exists, check format:
        - If matches task-id pattern (e.g., `BTN-012`, alphanumeric with dashes): Treat as task-id
        - If contains spaces or doesn't match task-id pattern: Treat as issue description for standalone mode
     c. If no parameter: Proceed in standalone mode, will prompt for description later.
   - **Validation**: 
     - Task-id format: Must match pattern like `[A-Z]{2,5}-[0-9]{1,4}`
     - Description: Any text string accepted, used for standalone fix
3. **Read Changelog Context** (if not already loaded):
   - Ensure `.claude/agents/logger.md` context is available for informed decision-making.
4. **Determine Fix Context**:
   - If valid `task-id` provided: Use `.claude/agents/context-fetcher.md` to load related spec from `.claude/specs/[feature-name]_[type]_*/`.
   - If description provided or no parameter: Work as standalone fix without existing task context.
   - Store any provided description for use in step 5.
5. **Prompt for Fix Details**:
   - Via dashboard or CLI, prompt for:
     - **Issue Description**: What needs to be fixed? (Skip if description already provided as parameter)
     - **Affected Files/Components**: If known (e.g., `src/components/LoginButton.tsx`)
     - **Severity**: Critical, High, Medium, Low
6. **Analyze Affected Code**:
   - If files specified, use `.claude/agents/context-fetcher.md` to examine current state
   - If task-id provided, cross-reference with existing task context
7. **Implement Fix**:
   - Apply targeted fix while preserving existing functionality
   - Ensure compliance with `.claude/standards/theme-standards.md` for UI-related fixes
   - Create `.bak` copies of modified files for rollback capability
8. **Run Tests**:
   - Use `.claude/agents/test-runner.md` to run relevant tests
   - Write new tests if the fix addresses a previously untested scenario
9. **Theme Review** (if applicable):
   - For UI-related fixes, use `.claude/agents/code-reviewer.md` to verify compliance
10. **Generate Report**:
    - Output fix results, test outcomes, and any recommendations to console or dashboard
11. **Validate and Complete**:
    - **MUST INVOKE**: Use `.claude/agents/task-validator.md` to manage user validation and completion logging
    - Provide task data including:
      - Command executed (e.g., "/sdd-task --fix BTN-012")
      - Task ID (if applicable)
      - Description of fix applied
      - Files modified
      - Changes summary
    - Include git data (diff output, status)
    - Task-validator agent handles:
      - Presenting changes to user with clear before/after context
      - Collecting user feedback on fix effectiveness
      - Managing iterative improvement cycles if issues found
      - Invoking logger.md only upon confirmed user approval
    - This step is CRITICAL for ensuring fix quality and maintaining workflow continuity

## Dashboard Integration
- The dashboard provides:
  - Optional task-id selector (dropdown from existing tasks)
  - Form fields for issue description, affected files, and severity
  - Visual diff of changes made
  - Link to original task context if task-id provided

## Error Handling

### CLI Parameter Parsing Errors
- **Invalid Task ID Format**: When parameter doesn't match task-id pattern but isn't a description, inform: "Note: '[parameter]' doesn't match task-id format (e.g., BTN-012). Treating as issue description for standalone fix."
- **Flag Confusion**: Return "Error: Unexpected flag after --fix. Found: [flag]. Use '/sdd-task --fix' for standalone or '/sdd-task --fix TASK-ID' for context-aware fix."
- **Multiple Arguments**: Return "Error: --fix accepts one optional parameter (task-id or description). Multiple arguments not supported."

### Task Context Errors  
- **Invalid Task ID** [ERR_005]: Return "Error [ERR_005]: Task ID not found in `.claude/specs/`."
- **Missing Fix Description** [ERR_002]: Return "Error [ERR_002]: --fix requires issue description."
- **No Files to Fix**: Return "Error: Unable to locate files to fix. Please specify target files."

### Execution Errors
- **Test Failures** [ERR_007]: Return "Error [ERR_007]: Fix validation failed. Tests must pass before completion."
- **Missing Standards** [ERR_004]: Return "Error [ERR_004]: `.claude/standards/theme-standards.md` not found."

## Example Usage
```
# Fix linked to existing task (task-id format detected)
/sdd-task --fix BTN-012

# Standalone fix with description provided
/sdd-task --fix "Login button throws error on mobile devices"

# Standalone fix (will prompt for description)
/sdd-task --fix
```

## Output Examples
### Fix with Task Context:
```
Fix Report
============================
Linked Task: BTN-012 (User Login Button)
Issue: Login button not responding on mobile
Files Modified: src/components/LoginButton.tsx
Tests: Passed
Theme Compliance: N/A (non-UI fix)
Overall: AWAITING USER VERIFICATION

Please test the fix. Does it resolve the issue completely?
```

### Standalone Fix:
```
Fix Report
============================
Issue: Navigation menu overlapping content
Files Modified: src/components/Navigation.tsx, src/styles/navigation.css
Tests: Passed
Theme Compliance: Compliant
Overall: AWAITING USER VERIFICATION

Please test the fix. Does it resolve the issue completely?
```

### After User Confirmation:
```
Fix Completion
============================
User Verification: CONFIRMED - Fix working as expected
Status: COMPLETED and logged to changelog
```

## Integration Notes
- **Differentiation from --update**: `--fix` addresses bugs/issues, while `--update` applies enhancements
- **Task Linking**: When `<task-id>` provided, the fix inherits context and can reference original requirements
- **Rollback Support**: `.bak` files enable easy rollback if fix causes regressions
- **Git Integration**: Commit messages follow format: `fix(scope): description`