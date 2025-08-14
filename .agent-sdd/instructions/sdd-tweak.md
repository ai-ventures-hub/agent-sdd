# /sdd-tweak [--fix-style] [--no-tests] <target>

Tweak an existing file or feature and re-run style/theme checks.

---

## Purpose
- Apply small, incremental improvements to UI or styles without a full task cycle.
- Keep changes consistent with **Theme Standards** and accessibility guidelines.
- Ensure tweaks don’t drift from the active theme set by `/sdd-apply-theme`.

---

## Options
- `--fix-style` → After tweak, run `/sdd-review-code` with `--fix` to auto-correct style and theme class usage.
- `--no-tests` → Skip test writing/execution.

---

## Workflow
1. **Prompt user** for tweak details if not provided in `<target>`:
   - E.g., “Increase padding on primary button”, “Adjust card shadow”, “Fix text contrast”.
2. **Locate target file(s)**:
   - Search by component or file name within `src/`.
3. **Backup file(s)**:
   - Create `.bak` copies before making any modifications.
4. **Make the change**:
   - Restrict scope to UI/UX adjustments unless explicitly approved to change logic.
   - Keep typography, spacing, and color variables within Theme Standards.
5. **Theme Review**:
   - Primary source: `.agent-sdd/standards/theme-files/[theme-name]/theme.css` (fail if missing).
   - Fallbacks: `syntax-custom.css` or `app.css` only if `theme.css` is missing.
   - Always run `/sdd-review-code` on modified files.
6. **Tests**:
   - If not `--no-tests` and relevant, run minimal tests via `test-runner` agent.
7. **Commit suggestion**:
   - Use `date-checker` for TWEAK-ID timestamping.
   - Format: `tweak(scope): message (TWEAK-ID)`.

---

## Notes
- **Do not** introduce new features—use `/sdd-execute-task` for that.
- Maintain WCAG 2.1 AA compliance and responsiveness.
- Spacing grid: 4px multiples for `padding`, `margin`, and `gap`.
- Provide `dark:` variants for themed colors where needed.

---

## Examples
```sh
# Tweak padding on button and auto-fix theme styles
/sdd-tweak src/components/Button/Button.tsx --fix-style

# Adjust shadow on Card without running tests
/sdd-tweak src/components/Card/Card.tsx --no-tests
