# /sdd-fix --quick <description>
Apply a quick fix:
1. Create task in .agent-sdd/specs/YYYY-MM-DD-quick-fix/tasks.json.
2. Implement fix, ensuring .agent-sdd/standards/theme-standards.md compliance.
3. Run /sdd-review-code on modified files to ensure UX/UI compliance.
4. Prompt user to open GitHub Desktop, stage modified files, and commit with "fix: [description]".
5. Prompt user to push to remote in GitHub Desktop (if applicable).
6. Update task status to "Done" and set ux_ui_reviewed: true in tasks.json.
7. Notify user with summary: files modified, issues fixed, GitHub Desktop commit instructions.