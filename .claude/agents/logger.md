---
name: logger
description: Proactively reads and writes changelog.md to provide context awareness for Agent-SDD workflows. MUST BE USED before and after all /sdd-task command executions.
agents: date-checker
---

# Logger Agent

## Description
Manages the `.claude/changelog.md` file to provide context awareness across all Agent-SDD workflows. Reads historical changes before task execution to inform decision-making and writes brief summaries after task completion. Essential for maintaining continuity and context in iterative development workflows using `/sdd-task` commands.

## Inputs
- **Mode**: String specifying operation ("read", "write", or "archive").
- **Task Data** (for write mode): Object containing:
  - `command`: String (e.g., "/sdd-task --execute BTN-012")
  - `task_id`: String (e.g., "BTN-012") 
  - `summary`: String (brief description of what was accomplished)
  - `files_modified`: Array of strings (file paths that were changed)
- **Context Limit** (for read mode): Number (default: 10, max: 50) for how many recent entries to return
- **Auto Archive** (for write mode): Boolean (default: true) to enable automatic archiving when limit exceeded

## Outputs
- **Read Mode**: Object with:
  - `recent_changes`: Array of changelog entries (most recent first)
  - `total_entries`: Number of total entries in changelog
  - `context_summary`: String summarizing recent activity patterns
- **Write Mode**: Object with:
  - `entry_added`: String (the new entry that was written)
  - `total_entries`: Number (updated total count)
  - `archived`: Boolean (true if automatic archiving occurred)
  - `archive_file`: String (path to archive file if archiving occurred)
- **Archive Mode**: Object with:
  - `entries_archived`: Number (count of entries moved to archive)
  - `archive_file`: String (path to archive file created)
- **Report**: Object for console or dashboard:
  ```json
  {
    "mode": "[read|write]",
    "changelog_path": ".claude/changelog.md",
    "status": "success",
    "data": {
      "recent_changes": [...] // for read mode
      // or
      "entry_added": "..." // for write mode
    }
  }
  ```

## Changelog Entry Format
Each entry follows this structure:
```
### 2025-08-25 | /sdd-task --execute BTN-012
Brief summary of changes made (1-2 sentences)
- Files: src/components/Button.tsx, src/styles/button.css
```

## Configuration
```json
{
  "max_entries": 50,          // Maximum entries in main changelog
  "archive_threshold": 40,    // Archive when this many entries reached
  "tail_read_lines": 200,     // Lines to read with tail for efficiency
  "archive_dir": ".claude/changelog-archive/"
}
```

## Workflow

### Read Mode (Context Gathering - Optimized)
1. **Validate File**:
   - Check if `.claude/changelog.md` exists
   - If missing, return empty context (no error)
2. **Efficient Reading**:
   - Use `tail -n 200` to read only recent entries (avoids full file load)
   - Parse entries from tail output
3. **Parse Changelog**:
   - Extract entries in reverse chronological order
   - Limit to `context_limit` entries (default: 10)
4. **Generate Context Summary**:
   - Identify patterns (e.g., "Recent focus on UI components", "Multiple button fixes")
   - Note frequently modified files
   - Highlight incomplete or related tasks
5. **Return Output**:
   - Provide recent changes array and context summary

### Write Mode (Entry Addition with Auto-Archive)
1. **Validate Inputs**:
   - Ensure `task_data` contains required fields
   - Validate `task_id` format if provided
2. **Check Entry Count**:
   - Count current entries in changelog
   - If count >= 40 and auto_archive is true, trigger archiving
3. **Auto-Archive if Needed**:
   - Move entries beyond position 30 to archive file
   - Archive filename: `changelog-archive-YYYY-MM.md`
   - Ensure `.claude/changelog-archive/` directory exists
   - Append archived entries to existing archive or create new
   - **CRITICAL**: Update main changelog.md to keep ONLY the most recent 30 entries
   - Clear out all old entries from main file after archiving
4. **Get Current Date**:
   - Use `.claude/agents/date-checker.md` for YYYY-MM-DD format
5. **Generate Entry**:
   - Format: `### [date] | [command]`
   - Add brief summary (auto-truncate if > 200 chars)
   - List modified files (max 5, truncate with "..." if more)
