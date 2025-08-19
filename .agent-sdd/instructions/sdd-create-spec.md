# /sdd-create-spec [--lite | --ui-only]
Create a Software Design Document (SDD) for a new feature or task.

---

## Purpose
- Define clear requirements before starting development.
- Ensure design and implementation follow Theme Standards.
- Support quick or focused specs via flags for vibe coders.

---

## Flags
- `--lite` → Only include **Overview** and **Tasks** (skip UI requirements and testing details).
- `--ui-only` → Focus solely on **UI Requirements** and **Theme Standards**.

---

## Task Schema
Tasks in `tasks.json` follow the unified schema in `.agent-sdd/standards/task-schema.md`:
- **Required**: `id`, `type: "feature"`, `title`, `description`, `status`, `priority`, `created_date`, `ux_ui_reviewed`, `theme_changes`.
- **Optional**: `completed_date`, `target_files`, `dependencies`, `linked_task`, `acceptance_criteria`, `theme_name`.

**Defaults for vibe coders**:
- `status: "pending"`, `priority: "medium"`, `ux_ui_reviewed: false`, `theme_changes: false`.
- Theme compliance checked against `.agent-sdd/standards/theme-standards.md` if `theme_changes: true`.
- `completed_date`, `target_files`, `dependencies`, `linked_task`, `acceptance_criteria`: Default to `null` or `[]` unless specified in the SDD.

---

## Root Directory Detection
**CRITICAL**: Before any file operations, locate the root `.agent-sdd` directory to prevent duplicate installations:

1. **Check current directory first**: If `.agent-sdd/` exists in current directory, use it.
2. **Search up the tree**: If not found, search parent directories up to root:
   - Check `../.agent-sdd/`, `../../.agent-sdd/`, etc.
   - Stop at first `.agent-sdd/` directory found.
3. **Use absolute paths**: Once found, use that directory for ALL `.agent-sdd/` references.
4. **Never create duplicate**: If no `.agent-sdd/` found, error and tell user to run setup script.

**Example**: If `.agent-sdd/` is found at `/project-root/.agent-sdd/`, ALL references should use that path.

---

## Workflow
1. **Prompt for feature name and description**:
   - If user says "what's next?", check `.agent-sdd/product/roadmap.md` for the next item and suggest it.
2. **Get current date** using **date-checker** agent (e.g., "2025-08-18").
3. **Create spec folder**:
   - `.agent-sdd/specs/create-spec-[task-id]-[CURRENT-DATE]/` (where task-id is kebab-case, max 5 words, derived from feature name).
4. **Generate `sdd.md`**:
   - Use `file-creator` agent to create `sdd.md` with the following content:
   - **Overview**: Goal, user story, success criteria.
   - **Technical Specs**:
     - UI requirements (skip if `--lite`).
     - Reference Theme Standards:
       - **Source of truth**: `.agent-sdd/standards/theme-standards.md`.
       - Use defined design tokens, colors, and component styles.
   - **Tasks**:
     - List tasks with IDs, descriptions, priorities, dependencies, and success criteria.
   - **Test Scenarios** (skip if `--lite` or `--ui-only`).
   - **Theme Standards Compliance**:
     - Colors, typography, spacing, and accessibility from `.agent-sdd/standards/theme-standards.md`.
5. **Create `tasks.json`**:
   - Use `file-creator` to generate `tasks.json` with the feature name and tasks derived from the **Tasks** section.
   - For each task:
     - Set required fields: `id` (e.g., `[FEATURE_NAME]-feature-[N]`), `type: "feature"`, `title` (from task description), `description` (detailed task details), `status: "pending"`, `priority` (from SDD or default "medium"), `created_date` (from `date-checker`), `ux_ui_reviewed: false`, `theme_changes` (true for `--ui-only`, else false).
     - Set optional fields: `target_files` (from Technical Specs or user input), `dependencies` (from SDD), `linked_task` (if task is a follow-up), `acceptance_criteria` (from SDD's success criteria or Test Scenarios).
   - Validate against `.agent-sdd/standards/task-schema.md`.
6. **If `--lite`**: Only include Overview and Tasks, set `theme_changes: false` unless specified.
7. **If `--ui-only`**: Focus on UI Requirements and Theme Standards, set `theme_changes: true` for tasks.
8. **Check alignment** with `.agent-sdd/product/*` (e.g., `roadmap.md`); update `decisions.md` if needed.
9. **Prompt user**: `"Proceed with Task 1? (yes/no)"`.

---

## Notes
- Keep touch targets ≥ 40px and maintain WCAG 2.1 AA compliance.
- Use spacing in 4px multiples (`p-1`, `m-2`, `gap-3`, etc.).
- Always provide `dark:` variants for themed colors where applicable.
- For vibe coders, prompt only for feature name and description; defaults are applied for other fields to simplify task creation.

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

**Generated tasks.json Example**:
```json
{
  "feature": "hero-section-cta",
  "tasks": [
    {
      "id": "hero-section-cta-feature-1",
      "type": "feature",
      "title": "Add Hero section with CTA",
      "description": "Implement a hero section with a call-to-action button.",
      "status": "pending",
      "priority": "high",
      "created_date": "2025-08-18",
      "target_files": ["src/components/Hero/Hero.tsx"],
      "dependencies": [],
      "acceptance_criteria": ["Hero section displays correctly", "CTA button triggers action", "Meets WCAG 2.1 AA"],
      "ux_ui_reviewed": false,
      "theme_changes": true,
    }
  ]
}
```