# /sdd-queue-tweak <task-id> <description>
Queue a UI/UX tweak for later batch processing or add to existing task.

**IMPORTANT:** This is an Agent-SDD instruction, NOT a bash command.

---

## Purpose
- Add incremental UI/UX improvements to existing features
- Track small enhancements without full task cycle
- Maintain a queue of tweaks for batch processing

---

## Options
- `--priority` → Set priority level (low, medium, high)
- `--target` → Specify target file(s) or component(s)
- `--theme-only` → Mark as theme/styling tweak only

---

## Workflow
1. **Check if task exists**:
   - Search `.agent-sdd/specs/*/tasks.json` for `<task-id>`
   - If found, add as sub-task
   - If not found, create new tweak task

2. **Create or update spec**:
   - Use **date-checker** agent to get current date
   - For new task: Create `.agent-sdd/specs/queue-tweak-[task-id]-[CURRENT-DATE]/`
   - For existing: Update the existing `tasks.json`

3. **Document tweak**:
   ```json
   {
     "id": "[TASK-ID]-tweak-[N]",
     "type": "tweak",
     "description": "[description]",
     "priority": "medium",
     "target_files": [],
     "theme_changes": true/false,
     "status": "pending",
     "created_date": "[CURRENT-DATE]"
   }
   ```

4. **Add to tweak queue**:
   - Create/update `.agent-sdd/specs/tweaks-queue.json`
   - Sort by priority and date

5. **Estimate effort**:
   - XS: < 30 minutes (padding, margins, colors)
   - S: 30-60 minutes (component styling)
   - M: 1-2 hours (multiple components)

6. **Generate summary**:
   ```
   ✅ Tweak added: [TASK-ID]-tweak-[N]
   Priority: [priority]
   Target: [files/components]
   Queue position: [N]
   
   Run /sdd-tweak [TASK-ID]-tweak-[N] to implement
   ```

---

## Batch Processing
- Run `/sdd-process-tweaks` to execute all pending tweaks
- Groups similar tweaks for efficiency
- Applies theme review once at the end

---

## Examples
```sh
# Queue tweak to existing task
/sdd-queue-tweak BTN-012 "Increase hover state contrast"

# Queue new tweak task with priority
/sdd-queue-tweak NAV-001 "Add smooth transitions to menu" --priority high

# Queue theme-only tweak
/sdd-queue-tweak THEME-001 "Update card shadows for depth" --theme-only
```

---

## Integration
- Works with `/sdd-tweak` for implementation
- Can be reviewed with `/sdd-check-task`
- Supports bulk operations for efficiency

---

## Notes
- Tweaks should be small, focused changes
- For larger changes, use `/sdd-create-spec`
- Always maintain Theme Standards compliance
- Group related tweaks when possible