# /sdd-execute-task <task-id> [--no-tests] [--quick | --no-spec]
Execute a task:
1. Detect mode:
   - --no-spec: Skip spec loading (sdd.md, product docs), prompt user for task details if task-id not found, create task in .agent-sdd/specs/YYYY-MM-DD-ad-hoc/tasks.json.
   - --quick: Load only .agent-sdd/specs/*/tasks.json and sdd.md, skip roadmap check.
   - default: Load .agent-sdd/specs/*/tasks.json, sdd.md, .agent-sdd/product/*.
2. Identify task:
   - For default/--quick: Use task-id from .agent-sdd/specs/*/tasks.json; error if not found.
   - For --no-spec: Use task-id if in .agent-sdd/specs/*/tasks.json, else prompt user and create in .agent-sdd/specs/YYYY-MM-DD-ad-hoc/tasks.json.
3. If --no-tests and package.json exists, skip test writing; else, write TDD tests for critical components (per .agent-sdd/standards/best-practices.md).
4. Prompt user to confirm target file paths (e.g., components/FileWatcher/FileWatcher.tsx for UI tasks) before implementing code.
5. Implement code and save changes to confirmed paths, ensuring WCAG 2.1 AA compliance.
6. Prompt for commit:
   - default: Always prompt to open GitHub Desktop, stage files, and commit with "[task-id]: [description]" (e.g., "feat: Implement file monitoring (FSI-001)").
   - --quick/--no-spec: Prompt only if user confirms commit (e.g., "Commit changes? [yes/no]").
7. Prompt user to push to remote in GitHub Desktop (skip for --quick/--no-spec unless confirmed).
8. If --no-tests or --quick/--no-spec, run only task-specific tests (if package.json exists); else, run full test suite.
9. Run /sdd-review-code on modified files to ensure UX/UI compliance (per theme-standards.md).
10. Update task status to "Done" and set ux_ui_reviewed: true in .agent-sdd/specs/*/tasks.json.
11. Notify user with summary: tasks completed, issues, test results, files to commit in GitHub Desktop.