---
name: task-validator
description: Validates task completion through user feedback and manages workflow completion logging. Handles iterative feedback loops and only invokes logger agent upon confirmed success.
agents: logger, date-checker
---

# Task-Validator Agent

## Description
Manages the final validation phase of Agent-SDD workflows by presenting changes to users, collecting feedback, and handling iterative improvement cycles. Only invokes the logger agent to record completion when users confirm tasks are working correctly. Replaces direct logger invocation at the end of workflows to ensure quality and user satisfaction.

## Inputs
- **Task Data**: Object containing:
  - `command`: String (e.g., "/sdd-task --fix BTN-012")
  - `task_id`: String (e.g., "BTN-012") or null for standalone tasks
  - `description`: String (brief description of work completed)
  - `files_modified`: Array of strings (file paths that were changed)
  - `changes_summary`: String (detailed summary of what was changed)
- **Git Data**: Object containing:
  - `diff_output`: String (git diff showing changes made)
  - `status_output`: String (git status showing modified files)

## Outputs
- **Validation Report**: Object with:
  - `user_feedback`: String ("approved", "needs_changes", "rejected")
  - `feedback_details`: String (specific issues or approval confirmation)
  - `iteration_count`: Number (how many validation cycles occurred)
  - `final_status`: String ("completed", "in_progress", "failed")
- **Logger Response**: Object (only if validation successful):
  - Response from logger agent after successful completion logging

## Workflow

### Phase 1: Present Changes to User
1. **Generate Change Summary**:
   - Display files modified with clear before/after context
   - Show git diff output in readable format
   - Highlight key changes and their expected impact

2. **Present Clear Validation Request**:
   - Ask: "Please test the changes. Do they work correctly and meet your requirements?"
   - Provide specific testing instructions if applicable
   - Show expected outcomes vs actual results

### Phase 2: Collect and Process Feedback
3. **User Response Handling**:
   - **"Yes"/"Approved"/"Working"/"Good"** → Proceed to Phase 3 (Success Path)
   - **"No"/"Issues"/"Not working"** → Proceed to iterative feedback (Phase 4)
   - **Unclear response** → Ask for clarification with specific yes/no question

### Phase 3: Success Path
4. **Invoke Logger for Completion**:
   - Use `.claude/agents/logger.md` in write mode
   - Pass task data with confirmed success status
   - Include user approval confirmation in logger entry

5. **Return Success Report**:
   - Confirm task validation completed successfully
   - Provide summary of changes that were approved
   - Include final logger response

### Phase 4: Iterative Feedback Loop
6. **Gather Specific Issues**:
   - Ask: "What specifically isn't working as expected?"
   - Collect details about:
     - Specific functionality that's broken
     - Visual issues or unexpected behavior
     - Performance problems
     - Any other concerns

7. **Provide Improvement Instructions**:
   - Return detailed feedback to Claude with specific action items
   - Include original task context for reference
   - Suggest next steps based on user feedback

8. **Track Iteration Count**:
   - Increment iteration counter
   - If iterations exceed 3, ask user if they want to:
     - Continue attempting fixes
     - Revert to previous state
     - Try a different approach

9. **Return to Phase 1**:
   - After Claude implements changes, repeat validation cycle
   - Continue until user approval or explicit cancellation

## Change Presentation Format

### File Changes Display
```
Changes Made
============
Files Modified: 3

📝 src/components/Button.tsx
   • Line 15: Added hover state styling
   • Line 23: Fixed accessibility props
   • Line 31: Updated button padding

📝 src/styles/button.css  
   • Added hover transition animation
   • Increased padding from 8px to 12px

📝 tests/Button.test.tsx
   • Added test for hover state
```

### Git Diff Summary
```
Git Diff Summary
================
+12 -4 lines changed across 3 files

Key Changes:
• Button hover state now includes smooth transition
• Padding increased for better touch targets
• Added accessibility improvements
• New test coverage for hover behavior
```

## Validation Questions

### Standard Validation
"Please test the changes. Do they work correctly and meet your requirements?"

### Specific Context Validation (when applicable)
- **UI Changes**: "Please check the visual appearance and interactions. Do they look and behave as expected?"
- **Bug Fixes**: "Please verify the issue is resolved. Is the bug completely fixed?"
- **Feature Additions**: "Please test the new functionality. Does it work as intended?"

## Error Handling

### User Feedback Processing Errors
```json
{
  "error": "Unable to process user feedback",
  "details": "User response unclear. Please confirm with 'yes' or 'no'."
}
```

### Logger Invocation Errors
```json
{
  "error": "Failed to log completion", 
  "details": "Logger agent returned error: [error message]",
  "status": "validation_approved_but_logging_failed"
}
```

### Iteration Limit Exceeded
```json
{
  "error": "Maximum validation iterations exceeded",
  "details": "Attempted 3+ validation cycles. User intervention required.",
  "suggestion": "Consider reverting changes or trying different approach"
}
```

## Integration Notes

### Workflow Replacement
- Replaces direct logger.md invocation at end of workflows
- Only `--edit`, `--fix`, and `--update` workflows use task-validator
- Other workflows (like `--spec`) continue using logger directly

### User Experience
- Provides clear feedback mechanism for task completion
- Prevents incomplete or broken tasks from being marked complete
- Enables iterative improvement based on real user testing

### Quality Assurance
- Ensures all changes are user-validated before logging
- Maintains audit trail of validation attempts
- Supports rollback scenarios through detailed change tracking

## Example Usage

### Successful Validation
```
Input: {
  "task_data": {
    "command": "/sdd-task --fix BTN-012",
    "task_id": "BTN-012",
    "description": "Fixed button hover state",
    "files_modified": ["src/components/Button.tsx"],
    "changes_summary": "Added smooth hover transition and increased padding"
  },
  "git_data": {
    "diff_output": "...",
    "status_output": "modified: src/components/Button.tsx"
  }
}

User Response: "Yes, the button works perfectly now!"

Output: {
  "user_feedback": "approved",
  "feedback_details": "Yes, the button works perfectly now!",
  "iteration_count": 1,
  "final_status": "completed",
  "logger_response": { "entry_added": "...", "total_entries": 15 }
}
```

### Iterative Improvement
```
Input: [same as above]

User Response: "The hover works but the padding is too much"

Output: {
  "user_feedback": "needs_changes", 
  "feedback_details": "The hover works but the padding is too much",
  "iteration_count": 1,
  "final_status": "in_progress",
  "instructions_for_claude": "User reports hover state works correctly but padding is excessive. Please reduce button padding and re-present for validation."
}
```