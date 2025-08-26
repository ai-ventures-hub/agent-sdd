# Agent-SDD Project Instructions for Claude

This project uses the **Agent-SDD (Agent Spec Driven Development)** framework. You MUST follow these instructions when working on this codebase.

## Critical Framework Compliance
When any `/sdd-task` command is invoked, you MUST:

1. **Read the command specification** from `.claude/commands/sdd-task.md` FIRST
2. **Follow the exact workflow** specified in `.claude/commands/workflows/[flag].md`
3. **Invoke ALL required agents** as specified in the workflow
4. **Maintain the 14-field task schema** for all tasks

## Required Agent Invocations
Every Agent-SDD workflow MUST include these agents in the specified order:

### Start of Workflow (MANDATORY):
- **logger.md**: MUST be invoked in READ mode at the beginning of every `/sdd-task` command to establish context awareness

### During Workflow (as specified):
- **date-checker.md**: For setting created_date and completed_date
- **task-schema-validator.md**: For validating tasks.json files
- **context-fetcher.md**: For retrieving existing specifications
- **file-creator.md**: For creating spec directories and files

### End of Workflow (MANDATORY):
- **logger.md**: MUST be invoked in WRITE mode at the end of every `/sdd-task` command to record completion

## Workflow Files Location
All workflows are located in: `.claude/commands/workflows/`
- `/sdd-task --fix` → `workflows/fix.md`
- `/sdd-task --update` → `workflows/update.md`
- `/sdd-task --execute` → `workflows/execute.md`
- `/sdd-task --spec` → `workflows/spec.md`
- `/sdd-task --edit` → `workflows/edit.md`
- etc.

## Command Parsing Rules
For optional parameters like `--fix [<task-id>]` or `--edit [<description>]`:
- **Task-ID Pattern**: `[A-Z]{2,5}-[0-9]{1,4}` (e.g., BTN-012)
- **Description Pattern**: Any other string is treated as a description
- **No Parameter**: Prompts user for details

### Special Command Notes
- **--edit**: Lightweight workflow using only logger agents (read at start, write at end)
- **--fix**: Full workflow with spec creation and extensive validation
- **--update**: Full workflow with theme compliance and testing

## Directory Structure
```
.claude/
├── commands/
│   ├── sdd-task.md          # Main command dispatcher
│   └── workflows/           # Workflow specifications
├── agents/                  # Agent specifications
├── specs/                   # Generated specifications
├── standards/               # Project standards
└── product/                 # Product documentation
```

## Error Prevention
- **NEVER skip agent invocations** specified in workflows
- **ALWAYS follow the exact step sequence** in workflow files
- **ALWAYS validate** using task-schema-validator.md for task operations
- **ALWAYS use** date-checker.md for date fields
- **ALWAYS start and end** with logger.md for context continuity

## Key Principles
1. **Workflow Adherence**: Follow `.claude/commands/workflows/[flag].md` exactly
2. **Agent Integration**: Use specified agents in correct order
3. **Schema Compliance**: Maintain 14-field task schema
4. **Context Awareness**: Always use logger.md for continuity
5. **Standards Alignment**: Follow `.claude/standards/` guidelines

## Task Schema (14 Fields)
Every task in `tasks.json` must include:
1. `id` - Task identifier
2. `type` - Task type (feature, fix, update, etc.)
3. `title` - Brief task title
4. `description` - Detailed description
5. `status` - Current status (pending, in_progress, completed)
6. `priority` - Priority level (critical, high, medium, low)
7. `created_date` - Creation date (YYYY-MM-DD)
8. `ux_ui_reviewed` - Boolean for UX/UI review status
9. `theme_changes` - Boolean indicating theme modifications
10. `completed_date` - Completion date (YYYY-MM-DD or null)
11. `target_files` - Array of files to be modified
12. `dependencies` - Array of dependent task IDs
13. `linked_task` - Parent or related task ID
14. `acceptance_criteria` - Array of completion criteria

## Enforcement
If you deviate from these workflows, you risk breaking the Agent-SDD framework continuity. Always prioritize framework compliance over shortcuts.

When in doubt, refer to:
1. `.claude/commands/sdd-task.md` - Command specifications
2. `.claude/commands/workflows/[flag].md` - Workflow details
3. `.claude/agents/[agent].md` - Agent specifications

**Remember**: This is a structured development framework. Precision and adherence to specifications are critical for success.