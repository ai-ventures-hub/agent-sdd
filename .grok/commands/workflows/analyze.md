# /sdd-task --analyze Workflow

Executes project analysis for potential issues, improvements, or alignment with Theme Standards when `/sdd-task --analyze [paths...]` is invoked. Operates within the `.grok/` directory structure and integrates with the Agent-SDD Dashboard.

## Purpose
- Identify inconsistencies in style, accessibility, and maintainability across specified paths or the entire project.
- Check for deviations from `.grok/standards/theme-standards.md`.
- Generate a detailed report with actionable suggestions.

## Directory Context
Uses the `.grok/` structure:
- **Standards**: `.grok/standards/` (theme-standards.md for theme compliance)
- **Agents**: `.grok/agents/` (code-reviewer.md, logger.md)

## Command Syntax
```
/sdd-task --analyze [paths...]
```
- **Arguments**: Optional file or directory paths (e.g., `src/components`, `src/lib/api.ts`). If omitted, analyzes the entire project.

## Workflow
1. **Parse Input**:
   - Read paths from `/sdd-task --analyze [paths...]` via CLI or dashboard.
   - If no paths provided, default to the project root.
2. **Read Changelog Context**:
   - Use `.grok/agents/logger.md` in read mode to gather recent project changes and context.
3. **Load Theme Standards**:
   - Read `.grok/standards/theme-standards.md` directly for theme compliance checking.
   - Note: context-fetcher only supports .md/.json files in .grok directories, not arbitrary project paths.
4. **Analyze Files**:
   - Use `.grok/agents/code-reviewer.md` to:
     - Check colors, typography, and spacing against `.grok/standards/theme-standards.md`.
     - Identify missing dark mode variants.
     - Detect unused or duplicate utility classes.
     - Flag accessibility issues (e.g., focus, ARIA, touch target size).
     - Highlight overly complex or duplicated code.
5. **Generate Report**:
   - Summarize issues by severity (critical, warning, info).
   - Include suggestions with references to `.grok/standards/theme-standards.md` or `.grok/standards/best-practices.md`.
   - Output report to console or dashboard.
6. **Log Analysis Completion**:
   - Use `.grok/agents/logger.md` in write mode to record analysis results in `.grok/changelog.md`.

## Dashboard Integration
- The dashboard provides a path selector for `--analyze` (e.g., file picker or text input).
- Displays the generated report with clickable links to Theme Standards or guidelines.

## Error Handling
- **Invalid Paths**: Return "Error: Specified path(s) not found."
- **Missing Theme Standards** [ERR_004]: Return "Error [ERR_004]: `.grok/standards/theme-standards.md` not found."
- **Empty Project**: Return "Error: No files to analyze in project root."

## Example Usage
```
grok_sdd_analyze(paths)rc/components
grok_sdd_analyze(paths)rc/lib/api.ts
/sdd-task --analyze
```