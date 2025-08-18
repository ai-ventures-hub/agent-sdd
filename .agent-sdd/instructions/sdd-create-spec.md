# /sdd-create-spec [--lite | --ui-only]
Create a Software Design Document (SDD) for a new feature or task.

---

## Purpose
- Define clear requirements before starting development.
- Ensure design and implementation follow Theme Standards.
- Support quick or focused specs via flags.

---

## Flags
- `--lite` → Only include **Overview** and **Tasks** (skip UI requirements and testing details).
- `--ui-only` → Focus solely on **UI Requirements** and **Theme Standards**.

---

## Workflow
1. **Prompt for feature name and description**:
   - If user says "what's next?", check `.agent-sdd/product/roadmap.md` for next item.
2. **Get current date** using **date-checker** agent.
3. **Create spec folder**:
   - `.agent-sdd/specs/[CURRENT-DATE]-[feature-name]/` (kebab-case, max 5 words).
4. **Generate `sdd.md`** with:
   - **Overview**: Goal, user story, success criteria.
   - **Technical Specs**:
     - UI requirements (skip if `--lite`).
     - Reference Theme Standards:
       - **Primary source**: `.agent-sdd/standards/theme-files/[theme-name]/theme.css` from `/sdd-apply-theme`.
       - **Fallbacks**: `syntax-custom.css` or `app.css` if `theme.css` missing.
   - **Tasks**:
     - List tasks with IDs, dependencies, effort estimates (`XS=1 day`, `S=2-3 days`, `M=1 week`).
   - **Test Scenarios** (skip if `--lite` or `--ui-only`).
   - **Theme Standards Compliance**:
     - Colors, typography, spacing, and accessibility from `.agent-sdd/standards/theme-standards.md`.
5. **Create `tasks.json`** with task details.
6. **If `--lite`**: Only include Overview and Tasks.
7. **If `--ui-only`**: Focus on UI Requirements and Theme Standards.
8. **Check alignment** with `.agent-sdd/product/*`; update `decisions.md` if needed.
9. **Prompt user**: `"Proceed with Task 1? (yes/no)"`.

---

## Notes
- Keep touch targets ≥ 40px and maintain WCAG 2.1 AA compliance.
- Use spacing in 4px multiples (`p-1`, `m-2`, `gap-3`, etc.).
- Always provide `dark:` variants for themed colors where applicable.

---

## Example
```sh
# Full spec
/sdd-create-spec "Add Hero section with CTA"

# Lite spec (no UI or testing details)
/sdd-create-spec "Add API health check" --lite

# UI-only spec
/sdd-create-spec "Update modal component styling" --ui-only
```
