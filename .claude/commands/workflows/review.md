# /sdd-task --review Workflow

Reviews code for compliance with Theme Standards, accessibility, and style consistency when `/sdd-task --review <paths...>` is invoked. Operates within the `.claude/` directory structure and integrates with the Agent-SDD Dashboard.

## Purpose
- Enforce `.claude/standards/theme-standards.md` (colors, typography, spacing, dark mode).
- Ensure WCAG 2.1 AA compliance for accessibility.
- Generate a report with compliance issues and suggestions.

## Directory Context
Uses the `.claude/` structure:
- **Standards**: `.claude/standards/` (theme-standards.md for theme compliance)
- **Specs**: `.claude/specs/create-spec-[task-id]-[date]/` (tasks.json for status updates)
- **Agents**: `.claude/agents/` (context-fetcher.md, code-reviewer.md, file-creator.md)

## Command Syntax
```
/sdd-task --review <paths...>
```
- **Arguments**: Required file or directory paths (e.g., `src/components`, `src/lib/api.ts`).

## Workflow
1. **Parse Input**:
   - Read paths from `/sdd-task --review <paths...>` via CLI or dashboard.
2. **Read Changelog Context**:
   - Use `.claude/agents/logger.md` in read mode to gather recent project changes and context.
3. **Fetch Context**:
   - Use `.claude/agents/context-fetcher.md` to load `.claude/standards/theme-standards.md` and specified paths.
4. **Analyze Files**:
   - Use `.claude/agents/code-reviewer.md` to:
     - Flag disallowed hardcoded hex/RGB colors conflicting with `.claude/standards/theme-standards.md`.
     - Flag typography, spacing, or shadow usage outside allowed values.
     - Verify dark mode variants for themed colors.
     - Check for missing focus states, ARIA attributes, or inadequate touch target sizes (WCAG 2.1 AA).
5. **Generate Report**:
   - Output issues (errors, warnings) with file:line references to console or dashboard.
   - Include suggestions referencing `.claude/standards/theme-standards.md` or `.claude/standards/best-practices.md`.
6. **Update Task Status**:
   - If no critical issues, use `.claude/agents/file-creator.md` to update `ux_ui_reviewed: true` in the relevant `tasks.json` in `.claude/specs/`.
7. **Log Review Completion**:
   - Use `.claude/agents/logger.md` in write mode to record review results in `.claude/changelog.md`.

## Dashboard Integration
- The dashboard provides a path selector for `--review` (e.g., file picker or text input).
- Displays the report with clickable links to issues and Theme Standards.

## Error Handling
- **Invalid Paths**: Return "Error: Specified path(s) not found."
- **Missing Theme Standards**: Return "Error: `.claude/standards/theme-standards.md` not found."
- **No Tasks Found**: Return "Error: No associated task found in `.claude/specs/` for status update."

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