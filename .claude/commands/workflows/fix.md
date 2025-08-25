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
- **Specs**: `.claude/specs/fix-[task-id]-[date]/` or `.claude/specs/fix-standalone-[fix-id]-[date]/` (spec.md, tasks.json)
- **Agents**: `.claude/agents/` (task-schema-validator.md, context-fetcher.md, file-creator.md, code-reviewer.md, test-runner.md, date-checker.md)

## Command Syntax
```
/sdd-task --fix [task-id]
```
- **Arguments**: Optional `task-id` (e.g., `BTN-012`) to provide context from existing task. If omitted, creates a standalone fix.
- **CLI Parsing**: The optional parameter uses square brackets `[task-id]` syntax, similar to `--analyze [paths...]`. Parser should handle both forms:
  - `/sdd-task --fix` → Standalone fix mode
  - `/sdd-task --fix BTN-012` → Context-aware fix mode

## Workflow
1. **Parse Input**:
   - Read optional `task-id` from `/sdd-task --fix [task-id]` via CLI or dashboard.
   - **Parameter Detection**: Check if argument following `--fix` exists and is not another flag.
   - **Validation**: If `task-id` provided, validate format (e.g., alphanumeric with dashes).
2. **Read Changelog Context**:
   - Use `.claude/agents/logger.md` in read mode to gather recent project changes and context.
3. **Determine Fix Context**:
   - If `task-id` provided: Use `.claude/agents/context-fetcher.md` to load related spec from `.claude/specs/[feature-name]_[type]_*/`.
   - If no `task-id`: Work as standalone fix without existing task context.
4. **Prompt for Fix Details**:
   - Via dashboard or CLI, prompt for:
     - **Issue Description**: What needs to be fixed? (e.g., "Login button not responding on mobile")
     - **Affected Files/Components**: If known (e.g., `src/components/LoginButton.tsx`)
     - **Severity**: Critical, High, Medium, Low
5. **Generate Fix ID**:
   - If `<task-id>` provided: Create `FIX-[task-id]-001` (increment if multiple fixes for same task)
   - If standalone: Create `FIX-[date]-001` based on date
6. **Create Fix Spec Directory**:
   - Use `.claude/agents/file-creator.md` to create:
     - With task-id: `.claude/specs/fix-[task-id]-[date]/`
     - Standalone: `.claude/specs/fix-standalone-[fix-id]-[date]/`
   - Set `created_date` via `.claude/agents/date-checker.md`
7. **Generate `tasks.json`**:
   - Populate with the 14-field schema: `id`, `type`, `title`, `description`, `status`, `priority`, `created_date`, `ux_ui_reviewed`, `theme_changes`, `completed_date`, `target_files`, `dependencies`, `linked_task`, `acceptance_criteria`
   - Defaults: `type: "fix"`, `status: "pending"`, `priority` based on severity, `ux_ui_reviewed: false`, `theme_changes: false` (unless UI-related)
   - Set `linked_task` to `task-id` if provided
   - Validate using `.claude/agents/task-schema-validator.md`
8. **Analyze Affected Code**:
   - If files specified, use `.claude/agents/context-fetcher.md` to examine current state
   - If task-id provided, cross-reference with `target_files` from original task
9. **Implement Fix**:
   - Apply targeted fix while preserving existing functionality
   - Ensure compliance with `.claude/standards/theme-standards.md` for UI-related fixes
   - Create `.bak` copies of modified files for rollback capability
10. **Run Tests**:
    - Use `.claude/agents/test-runner.md` to run relevant tests
    - Write new tests if the fix addresses a previously untested scenario
11. **Theme Review** (if applicable):
    - For UI-related fixes, use `.claude/agents/code-reviewer.md` to verify compliance
12. **Update Task State**:
    - Mark status `"completed"` and set `completed_date` using `.claude/agents/date-checker.md`
    - Update `target_files` with actually modified files
    - Set `ux_ui_reviewed: true` if theme review passed
13. **Link to Original Task** (if applicable):
    - If `task-id` was provided, add reference to fix in original task's spec directory
14. **Generate Report**:
    - Output fix results, test outcomes, and any recommendations to console or dashboard
15. **Log Fix Completion**:
    - Use `.claude/agents/logger.md` in write mode to record fix completion in `.claude/changelog.md`

## Dashboard Integration
- The dashboard provides:
  - Optional task-id selector (dropdown from existing tasks)
  - Form fields for issue description, affected files, and severity
  - Visual diff of changes made
  - Link to original task context if task-id provided

## Error Handling

### CLI Parameter Parsing Errors
- **Malformed Task ID**: Return "Error: Invalid task-id format. Use alphanumeric with dashes (e.g., BTN-012)."
- **Flag Confusion**: Return "Error: Expected task-id or no arguments after --fix. Found flag: [flag]."
- **Ambiguous Parameters**: Return "Error: --fix accepts one optional task-id. Multiple arguments not supported."

### Task Context Errors  
- **Invalid Task ID** [ERR_005]: Return "Error [ERR_005]: Task ID not found in `.claude/specs/`."
- **Missing Fix Description** [ERR_002]: Return "Error [ERR_002]: --fix requires issue description."
- **No Files to Fix**: Return "Error: Unable to locate files to fix. Please specify target files."

### Execution Errors
- **Test Failures** [ERR_007]: Return "Error [ERR_007]: Fix validation failed. Tests must pass before completion."
- **Schema Validation Failure** [ERR_003]: Return validation errors from `.claude/agents/task-schema-validator.md`
- **Missing Standards** [ERR_004]: Return "Error [ERR_004]: `.claude/standards/theme-standards.md` not found."

## Example Usage
```
# Fix linked to existing task
/sdd-task --fix BTN-012

# Standalone fix
/sdd-task --fix
```

## Output Examples
### Fix with Task Context:
```
Fix Report: FIX-BTN-012-001
============================
Linked Task: BTN-012 (User Login Button)
Issue: Login button not responding on mobile
Files Modified: src/components/LoginButton.tsx
Tests: Passed
Theme Compliance: N/A (non-UI fix)
Status: completed
Overall: PASSED
```

### Standalone Fix:
```
Fix Report: FIX-20250825-001
============================
Issue: Navigation menu overlapping content
Files Modified: src/components/Navigation.tsx, src/styles/navigation.css
Tests: Passed
Theme Compliance: Compliant
Status: completed
Overall: PASSED
```

## Integration Notes
- **Differentiation from --update**: `--fix` addresses bugs/issues, while `--update` applies enhancements
- **Task Linking**: When `<task-id>` provided, the fix inherits context and can reference original requirements
- **Rollback Support**: `.bak` files enable easy rollback if fix causes regressions
- **Schema Compliance**: All fix tasks validated using the unified 14-field schema
- **Git Integration**: Commit messages follow format: `fix(scope): description (TASK-ID)`