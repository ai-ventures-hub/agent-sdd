# /sdd-analyze <paths...>
Analyze project files for potential issues, improvements, or alignment with Theme Standards.

---

## Purpose
- Identify inconsistencies in style, accessibility, and maintainability.
- Check for drift from the active theme.

---

## Workflow
1. **Load Theme Standards**:
   - **Primary source:** `.agent-sdd/standards/theme-files/[theme-name]/theme.css`.
   - **Fallbacks:** syntax-custom.css → app-level CSS if theme.css is missing.
2. **Scan `<paths...>`**:
   - Highlight use of colors, typography, or spacing outside Theme Standards.
   - Spot missing dark mode variants.
   - Identify unused or duplicate utility classes.
   - Check for accessibility issues (focus, ARIA, touch target size).
   - Flag overly complex or duplicated code.
3. **Generate report**:
   - Summarize issues by severity (critical, warning, info).
   - Suggest improvements with links to relevant Theme Standards or coding guidelines.

---

## Notes
- No auto-fix — use `/sdd-review-code --fix` for style corrections.
- Complements `/sdd-review-code` by giving a broader view across multiple files or the whole project.

---

## Example
```sh
# Analyze entire components directory
/sdd-analyze src/components

# Analyze specific file
/sdd-analyze src/lib/api.ts
```
