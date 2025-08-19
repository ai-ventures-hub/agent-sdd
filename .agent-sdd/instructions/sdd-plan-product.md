# /sdd-plan-product
Plan out the product roadmap, features, and milestones.

---

## Purpose
- Break down the product vision into actionable phases.
- Ensure design and implementation will align with Theme Standards.

---

## Workflow
1. **Review context**:
   - Check `.agent-sdd/product/vision.md` for high-level goals.
   - Look at `.agent-sdd/product/roadmap.md` for current progress.
2. **Confirm Theme Standards**:
   - **Primary source:** `.agent-sdd/standards/theme-files/[theme-name]/theme.css`.
   - **Fallbacks:** `syntax-custom.css` or `app.css` if theme.css missing.
   - Ensure new features and UI elements will use approved color, typography, and spacing utilities.
3. **Define milestones**:
   - Each milestone should have a clear deliverable and measurable outcome.
4. **List features** under each milestone:
   - Assign priority (P0 = critical, P1 = high, P2 = nice-to-have).
   - Note dependencies.
5. **Identify risks** and mitigation strategies.
6. **Save plan**:
   - Write to `.agent-sdd/product/roadmap.md`.
   - Add any strategic decisions to `.agent-sdd/product/decisions.md`.

---

## Notes
- Keep accessibility and performance in mind for all UI-related items.
- Ensure the plan allows for incremental delivery where possible.

---

## Example
```sh
/sdd-plan-product
```
