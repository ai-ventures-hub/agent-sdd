# /sdd-execute-task <task-id>
Execute a task:
1. Load task from .agent-sdd/specs/*/tasks.json.
2. Reference .agent-sdd/standards/theme-standards.md for style compliance.
3. Write tests (TDD) if applicable.
4. Implement code, save changes.
5. Prompt user to stage/commit in GitHub Desktop with "[task-id]: [description]".
6. Run task-specific tests (if package.json exists).
7. Run /sdd-review-code on modified files to ensure UX/UI compliance.
8. Update task status to "Done" and set ux_ui_reviewed: true in tasks.json.
9. Notify user with summary: tasks completed, issues, files to commit in GitHub Desktop.
