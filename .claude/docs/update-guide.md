# Agent-SDD Update Guide

## Purpose
Guides customization of files in `.claude/` and updates to align with `/sdd-task` workflows and agents like `.claude/agents/task-schema-validator.md`.

## Files to Customize
### Standards (`.claude/standards/`)
- **tech-stack.md**: Update with your tools, frameworks, and versions (e.g., "React 18.2.0").
- **theme-standards.md**: Update with your design tokens, colors, and component styles.

### Product (`.claude/product/`)
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

## Initial Setup Checklist
1. Use Agent-SDD Dashboard wizard or clone `ai-ventures-hub/agent-sdd-template` to create `.claude/`.
2. Update `tech-stack.md` and `theme-standards.md` with your stack and design system.
3. Update `overview.md` and `roadmap.md` with project details.
4. For existing roadmaps, start with `/sdd-task --next`.
5. For new features, use `/sdd-task --spec`.
6. For quick fixes, use `/sdd-task --update`.

## Keeping Updated
- **Update Command**: Use `/sdd-task --update` to apply tweaks or fixes.
- Preserves customs in `standards/tech-stack.md`, `standards/theme-standards.md`, `product/overview.md`, `product/roadmap.md`, `product/decisions.md`, and `specs/`.
- Ensures schema validation via `.claude/agents/task-schema-validator.md`.

## Command Reference
All operations use `/sdd-task` with flags:
- `--roadmap`: Plan roadmap and milestones.
- `--next`: Create spec for next roadmap task.
- `--spec`: Create SDD (lightweight or UI-focused) for feature name.
- `--execute`: Execute task end-to-end with tests and style fixes for task ID.
- `--update`: Apply UI/UX enhancements or improvements with tests and style fixes for target file.
- `--fix`: Apply bug fixes and corrections with optional task context.
- `--edit`: Apply simple, lightweight edits (typos, formatting) without full spec overhead.
- `--review`: Review code for theme compliance for modified paths.
- `--analyze`: Analyze project for issues and improvements.
- `--check`: Verify task completion for task ID.

## Pro Tips
- Dashboard detects `.claude/` for flag selection and task visualization.
- Schema compliance enforced by `.claude/agents/task-schema-validator.md`.
- Logger system automatically tracks all changes in `.claude/changelog.md` for context awareness.
- Theme standards in `theme-standards.md` persist across updates.
- For existing projects, `/sdd-task --next` is the best start.
- Use `--fix` for bug fixes, `--update` for enhancements, and `--edit` for simple changes to distinguish task types.

## Preventing Duplicate Directories
Agents search upward from the current directory to find existing `.claude/`, preventing duplicates.