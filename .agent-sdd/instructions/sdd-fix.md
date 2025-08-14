# /sdd-fix <target> [--no-tests]
Fix a bug, styling issue, or accessibility problem in existing code.

---

## Purpose
- Address defects or non‑compliant styles quickly while maintaining Theme Standards.
- Ensure changes stay aligned with the active theme from `/sdd-apply-theme`.

---

## Options
- `--no-tests` → Skip test writing/execution.

---

## Workflow
1. **Identify the issue**:
   - Ask for a short description if not obvious from `<target>`.
2. **Locate target file(s)**:
   - Search by name within `src/`.
3. **Implement fix**:
   - Correct logic, UI, or styling.
   - Follow Theme Standards for typography, spacing, and colors.
4. **Theme Review**:
   - Run `/sdd-review-code` on modified files.
   - **Source of truth:** `.agent-sdd/standards/theme-files/[theme-name]/theme.css`.
   - Fallback to `syntax-custom.css` or `app.css` only if `theme.css` is missing.
5. **Tests**:
   - If not `--no-tests`, write or update tests relevant to the fix and run with `test-runner` agent.
6. **Commit suggestion**:
   - Format: `fix(scope): message (FIX-ID)`.

---

## Notes
- Keep touch targets ≥ 40px and maintain WCAG 2.1 AA compliance.
- Use spacing in 4px multiples (`p-1`, `m-2`, `gap-3`, etc.).
- Always provide `dark:` variants for themed colors where needed.

---

## Examples
```sh
# Fix logic and run theme review
/sdd-fix src/lib/dateFormatter.ts

# Fix button style without running tests
/sdd-fix src/components/Button/Button.tsx --no-tests
```
