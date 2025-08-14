# /sdd-fix [--no-tests] [--fix-style] <target>

Fix a bug, styling issue, or accessibility problem in existing code.

---

## Purpose
- Address defects or non-compliant styles quickly while maintaining Theme Standards.
- Ensure changes stay aligned with the active theme from `/sdd-apply-theme`.

---

## Options
- `--no-tests` → Skip test writing/execution.
- `--fix-style` → Run `.agent-sdd/scripts/fix-theme-style.sh` to auto-replace non-compliant classes with theme-compliant ones.

---

## Workflow
1. **Identify the issue**:
   - Ask for a short description if not obvious from `<target>`.
2. **Locate target file(s)**:
   - Search by name within `src/`.
3. **Backup file(s)**:
   - Create `.bak` copies before making changes.
4. **Implement fix**:
   - Correct logic, UI, or styling.
   - Follow Theme Standards for typography, spacing, and colors.
   - For UI-only fixes, avoid changing business logic.
5. **Theme Review**:
   - Primary source: `.agent-sdd/standards/theme-files/[theme-name]/theme.css` (fail if missing).
   - Fallback: `syntax-custom.css` or `app.css` only if `theme.css` is missing.
   - If `--fix-style` is provided, run `.agent-sdd/scripts/fix-theme-style.sh` before reviewing to ensure theme compliance.
   - Always run `/sdd-review-code` on modified files.  
     If `/sdd-review-code` is not available in your environment, run:  
       `.agent-sdd/scripts/sdd-review-code.sh <target-file>`
6. **Tests**:
   - If not `--no-tests`, write or update tests relevant to the fix and run with `test-runner` agent.
7. **Commit suggestion**:
   - Use `date-checker` for timestamping FIX-ID.
   - Format: `fix(scope): message (FIX-ID)`.

---

## Notes
- Maintain WCAG 2.1 AA compliance and responsiveness.
- Use spacing in 4px multiples (`p-1`, `m-2`, `gap-3`, etc.).
- Always provide `dark:` variants for themed colors where needed.

---

## Examples
```sh
# Fix logic and run theme review
/sdd-fix src/lib/dateFormatter.ts

# Fix button style and auto-fix theme compliance
/sdd-fix src/components/Button/Button.tsx --fix-style

# Fix button style without running tests
/sdd-fix src/components/Button/Button.tsx --no-tests
```
