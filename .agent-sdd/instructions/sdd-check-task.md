# /sdd-check-task <task-id>
Verify if a task was executed and documented properly.

**IMPORTANT:** This is an Agent-SDD instruction, NOT a bash command.

---

## Purpose
- Verify task completion status and quality
- Check documentation completeness
- Validate theme compliance
- Ensure proper spec folder structure

---

## Workflow
1. **Locate task spec**:
   - Search in `.agent-sdd/specs/*/tasks.json` for the given `<task-id>`
   - If not found, report "Task not found"

2. **Check spec folder structure**:
   - Verify folder follows naming convention: `<action>-<task-id>-[date]`
   - Check for presence of `sdd.md` and `tasks.json`

3. **Verify task status**:
   - Check `status` field in `tasks.json` (should be "completed")
   - Verify `ux_ui_reviewed` flag is set to `true`
   - Check `completed_date` if present

4. **Review implementation**:
   - Check if referenced files in task exist
   - Verify modifications match task description
   - Look for `.bak` backup files if applicable

5. **Check documentation**:
   - Verify `sdd.md` contains:
     - Overview with goal and success criteria
     - Technical specs with implementation details
     - Test scenarios (unless `--no-tests` was used)
     - Theme Standards compliance notes

6. **Validate theme compliance**:
   - Check if modified files follow Theme Standards
   - Look for theme review results
   - Verify dark mode variants where needed

7. **Check commit history**:
   - Look for commits with task ID in message
   - Format should match: `feat|fix|tweak(scope): message (TASK-ID)`

8. **Generate report**:
   ```
   Task Check Report: [TASK-ID]
   ================================
   ✅ Spec folder found: [path]
   ✅ Task status: completed
   ✅ UX/UI reviewed: true
   ✅ Documentation complete
   ⚠️  Theme compliance: [status]
   ✅ Commit found: [hash]
   
   Overall: PASSED | NEEDS ATTENTION
   ```

---

## Output Examples

### Successful check:
```
✅ Task BTN-012 Check Complete
- Spec: .agent-sdd/specs/execute-task-BTN-012-2024-01-15/
- Status: completed (2024-01-15)
- Files modified: 3
- Theme compliant: Yes
- Tests: Passed
- Commit: feat(Button): add disabled state (BTN-012)
```

### Issues found:
```
⚠️ Task CARD-005 Needs Attention
- Spec: .agent-sdd/specs/create-spec-CARD-005-2024-01-14/
- Status: in_progress
- Missing: UX/UI review
- Theme issues: 2 non-compliant classes found
- Tests: Not run
- Action: Run /sdd-review-code with --fix
```

---

## Integration
- Can be run after any `/sdd-execute-task`, `/sdd-fix`, or `/sdd-tweak`
- Useful for CI/CD pipelines to validate task completion
- Helps maintain quality standards across the project

---

## Example
```sh
# Check a specific task
/sdd-check-task BTN-012

# Check latest task (if tracking system available)
/sdd-check-task LATEST
```