# /sdd-review-code <paths...> [--fix]
Review code for compliance with Theme Standards, accessibility, and style consistency.

---

## Purpose
- Enforce Theme Standards (colors, typography, spacing, dark mode).
- Ensure adherence to WCAG 2.1 AA.
- Optionally auto‑fix style issues.

---

## Options
- `--fix` → Apply safe, non‑breaking style changes automatically.

---

## Workflow
1. **Load Theme Standards**:
   - **Primary source:** `.agent-sdd/standards/theme-files/[theme-name]/theme.css` (from `/sdd-apply-theme`).
   - **Fallbacks:** `.agent-sdd/standards/theme-files/[theme-name]/syntax-custom.css` → app CSS (`src/app/globals.css` or `src/app.css`) if theme.css is missing.
2. **Analyze files** in `<paths...>`:
   - Flag disallowed hardcoded hex/RGB colors that conflict with Theme Standards.
   - Flag typography, spacing, and shadow usage outside the allow‑list.
   - Ensure dark mode variants exist for themed colors when needed.
   - Check component markup for missing focus states, ARIA attributes, and touch target sizing.
3. **Report results**:
   - Show warnings and errors with file:line references.
4. **If `--fix`**:
   - Replace disallowed colors with corresponding utility classes from Theme Standards.
   - Normalize typography and spacing utilities.
   - Add missing dark mode variants for primary/secondary colors.
   - Do not change business logic.

---

## Output
- Clear summary of compliance issues.
- Suggested or applied fixes if `--fix` is used.

---

## Integration
- Used by `/sdd-execute-task`, `/sdd-tweak`, and `/sdd-fix` after modifications.
- Always run after theme changes to catch non‑compliant styles.

---

## Example
```sh
# Review specific files
/sdd-review-code src/components/Button/Button.tsx src/components/Card/Card.tsx

# Review and auto-fix style issues
/sdd-review-code src/components/Button/Button.tsx --fix
```
