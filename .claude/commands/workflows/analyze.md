# /sdd-task --analyze Workflow

Executes project analysis for potential issues, improvements, or alignment with Theme Standards when `/sdd-task --analyze [paths...]` is invoked. Operates within the `.claude/` directory structure and integrates with the Agent-SDD Dashboard.

## Purpose
- Identify inconsistencies in style, accessibility, and maintainability across specified paths or the entire project.
- Check for deviations from `.claude/standards/theme-standards.md`.
- Generate a detailed report with actionable suggestions.

## Directory Context
Uses the `.claude/` structure:
- **Standards**: `.claude/standards/` (theme-standards.md for theme compliance)
- **Agents**: `.claude/agents/` (context-fetcher.md, code-reviewer.md)

## Command Syntax
```
/sdd-task --analyze [paths...]
```
- **Arguments**: Optional file or directory paths (e.g., `src/components`, `src/lib/api.ts`). If omitted, analyzes the entire project.

## Workflow
1. **Parse Input**:
   - Read paths from `/sdd-task --analyze [paths...]` via CLI or dashboard.
   - If no paths provided, default to the project root.
2. **Fetch Context**:
   - Use `.claude/agents/context-fetcher.md` to load `.claude/standards/theme-standards.md` and specified paths.
3. **Analyze Files**:
   - Use `.claude/agents/code-reviewer.md` to:
     - Check colors, typography, and spacing against `.claude/standards/theme-standards.md`.
     - Identify missing dark mode variants.
     - Detect unused or duplicate utility classes.
     - Flag accessibility issues (e.g., focus, ARIA, touch target size).
     - Highlight overly complex or duplicated code.
4. **Generate Report**:
   - Summarize issues by severity (critical, warning, info).
   - Include suggestions with references to `.claude/standards/theme-standards.md` or `.claude/standards/best-practices.md`.
   - Output report to console or dashboard.

## Dashboard Integration
- The dashboard provides a path selector for `--analyze` (e.g., file picker or text input).
- Displays the generated report with clickable links to Theme Standards or guidelines.

## Error Handling
- **Invalid Paths**: Return "Error: Specified path(s) not found."
- **Missing Theme Standards**: Return "Error: `.claude/standards/theme-standards.md` not found."
- **Empty Project**: Return "Error: No files to analyze in project root."

## Example Usage
```
/sdd-task --analyze src/components
/sdd-task --analyze src/lib/api.ts
/sdd-task --analyze
```