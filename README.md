# Agent-SDD: Claude-First Structured Software Development

A streamlined system for structured software development in Claude Code, using a `.claude/` folder for specs, standards, tasks, and agents. Integrated with the Agent-SDD Dashboard at claude.agent-sdd.com for visual workflow management.

## Features
- **Single Command**: `/sdd-task` with 9 flags for all operations.
- **Flags**: --roadmap, --next, --spec, --execute, --update, --fix, --review, --analyze, --check.
- **Context Awareness**: Logger system tracks all changes in `.claude/changelog.md` for informed decisions.
- **Theme Standards**: Defined in `.claude/standards/theme-standards.md` for consistent design.
- **Agents**: `.claude/agents/` with task-schema-validator, context-fetcher, file-creator, date-checker, test-runner, code-reviewer, git-workflow, logger.
- **UX/UI Enforcement**: Automatic reviews for accessibility, responsive design, dark mode, and theme compliance via code-reviewer.
- **Dashboard Integration**: Flag selector, prompts (e.g., UI focus for --spec), and task visualization.
- **Task Schema**: 14-field validation for tasks.json via task-schema-validator.

## Installation
Use the Agent-SDD Dashboard wizard to create `.claude/`, or clone `ai-ventures-hub/agent-sdd-template` and customize.

## Usage
### Getting Started
1. Create `.claude/` via dashboard or template.
2. Update `.claude/standards/tech-stack.md` and `theme-standards.md`.
3. Update `.claude/product/overview.md` and `roadmap.md`.
4. Use `/sdd-task --roadmap` to plan milestones.
5. Use `/sdd-task --next` for next spec.
6. Use `/sdd-task --spec <feature>` for new SDDs (dashboard prompts for UI focus).
7. Use `/sdd-task --execute <task-id>` or `--update <target>` for implementation with tests and theme compliance.

### Command Syntax
```
/sdd-task --<flag> [arguments]
```
See `.claude/commands/sdd-task.md` for details.

### Flag Reference
- --roadmap: Plan roadmap and milestones.
- --next: Create spec for next roadmap task.
- --spec: Create SDD for feature name.
- --execute: Execute task with tests and theme compliance for task ID.
- --update: Apply enhancements/improvements with tests and theme compliance for target file.
- --fix: Apply bug fixes and corrections with optional task context.
- --review: Review for theme compliance for modified paths.
- --analyze: Analyze project for issues.
- --check: Verify task completion for task ID.

### Natural Language Commands
Claude Code supports natural language:
- "Plan the roadmap" → /sdd-task --roadmap
- "Create spec for next task" → /sdd-task --next
- "Create a spec for user login" → /sdd-task --spec
- "Execute task T123" → /sdd-task --execute
- "Update button component" → /sdd-task --update
- "Fix login bug" → /sdd-task --fix
- "Review code" → /sdd-task --review
- "Analyze project" → /sdd-task --analyze
- "Check task completion" → /sdd-task --check

## Theme Standards
Single source: `.claude/standards/theme-standards.md`.
Enforced by code-reviewer during --execute, --update, and --review.

## Testing
- Use /sdd-task --roadmap to update product docs.
- Use /sdd-task --next to generate specs.
- Use /sdd-task --spec to create SDDs and tasks.json (validated by task-schema-validator).
- Use /sdd-task --execute, --update, or --fix for implementation with tests (via test-runner) and theme compliance (via code-reviewer).
- Use /sdd-task --review for compliance checks.
- Use /sdd-task --analyze for project issues.
- Use /sdd-task --check for task verification.
- Test-runner requires package.json with Jest (or other testing framework).
- Logger system automatically tracks all changes in `.claude/changelog.md`.

## Directory Structure
```
.claude/
├── standards/           # Tech stack, theme, best practices
│   ├── tech-stack.md
│   ├── theme-standards.md
│   └── best-practices.md
├── product/             # Product docs
│   ├── overview.md
│   ├── roadmap.md
│   └── decisions.md
├── specs/               # SDDs and tasks.json
│   └── [feature-name]_[type]_[date]/
│       ├── spec.md
│       └── tasks.json
├── commands/            # Command dispatcher and workflows
│   ├── sdd-task.md
│   └── workflows/       # Workflow files (roadmap.md, spec.md, fix.md, etc.)
├── agents/              # Sub-agents (task-schema-validator.md, logger.md, etc.)
├── docs/                # Documentation (dependency-flow.md, update-guide.md)
├── changelog.md         # Automatic change tracking for context awareness
└── update-guide.md      # Customization guide
src/                     # Application code
```

## Contributing
Fork the repo, create feature branch, commit with "feat(scope): message (TASK-ID)", push, open PR.

## License
MIT