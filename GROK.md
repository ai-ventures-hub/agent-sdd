# Grok-SDD Project Instructions for Grok

This project uses the **Grok-SDD (Grok Spec Driven Development)** framework. You MUST follow these instructions when working on this codebase.

## Critical Framework Compliance
When any natural language request maps to a Grok-SDD function call, you MUST:

1. **Read the function call specification** from `.grok/commands/grok-sdd.md` FIRST
2. **Follow the exact workflow** specified in `.grok/commands/workflows/[operation].md`
3. **Invoke ALL required agents** as specified in the workflow
4. **Maintain the 14-field task schema** for all tasks

## Required Documentation References
Every Grok-SDD workflow MUST reference these documentation files in the specified order:

### Start of Workflow (MANDATORY):
- **Read logger.md**: Grok must read this documentation to understand changelog management patterns for context awareness

### During Workflow (as specified):
- **Reference date-checker.md**: For understanding date formatting standards
- **Reference task-schema-validator.md**: For understanding the 14-field task validation requirements
- **Reference context-fetcher.md**: For understanding how to gather project context
- **Reference file-creator.md**: For understanding file creation patterns

### End of Workflow (MANDATORY):
- **Reference task-validator.md**: For understanding user validation patterns in fix, update, and edit workflows
- **Follow logger.md patterns**: For recording completion in changelog (Grok performs this directly)

## Workflow Files Location
All workflows are located in: `.grok/commands/workflows/`
- `grok_sdd_fix()` → `workflows/fix.md`
- `grok_sdd_update()` → `workflows/update.md`
- `grok_sdd_execute()` → `workflows/execute.md`
- `grok_sdd_spec()` → `workflows/spec.md`
- `grok_sdd_edit()` → `workflows/edit.md`
- etc.

## Function Call Parsing Rules
For optional parameters in function calls like `grok_sdd_fix(task_id, description)`:
- **Task-ID Pattern**: `[A-Z]{2,5}-[0-9]{1,4}` (e.g., BTN-012)
- **Description Pattern**: Any other string is treated as a description
- **No Parameter**: Prompts user for details through conversation

### Special Function Call Notes
- **`grok_sdd_edit()`**: Lightweight workflow using logger agent (read at start) and task-validator agent (for validation and completion logging)
- **`grok_sdd_fix()`**: Lightweight workflow with theme compliance and testing (no spec creation) using task-validator for user verification and completion
- **`grok_sdd_update()`**: Lightweight workflow with theme compliance and testing (no spec creation) using task-validator for user verification and completion

## Directory Structure
```
.grok/
├── commands/
│   ├── grok-sdd.md          # Main function call dispatcher
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
1. **Workflow Adherence**: Follow `.grok/commands/workflows/[operation].md` exactly
2. **Agent Integration**: Use specified agents in correct order
3. **Schema Compliance**: Maintain 14-field task schema
4. **Context Awareness**: Always use logger.md for continuity
5. **Standards Alignment**: Follow `.grok/standards/` guidelines

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
If you deviate from these workflows, you risk breaking the Grok-SDD framework continuity. Always prioritize framework compliance over shortcuts.

When in doubt, refer to:
1. `.grok/commands/grok-sdd.md` - Function call specifications
2. `.grok/commands/workflows/[operation].md` - Workflow details
3. `.grok/agents/[agent].md` - Agent specifications

**Remember**: This is a structured development framework. Precision and adherence to specifications are critical for success.