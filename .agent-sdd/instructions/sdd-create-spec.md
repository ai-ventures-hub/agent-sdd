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

## Task Schema Enforcement
**CRITICAL**: ALL tasks MUST be created in `tasks.json` format following `.agent-sdd/standards/task-schema.md`.

### Required Schema Compliance
Tasks in `tasks.json` MUST follow the unified schema in `.agent-sdd/standards/task-schema.md`:
- **Required Fields**: `id`, `type: "feature"`, `title`, `description`, `status`, `priority`, `created_date`, `ux_ui_reviewed`, `theme_changes`.
- **Optional Fields**: `completed_date`, `target_files`, `dependencies`, `linked_task`, `acceptance_criteria`.
- **Schema Validation**: Use `file-creator` agent to validate ALL tasks against schema before file creation.
- **No Manual Task Creation**: Tasks MUST NOT be created manually - only through `tasks.json` structure.

### Schema Defaults for Vibe Coders
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
4. **Generate `spec.md`**:
   - Use `file-creator` agent to create `spec.md` with the following content:
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
5. **Create `tasks.json` (MANDATORY)**:
   - **CRITICAL**: Use `file-creator` agent to generate `tasks.json` - this is the ONLY way to create tasks.
   - **Schema Reference**: Tasks MUST reference and validate against `.agent-sdd/standards/task-schema.md`.
   - **Pre-Validation**: Before creating tasks.json, file-creator MUST validate each task object against the schema.
   - **Required Task Structure**: For each task:
     - **Required Fields** (MUST be present): 
       - `id`: Format `[FEATURE_NAME]-feature-[N]` (e.g., "hero-section-cta-feature-1")
       - `type`: "feature" (for new functionality)
       - `title`: Short descriptive title from task description
       - `description`: Detailed task implementation details
       - `status`: "pending" (always for new tasks)
       - `priority`: From SDD analysis or default "medium"
       - `created_date`: Current date from `date-checker` agent
       - `ux_ui_reviewed`: false (default for new tasks)
       - `theme_changes`: true for `--ui-only`, false for `--lite`, analyze content for default
     - **Optional Fields** (set if applicable):
       - `target_files`: Array of file paths from Technical Specs
       - `dependencies`: Array of task IDs this task depends on
       - `linked_task`: Original task ID if this is a fix/tweak
       - `acceptance_criteria`: Array from SDD success criteria or Test Scenarios
       - `completed_date`: null (only set when task completed)
   - **Validation Failure**: If schema validation fails, STOP and report specific validation errors.
   - **No Fallback**: Do NOT create tasks outside of tasks.json format.
6. **Schema Validation (MANDATORY)**:
   - **Pre-Creation Check**: Before writing `tasks.json`, validate ALL task objects against `.agent-sdd/standards/task-schema.md`.
   - **Validation Process**: Use `file-creator` agent's built-in schema validation.
   - **Error Handling**: If validation fails:
     - Report specific schema violations (missing required fields, invalid values, etc.)
     - Do NOT create `tasks.json` file
     - Provide corrective guidance to fix schema issues
     - Re-attempt validation after corrections
   - **Success Confirmation**: Only proceed if ALL tasks pass schema validation.
7. **Flag-Specific Handling**:
   - **If `--lite`**: Only include Overview and Tasks, set `theme_changes: false` unless UI changes detected.
   - **If `--ui-only`**: Focus on UI Requirements and Theme Standards, set `theme_changes: true` for ALL tasks.
8. **Integration Checks**:
   - **Roadmap Alignment**: Check alignment with `.agent-sdd/product/roadmap.md`; update `decisions.md` if needed.
   - **Task Dependencies**: Validate any referenced task IDs exist in the project.
9. **User Confirmation**: `"Tasks validated against schema. Proceed with Task 1? (yes/no)"`.

---

## Schema Enforcement Notes
- **MANDATORY JSON Structure**: All tasks MUST be created in `tasks.json` format - no exceptions.
- **Schema Reference**: Always validate against `.agent-sdd/standards/task-schema.md` before file creation.
- **Field Validation**: Ensure all required fields are present and valid before creating tasks.json.
- **Type Safety**: Validate data types (strings, arrays, booleans, null) match schema requirements.
- **ID Format**: Task IDs must follow kebab-case format: `[feature-name]-[type]-[number]`.
- **Vibe Coder Simplification**: Prompt only for feature name and description; apply schema defaults for other fields.

## UI/UX Standards
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