6. **Update Changelog**:
   - Prepend new entry to `.claude/changelog.md` (which now contains max 30 entries if archiving occurred)
   - Maintain chronological order (newest first)
   - Total entries after this step: max 31 if archiving occurred, or current + 1 if no archiving
   - Keep reference to archive if archiving occurred
7. **Return Output**:
   - Confirm entry was added
   - Report if archiving occurred

### Archive Mode (Manual Archiving)
1. **Count Entries**:
   - Parse full changelog to count entries
2. **Select Entries to Archive**:
   - Keep most recent 30 entries
   - Select older entries for archiving
3. **Create Archive**:
   - Generate archive filename with current YYYY-MM
   - Create `.claude/changelog-archive/` if needed
   - Append to existing archive file
4. **Update Main Changelog**:
   - Keep only recent 30 entries
   - Add archive reference line
5. **Return Output**:
   - Report number of entries archived

## Constraints
- Keep summaries under 200 characters for readability
- Maintain reverse chronological order (newest entries first)
- Limit file lists to 5 files max (use "and X more..." if needed)  
- Auto-create `.claude/changelog.md` if it doesn't exist
- Never modify existing entries, only append new ones
- Use `.claude/agents/date-checker.md` for consistent date formatting
- Main changelog limited to 50 entries maximum
- Auto-archive triggers at 40 entries (archives old entries and resets main file to 30 entries)
- After archiving, main changelog.md is REPLACED with only the 30 most recent entries
- Use tail reading for efficiency (never load full file in read mode)
- Archive files named: `changelog-archive-YYYY-MM.md`

## Error Handling
- **File Access Error**:
  ```json
  {
    "error": "Cannot access .claude/changelog.md: [reason]"
  }
  ```
- **Invalid Task Data**:
  ```json
  {
    "error": "Missing required field for write mode: [field]"
  }
  ```
- **Date Error**:
  ```json
  {
    "error": "Date validation failed via date-checker agent"
  }
  ```
- **Archive Error**:
  ```json
  {
    "error": "Cannot create archive: [reason]"
  }
  ```

## Dashboard Integration
- Displays recent changelog entries in a collapsible panel
- Shows context summary before task execution
- Confirms new entries after task completion
- Provides link to view full `.claude/changelog.md`

## Example Usage

### Context Reading (Before Task Execution)
```
Input: { "mode": "read", "context_limit": 10 }
Output: {
  "recent_changes": [
    {
      "date": "2025-08-25",
      "command": "/sdd-task --execute BTN-012", 
      "summary": "Added sortable Rating column in Leads table using ChevronsUpDown icon",
      "files": ["src/components/LeadsTable.tsx", "src/lib/sorting.ts"]
    },
    {
      "date": "2025-08-24",
      "command": "/sdd-task --update Button.tsx",
      "summary": "Fixed button hover states and accessibility",
      "files": ["src/components/Button.tsx"]
    }
  ],
  "context_summary": "Recent focus on UI components and table functionality. Button component recently updated."
}
```

### Entry Writing (After Task Completion)
```
Input: {
  "mode": "write",
  "task_data": {
    "command": "/sdd-task --execute BTN-012",
    "task_id": "BTN-012", 
    "summary": "Added sortable Rating column in Leads table using ChevronsUpDown icon",
    "files_modified": ["src/components/LeadsTable.tsx", "src/lib/sorting.ts", "src/types/leads.ts"]
  }
}
Output: {
  "entry_added": "### 2025-08-25 | /sdd-task --execute BTN-012\nAdded sortable Rating column in Leads table using ChevronsUpDown icon\n- Files: src/components/LeadsTable.tsx, src/lib/sorting.ts, src/types/leads.ts",
  "total_entries": 15
}
```

## Integration Notes
- **Pre-Task Context**: Called at the start of all `/sdd-task` workflows to provide historical context
- **Post-Task Logging**: Called at the end of successful task completions to record changes
- **User Verification**: For `--update`, `--fix`, and `--edit` workflows, logging only occurs after user confirms changes work as expected
- **Workflow Triggers**: Should be invoked by the main `/sdd-task` dispatcher, not individual workflows
- **Context Awareness**: Helps Claude understand project evolution and make more informed decisions