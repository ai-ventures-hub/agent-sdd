# /sdd-task --review Workflow

Reviews code for compliance with Theme Standards, accessibility, and style consistency when `grok_sdd_review(paths)` is invoked. Operates within the `.grok/` directory structure and integrates with the Agent-SDD Dashboard.

## Purpose
- Enforce `.grok/standards/theme-standards.md` (colors, typography, spacing, dark mode).
- Ensure WCAG 2.1 AA compliance for accessibility.
- Generate a report with compliance issues and suggestions.

## Directory Context
Uses the `.grok/` structure:
- **Standards**: `.grok/standards/` (theme-standards.md for theme compliance)
- **Specs**: `.grok/specs/[feature-name]_[type]_[date]/` (tasks.json for status updates)
- **Agents**: `.grok/agents/` (context-fetcher.md, code-reviewer.md, file-creator.md)

## Command Syntax
```
grok_sdd_review(paths)
```
- **Arguments**: Required file or directory paths (e.g., `src/components`, `src/lib/api.ts`).

## Workflow
1. **Parse Input**:
   - Read paths from `grok_sdd_review(paths)` via CLI or dashboard.
2. **Read Changelog Context**:
   - Use `.grok/agents/logger.md` in read mode to gather recent project changes and context.
3. **Fetch Context**:
   - Use `.grok/agents/context-fetcher.md` to load `.grok/standards/theme-standards.md` and specified paths.
4. **Analyze Files**:
   - Use `.grok/agents/code-reviewer.md` to:
     - Flag disallowed hardcoded hex/RGB colors conflicting with `.grok/standards/theme-standards.md`.
     - Flag typography, spacing, or shadow usage outside allowed values.
     - Verify dark mode variants for themed colors.
     - Check for missing focus states, ARIA attributes, or inadequate touch target sizes (WCAG 2.1 AA).
5. **Generate Report**:
   - Output issues (errors, warnings) with file:line references to console or dashboard.
   - Include suggestions referencing `.grok/standards/theme-standards.md` or `.grok/standards/best-practices.md`.
6. **Update Task Status**:
   - If no critical issues, use `.grok/agents/file-creator.md` to update `ux_ui_reviewed: true` in the relevant `tasks.json` in `.grok/specs/`.
7. **Log Review Completion**:
   - Use `.grok/agents/logger.md` in write mode to record review results in `.grok/changelog.md`.

## Dashboard Integration
- The dashboard provides a path selector for `--review` (e.g., file picker or text input).
- Displays the report with clickable links to issues and Theme Standards.

## Error Handling
- **Invalid Paths**: Return "Error: Specified path(s) not found."
- **Missing Theme Standards** [ERR_004]: Return "Error [ERR_004]: `.grok/standards/theme-standards.md` not found."
- **No Tasks Found**: Return "Error: No associated task found in `.grok/specs/` for status update."

## Example Usage
```
/sdd-task --review src/components/Button/Button.tsx
/sdd-task --review src/components
```

## Output Examples
### Successful Review:
```
Review Report: src/components/Button/Button.tsx
======================================
Theme compliance: Compliant
Accessibility: WCAG 2.1 AA compliant
Task status: ux_ui_reviewed set to true
Overall: PASSED
```

### Issues Found:
```
Review Report: src/components/Card/Card.tsx
======================================
Theme compliance: Non-compliant (disallowed hex color #FF0000)
Accessibility: Missing ARIA attributes
Suggestions: Use theme color utility classes, add aria-label
Overall: NEEDS ATTENTION
```