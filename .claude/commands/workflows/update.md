# /sdd-task --update Workflow

Applies UI/UX enhancements, tweaks, or improvements to existing code when `/sdd-task --update <target>` is invoked, ensuring compliance with Theme Standards. Operates within the `.claude/` directory structure and integrates with the Agent-SDD Dashboard.

## Purpose
- Apply UI/UX enhancements, styling improvements, or accessibility upgrades to a target file or component.
- **Enhancement-focused**: Improves existing functionality rather than fixing broken behavior (use `--fix` for bugs).
- Ensure changes align with `.claude/standards/theme-standards.md`.
- Generate and validate `tasks.json` using the 14-field schema.

## --update vs --fix Distinction
- **--update**: Use for enhancements, improvements, styling changes, or feature additions to working code
- **--fix**: Use for resolving bugs, errors, or broken functionality

### When to Use --update
- ✅ **Styling improvements**: Better colors, spacing, typography
- ✅ **Accessibility enhancements**: Adding ARIA labels, improving focus states
- ✅ **Performance optimizations**: Reducing bundle size, lazy loading
- ✅ **UX improvements**: Better animations, smoother interactions
- ✅ **Feature additions**: Adding new props, extending functionality
- ✅ **Code refactoring**: Cleaner code structure while maintaining behavior

### When to Use --fix Instead
- ❌ **Broken functionality**: Button doesn't click, form doesn't submit
- ❌ **Runtime errors**: JavaScript errors, crashes, exceptions  
- ❌ **Visual bugs**: Layout breaks, elements overlap incorrectly
- ❌ **Logic errors**: Wrong calculations, incorrect data flow
- ❌ **Integration failures**: API calls fail, database connections break

## Examples

### Typical --update Scenarios:
```
"Increase button padding from 8px to 12px for better touch targets"
"Add hover animation to navigation links"  
"Implement dark mode variant for the card component"
"Add loading spinner to improve user feedback"
"Refactor component to use CSS modules instead of styled-components"
```

### Use --fix Instead For:
```
"Login button throws error when clicked" → Use /sdd-task --fix
"Form validation doesn't work on mobile" → Use /sdd-task --fix  
"Navigation menu disappears on window resize" → Use /sdd-task --fix
```

## Directory Context
Uses the `.claude/` structure:
- **Standards**: `.claude/standards/` (theme-standards.md, best-practices.md)
- **Specs**: `.claude/specs/update-[task-id]-[date]/` (spec.md, tasks.json)
- **Agents**: `.claude/agents/` (task-schema-validator.md, context-fetcher.md, file-creator.md, code-reviewer.md, test-runner.md, date-checker.md)

## Command Syntax
```
/sdd-task --update <target>
```
- **Arguments**: Required `target` (file or component, e.g., `src/components/Button/Button.tsx`).

## Workflow
1. **Parse Input**:
   - Read `target` from `/sdd-task --update <target>` via CLI or dashboard.
2. **Read Changelog Context**:
   - Use `.claude/agents/logger.md` in read mode to gather recent project changes and context.
3. **Prompt for Details**:
   - Via dashboard or CLI, prompt for a short description (e.g., "Increase button padding" or "Fix login error").
   - Confirm `target` file(s) or component(s) if unclear.
4. **Generate Task ID**:
   - Create a unique `task-id` (e.g., `BTN-012`) based on `target` and description.
5. **Create Spec Directory**:
   - Use `.claude/agents/file-creator.md` to create `.claude/specs/update-[task-id]-[date]/` with `spec.md` and `tasks.json`.
   - Set `created_date` via `.claude/agents/date-checker.md`.
6. **Generate `tasks.json`**:
   - Populate with the 14-field schema: `id`, `type`, `title`, `description`, `status`, `priority`, `created_date`, `ux_ui_reviewed`, `theme_changes`, `completed_date`, `target_files`, `dependencies`, `linked_task`, `acceptance_criteria`.
   - Defaults: `type: "update"`, `status: "pending"`, `priority: "medium"`, `ux_ui_reviewed: false`, `theme_changes: true`.
   - Set `target_files` from `target`, `title` and `description` from user input, `acceptance_criteria` inferred if needed.
   - Validate using `.claude/agents/task-schema-validator.md`.
7. **Locate and Backup Target**:
   - Use `.claude/agents/context-fetcher.md` to locate `target` in `src/`.
   - Create `.bak` copies of target files.
8. **Implement Update**:
   - Apply UI/UX tweak or fix (e.g., adjust padding, add ARIA labels) while preserving business logic.
   - Ensure compliance with `.claude/standards/theme-standards.md` (e.g., colors, spacing in 4px multiples, WCAG 2.1 AA).
9. **Theme Review**:
   - Use `.claude/agents/code-reviewer.md` to verify `target_files` against `.claude/standards/theme-standards.md`.
10. **Run Tests**:
    - Use `.claude/agents/test-runner.md` to write and run minimal tests for the update.
11. **Commit Suggestion**:
    - Suggest commit message: `update(scope): description (TASK-ID)` (e.g., `update(Button): increase padding (BTN-012)`).
12. **Generate Report**:
    - Output changes, theme review results, test outcomes, and schema validation status to console or dashboard.
13. **Log Update Completion**:
    - Use `.claude/agents/logger.md` in write mode to record update completion in `.claude/changelog.md`.

## Dashboard Integration
- The dashboard provides inputs for `target` and description, with a confirmation prompt for the target.
- Displays the generated spec path, test results, and validation status.

## Error Handling
- **Missing Target** [ERR_002]: Return "Error [ERR_002]: --update requires target file or component."
- **Invalid Target**: Return "Error: Target not found in `src/`."
- **Missing Standards** [ERR_004]: Return "Error [ERR_004]: `.claude/standards/theme-standards.md` not found."
- **Schema Validation Failure** [ERR_003]: Return validation errors from `.claude/agents/task-schema-validator.md`.
- **Test Failure** [ERR_007]: Return "Error [ERR_007]: Tests failed for updated files."

## Example Usage
```
/sdd-task --update src/components/Button/Button.tsx
```
**Example Output**:
```
Update spec created at .claude/specs/update-BTN-012-2025-08-22/
Applied changes to src/components/Button/Button.tsx
Tasks.json validated
Tests passed
Commit suggestion: update(Button): increase padding (BTN-012)
```

## Output Examples
### Successful Update:
```
Update Report: BTN-012
============================
Spec Path: .claude/specs/update-BTN-012-2025-08-22/
Task ID: BTN-012
Changes: Increased button padding
Theme Compliance: Compliant
Tests: Passed
Schema: Valid
Overall: PASSED
```

### Issues Found:
```
Update Report: AUTH-001
============================
Spec Path: .claude/specs/update-AUTH-001-2025-08-22/
Task ID: AUTH-001
Changes: Fixed login error
Theme Compliance: Non-compliant (invalid color)
Tests: Failed
Schema: Valid
Overall: NEEDS ATTENTION
Action: Run /sdd-task --review src/lib/auth.ts
```