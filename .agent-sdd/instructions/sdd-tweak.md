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
   - E.g., "Increase padding on primary button", "Adjust card shadow", "Fix text contrast".
2. **Create tracking spec** (optional, for complex tweaks):
   - Use **date-checker** agent to get current date.
   - Create `.agent-sdd/specs/tweak-[task-id]-[CURRENT-DATE]/tasks.json` if tracking is needed.
3. **Locate target file(s)**:
   - Search by component or file name within `src/`.
4. **Backup file(s)**:
   - Create `.bak` copies before making any modifications.
5. **Make the change**:
   - Restrict scope to UI/UX adjustments unless explicitly approved to change logic.
   - Keep typography, spacing, and color variables within Theme Standards.
6. **Theme Review**:
   - Primary source: `.agent-sdd/standards/theme-files/[theme-name]/theme.css` (fail if missing).
   - Fallbacks: `syntax-custom.css` or `app.css` only if `theme.css` is missing.
   - Always run `/sdd-review-code` on modified files.  
     If `/sdd-review-code` is not available in your environment, run:  
       `.agent-sdd/scripts/sdd-review-code.sh <target-file>`
6a. **Auto-fix styles (if `--fix-style`)**:
   - Run `.agent-sdd/scripts/fix-theme-style.sh` to auto-replace non-compliant classes with theme-compliant ones before reviewing.
7. **Tests**:
   - If not `--no-tests` and relevant, run minimal tests via `test-runner` agent.
8. **Commit suggestion**:
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
## Examples
```
