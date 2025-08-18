# /sdd-queue-fix <task-id> <description>
Queue a fix for later batch processing or create a new fix task.

**IMPORTANT:** This is an Agent-SDD instruction, NOT a bash command.

---

## Purpose
- Track bugs and issues for systematic resolution
- Prioritize fixes based on severity
- Maintain a fix queue for batch processing
- Link fixes to original tasks when applicable

---

## Options
- `--severity` → Set severity level (low, medium, high, critical)
- `--type` → Specify fix type (bug, regression, style, accessibility, performance)
- `--target` → Specify affected file(s) or component(s)
- `--linked-task` → Link to original task that introduced the issue

---

## Workflow
1. **Categorize the fix**:
   - Determine fix type and severity
   - Check if related to existing task

2. **Create or update spec**:
   - Use **date-checker** agent to get current date
   - For new fix: Create `.agent-sdd/specs/queue-fix-[task-id]-[CURRENT-DATE]/`
   - For linked: Update the original task's `tasks.json` with fix reference

3. **Document fix details**:
   ```json
   {
     "id": "[TASK-ID]-fix-[N]",
     "type": "fix",
     "severity": "medium",
     "fix_type": "bug",
     "description": "[description]",
     "reproduction_steps": [],
     "target_files": [],
     "linked_task": "[original-task-id]",
     "status": "pending",
     "created_date": "[CURRENT-DATE]",
     "error_message": "[if applicable]"
   }
   ```

4. **Add to fix queue**:
   - Create/update `.agent-sdd/specs/fixes-queue.json`
   - Sort by severity (critical → high → medium → low)
   - Group related fixes

5. **Estimate effort**:
   - XS: < 30 minutes (typos, simple logic)
   - S: 30-60 minutes (single component fix)
   - M: 1-2 hours (multiple files affected)
   - L: 2-4 hours (architectural changes)

6. **Generate ticket**:
   ```
   🐛 Fix Added: [TASK-ID]-fix-[N]
   ================================
   Severity: [severity]
   Type: [fix_type]
   Target: [files/components]
   Linked to: [original-task-id]
   Queue position: [N]
   
   Run /sdd-fix [TASK-ID]-fix-[N] to implement
   ```

---

## Priority Matrix
| Severity | Type | Priority Score | Action |
|----------|------|---------------|---------|
| Critical | Bug | 10 | Immediate |
| Critical | Accessibility | 9 | Same day |
| High | Bug | 8 | Within 24h |
| High | Performance | 7 | Within 48h |
| Medium | Style | 5 | This week |
| Low | Enhancement | 2 | Next sprint |

---

## Batch Processing
- Run `/sdd-process-fixes` to execute fixes by priority
- Critical fixes processed immediately
- Groups related fixes for efficiency
- Runs full test suite after batch

---

## Examples
```sh
# Queue critical bug fix
/sdd-queue-fix AUTH-001 "Login fails with special characters" --severity critical --type bug

# Queue accessibility fix linked to task
/sdd-queue-fix BTN-012 "Missing aria-label on icon button" --type accessibility --linked-task BTN-012

# Queue performance fix
/sdd-queue-fix LIST-003 "Virtual scrolling needed for large lists" --severity high --type performance

# Queue style fix
/sdd-queue-fix CARD-005 "Dark mode contrast issues" --type style --target "src/components/Card"
```

---

## Integration
- Works with `/sdd-fix` for implementation
- Can be validated with `/sdd-check-task`
- Integrates with CI/CD for automated fix tracking
- Links to error monitoring systems

---

## Notes
- Always include reproduction steps for bugs
- Link to original task when fix is for regression
- Consider creating hotfix branch for critical issues
- Run theme review after style fixes
- Document root cause for future prevention