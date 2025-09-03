# Grok-SDD: Grok-First Structured Software Development

A streamlined system for structured software development with Grok, using a `.grok/` folder for specs, standards, tasks, and agents. Optimized for natural language conversations and function call execution.

## Features
- **Natural Language Interface**: Conversational requests mapped to function calls for all operations.
- **Function Calls**: grok_sdd_roadmap(), grok_sdd_spec(), grok_sdd_execute(), etc. for structured development.
- **Context Awareness**: Grok tracks all changes in `.grok/changelog.md` for informed decisions.
- **Theme Standards**: Defined in `.grok/standards/theme-standards.md` for consistent design.
- **Structured Guidance**: `.grok/agents/` documentation provides patterns for validation, context gathering, file creation, date handling, testing, code review, task validation, and logging.
- **Quality Assurance**: Grok follows documentation patterns for accessibility, responsive design, dark mode, and theme compliance.
- **Conversational Workflow**: Context-aware development through natural language with structured underlying patterns.
- **Task Schema**: 14-field validation patterns in tasks.json following documented schema requirements.

## Installation
Create the `.grok/` directory structure manually or use the template. The framework works through natural language conversations with Grok.

## Usage
### Getting Started
1. Create `.grok/` directory structure.
2. Update `.grok/standards/tech-stack.md` and `theme-standards.md`.
3. Update `.grok/product/overview.md` and `roadmap.md`.
4. Say "Plan the product roadmap" to create milestones.
5. Say "Create spec for next task" to generate specifications.
6. Say "Create a spec for user login" to create new SDDs (Grok will prompt for UI focus).
7. Say "Execute task T123" or "Update button component" for implementation with tests and theme compliance.

### Natural Language Commands
Grok-SDD supports natural language requests that map to function calls:
```
"Plan the roadmap" → grok_sdd_roadmap()
"Create spec for next task" → grok_sdd_next()
"Create a spec for user login" → grok_sdd_spec(feature, description)
"Execute task T123" → grok_sdd_execute(task_id)
"Update button component" → grok_sdd_update(target_file)
```
See `.grok/commands/grok-sdd.md` for details.

### Function Call Reference
- `grok_sdd_roadmap()`: Plan roadmap and milestones.
- `grok_sdd_next()`: Create spec for next roadmap task.
- `grok_sdd_spec(feature, description)`: Create SDD for feature name and description.
- `grok_sdd_execute(task_id)`: Execute task with tests and theme compliance.
- `grok_sdd_update(target_file)`: Apply enhancements/improvements with tests and theme compliance (requires user verification).
- `grok_sdd_fix(task_id, description)`: Apply bug fixes and corrections with optional task context (requires user verification).
- `grok_sdd_edit(description)`: Apply simple, lightweight edits without full spec overhead (requires user verification).
- `grok_sdd_review(paths)`: Review for theme compliance for modified paths.
- `grok_sdd_analyze(paths)`: Analyze project for issues.
- `grok_sdd_check(task_id)`: Verify task completion for task ID.

### Natural Language Examples
Grok-SDD supports conversational requests:
- "Plan the roadmap" → `grok_sdd_roadmap()`
- "Create spec for next task" → `grok_sdd_next()`
- "Create a spec for user login" → `grok_sdd_spec("User Login", "Create responsive login form with validation")`
- "Execute task T123" → `grok_sdd_execute("T123")`
- "Update button component" → `grok_sdd_update("src/components/Button.tsx")`
- "Fix login bug" → `grok_sdd_fix("LOGIN-001", "Fix validation error")`
- "Fix typo in welcome message" → `grok_sdd_edit("Change 'welcom' to 'welcome'")`
- "Review code" → `grok_sdd_review(["src/components/"])`
- "Analyze project" → `grok_sdd_analyze([])`
- "Check task completion" → `grok_sdd_check("T123")`

## Theme Standards
Single source: `.grok/standards/theme-standards.md`.
Enforced by code-reviewer during execute, update, and review operations.

## Testing
- Say "Plan the roadmap" to update product docs.
- Say "Create spec for next task" to generate specs.
- Say "Create spec for user login" to create SDDs and tasks.json (validated by task-schema-validator).
- Say "Execute task T123", "Update button component", or "Fix login bug" for implementation with tests (via test-runner) and theme compliance (via code-reviewer).
- Say "Fix typo in welcome message" for simple changes without full spec overhead (only logger agents).
- Note: update, fix, and edit require user verification before completion logging.
- Say "Review the recent changes" for compliance checks.
- Say "Analyze the project" for project issues.
- Say "Check if task T123 is completed" for task verification.
- Test-runner requires package.json with Jest (or other testing framework).
- Logger system automatically tracks all changes in `.grok/changelog.md`.

## Directory Structure
```
.grok/
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
├── commands/            # Function call dispatcher and workflows
│   ├── grok-sdd.md
│   └── workflows/       # Workflow files (roadmap.md, spec.md, fix.md, etc.)
├── agents/              # Documentation patterns (task-schema-validator.md, logger.md, etc.)
├── docs/                # Documentation (dependency-flow.md, update-guide.md)
├── changelog.md         # Automatic change tracking for context awareness
├── update-guide.md      # Customization guide
└── output-styles/       # Response formatting styles
src/                     # Application code
```

## Contributing
Fork the repo, create feature branch, commit with "feat(scope): message (TASK-ID)", push, open PR.

## License
MIT