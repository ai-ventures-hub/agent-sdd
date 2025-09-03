# Grok-SDD Update Guide

## Purpose
Guides customization of files in `.grok/` and updates to align with function call workflows and agents like `.grok/agents/task-schema-validator.md`.

## Files to Customize
### Standards (`.grok/standards/`)
- **tech-stack.md**: Update with your tools, frameworks, and versions (e.g., "React 18.2.0").
- **theme-standards.md**: Update with your design tokens, colors, and component styles.

### Product (`.grok/product/`)
- **overview.md**: Update with your mission, target users, and goals.
- **roadmap.md**: Update with your phases, tasks, and milestones.
- **decisions.md**: Document your technical, process, and product decisions.

## Files to Leave as Default
### Standards
- **best-practices.md**: Keep default unless workflow changes are needed.

### System Files
- **commands/workflows/*.md**: Keep default unless custom workflows are required.
- **agents/*.md**: Keep default unless agent behavior changes are needed.
- **agents/task-schema-validator.md**: Never modify; ensures 14-field task schema compliance.
- **agents/task-validator.md**: Keep default; manages user validation and completion logging for code changes.

## Initial Setup Checklist
1. Create `.grok/` directory structure manually or use template.
2. Update `tech-stack.md` and `theme-standards.md` with your stack and design system.
3. Update `overview.md` and `roadmap.md` with project details.
4. For existing roadmaps, say "Create spec for next task".
5. For new features, say "Create a spec for [feature]".
6. For quick fixes, say "Update [component]".

## Keeping Updated
- **Update Operation**: Say "Update [component]" to apply tweaks or fixes.
- Preserves customs in `standards/tech-stack.md`, `standards/theme-standards.md`, `product/overview.md`, `product/roadmap.md`, `product/decisions.md`, and `specs/`.
- Ensures schema validation via `.grok/agents/task-schema-validator.md`.

## Function Call Reference
All operations use natural language requests that map to function calls:
- `grok_sdd_roadmap()`: Plan roadmap and milestones.
- `grok_sdd_next()`: Create spec for next roadmap task.
- `grok_sdd_spec(feature, description)`: Create SDD (lightweight or UI-focused) for feature name.
- `grok_sdd_execute(task_id)`: Execute task end-to-end with tests and style fixes.
- `grok_sdd_update(target_file)`: Apply UI/UX enhancements or improvements with tests and style fixes (requires user verification).
- `grok_sdd_fix(task_id, description)`: Apply bug fixes and corrections with optional task context (requires user verification).
- `grok_sdd_edit(description)`: Apply simple, lightweight edits without full spec overhead (requires user verification).
- `grok_sdd_review(paths)`: Review code for theme compliance for modified paths.
- `grok_sdd_analyze(paths)`: Analyze project for issues and improvements.
- `grok_sdd_check(task_id)`: Verify task completion for task ID.

## Pro Tips
- Conversational interface detects `.grok/` for workflow execution and context awareness.
- Schema compliance enforced by `.grok/agents/task-schema-validator.md`.
- Logger system automatically tracks all changes in `.grok/changelog.md` for context awareness.
- Task-validator agent ensures code changes are user-approved before completion logging.
- Theme standards in `theme-standards.md` persist across updates.
- For existing projects, "Create spec for next task" is the best start.
- Use "fix" for bug fixes, "update" for enhancements, and "edit" for simple changes to distinguish task types.
- Note: fix, update, and edit use task-validator agent for user verification and iterative improvement cycles.

## Preventing Duplicate Directories
Agents search upward from the current directory to find existing `.grok/`, preventing duplicates.