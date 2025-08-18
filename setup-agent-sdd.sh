#!/bin/bash

# Agent-SDD Setup Script
# Initializes project-specific .agent-sdd/ folder for Claude Code

set -e

# Prevent accidental overwrite of existing configuration
if [ -d ".agent-sdd" ]; then
  read -r -p "⚠️  .agent-sdd already exists. Overwrite? This will replace all files. (y/N): " CONFIRM
  if [[ ! "$CONFIRM" =~ ^[Yy]$ ]]; then
    echo "❌ Setup aborted to avoid overwriting existing configuration."
    exit 1
  fi
fi

echo "🚀 Agent-SDD Setup Script"
echo "========================"
echo ""

# Create directories
echo "📁 Creating directories..."
mkdir -p .agent-sdd/standards .agent-sdd/product .agent-sdd/specs .agent-sdd/instructions .agent-sdd/agents

# Standards files (placeholder; update to match project stack after theme integration)
echo "📥 Creating standards files..."

# Create the unified task schema file
cat << 'EOF' > .agent-sdd/standards/task-schema.md
# Task Schema
This schema defines the structure of task objects in the `tasks` array of `tasks.json` files for Agent-SDD workflows. It ensures consistency across commands (`/sdd-create-spec`, `/sdd-tweak`, `/sdd-fix`, `/sdd-execute-task`, `/sdd-queue-fix`, `/sdd-queue-tweak`, `/sdd-vibe-task`) and supports vibe coders with minimal input requirements. The desktop app uses this schema to visualize task progress, status, and theme compliance.

Tasks are validated against this schema definition by the `file-creator` agent.

## Schema
```json
{
  "id": "[TASK-ID]-[type]-[N]",
  "type": "feature|fix|tweak",
  "title": "[Short title]",
  "description": "[Detailed description]",
  "status": "pending|in_progress|completed",
  "priority": "low|medium|high|critical",
  "created_date": "[CURRENT-DATE]",
  "completed_date": "[COMPLETION-DATE]",
  "target_files": ["[file-paths]"],
  "dependencies": ["[task-ids]"],
  "linked_task": "[original-task-id]",
  "acceptance_criteria": ["[criteria]"],
  "ux_ui_reviewed": true/false,
  "theme_changes": true/false,
  "theme_name": "[theme-name]"
}
```

## Required Fields
- **`id`**: Unique identifier for the task (e.g., "BTN-012-fix-1", "TDC-002-feature-1"). Format: kebab-case `[TASK-ID]-[type]-[N]`.
- **`type`**: Task type: `"feature"` (new functionality), `"fix"` (bug or issue resolution), or `"tweak"` (UI/UX adjustment).
- **`title`**: Short, descriptive title (e.g., "Add new button style").
- **`description`**: Detailed task description, including any relevant details or reproduction steps for fixes.
- **`status`**: Task progress: `"pending"` (not started), `"in_progress"` (active), or `"completed"` (finished). Default: `"pending"`.
- **`priority`**: Priority level: `"low"`, `"medium"`, `"high"`, or `"critical"`. Default: `"medium"`.
- **`created_date`**: Creation date from `date-checker` agent (e.g., "2025-08-18").
- **`ux_ui_reviewed`**: Indicates if UX/UI review is complete. Default: `false`.
- **`theme_changes`**: Indicates if the task involves theme or style changes (triggers `/sdd-review-code`). Default: `false`.

## Optional Fields
- **`completed_date`**: Completion date, set by `/sdd-execute-task` when `status` is `"completed"` (e.g., "2025-08-18"). Default: `null`.
- **`target_files`**: Array of file paths modified or targeted (e.g., `["src/components/Button/Button.tsx"]`). Default: `[]`.
- **`dependencies`**: Array of dependent task IDs (e.g., `["BTN-011"]`). Default: `[]`.
- **`linked_task`**: Original task ID for fixes or tweaks (e.g., "BTN-012"). Default: `null`.
- **`acceptance_criteria`**: Array of success criteria and testing instructions (e.g., `["Button displays correctly", "Meets WCAG 2.1 AA"]`). Default: `[]`.
- **`theme_name`**: Active theme for UI tasks (e.g., "minimal"), auto-populated by `file-creator` if `theme_changes: true`. Default: `null`.

## Notes
- **Vibe Coders**: Only `title` and `description` are typically prompted; other fields use defaults or are auto-populated (e.g., `theme_name` from `.agent-sdd/standards/theme-files/`).
- **Desktop App**: Use `status`, `priority`, `theme_changes`, and `theme_name` for visual progress display (e.g., status indicators, priority color-coding).
- **Validation**: The `file-creator` agent validates tasks against this schema definition to ensure required fields are present and valid.
EOF
cat << 'EOF' > .agent-sdd/standards/tech-stack.md
# Tech Stack
# ✅ Update this file with your project’s specific tools and versions after integrating a theme via /sdd-apply-theme
- Frontend: React (update version), TypeScript (update version)
- Backend: None (standalone components)
- Styling: Tailwind CSS (update version), shadcn/ui (update version)
- Testing: Jest (optional, requires setup; update if using another framework)
EOF

cat << 'EOF' > .agent-sdd/standards/code-style.md
# Code Style
# ❌ Leave as default unless your team requires different naming or formatting conventions
- Naming: camelCase for variables, PascalCase for components
- Formatting: 2-space indentation, Prettier enforced
- Comments: JSDoc for functions, inline for clarity
EOF

cat << 'EOF' > .agent-sdd/standards/best-practices.md
# Best Practices
# ❌ Retain default practices unless your workflow demands changes
- Keep code simple and readable
- DRY: Extract repeated logic to components/utils
- Use TDD for critical components
- Commit messages: "[type]: [description] (task-id)"
- Accessibility: WCAG 2.1 AA compliance
EOF

cat << 'EOF' > .agent-sdd/standards/theme-standards.md
# Theme Standards
# ✅ Customize this file with theme-specific standards after running /sdd-apply-theme
EOF

# Product files
echo "📥 Creating product files..."
cat << 'EOF' > .agent-sdd/product/overview.md
# Product Overview
- Mission: Simplify component creation
- Target Users: Developers
- Goals: Create reusable UI components
EOF

cat << 'EOF' > .agent-sdd/product/roadmap.md
# Roadmap
- Phase 0: Already Completed
  - [x] Agent-SDD setup
- Phase 1: Current Development (Q3 2025)
  - [ ] Text Display component

## Example Progress Log Entry
**[2025-08-14] – Completed Initial Theme Integration**
- **What:** Applied minimal theme preset and verified color standards.
- **Why:** Ensures consistent design and accessibility from the start.
- **Impact:** All components must use theme variables; old hardcoded colors replaced.
EOF

cat << 'EOF' > .agent-sdd/product/decisions.md
# Decisions
- 2025-08-13: Use Tailwind/shadcn/ui (DEC-001, Accepted, Technical)
  - Rationale: Consistent styling, accessibility
  - Alternatives: Custom CSS (too complex)
EOF

# Instruction files
echo "📥 Creating instruction files..."
cat << 'EOF' > .agent-sdd/instructions/sdd-plan-product.md
# /sdd-plan-product
Create or update product documentation:
1. Prompt user for mission, target users, key features (min 3).
2. Update .agent-sdd/product/overview.md with mission, users, goals.
3. Add new phase to .agent-sdd/product/roadmap.md (3-7 features, effort: XS=1 day, S=2-3 days, M=1 week).
4. Log decisions in .agent-sdd/product/decisions.md (ID: DEC-XXX).
5. Reference .agent-sdd/standards/* for context.
EOF

cat << 'EOF' > .agent-sdd/instructions/sdd-create-spec.md
# /sdd-create-spec [--lite | --ui-only]
Create a Software Design Document:
1. Prompt user for feature name and description.
2. If "what's next?", check .agent-sdd/product/roadmap.md for next item.
3. Use **date-checker** agent to get current date, then create folder `.agent-sdd/specs/create-spec-[task-id]-[CURRENT-DATE]/` (where task-id is kebab-case, max 5 words).
4. Generate `sdd.md` with:
   - Overview: Goal, user story, success criteria
   - Technical Specs: UI requirements (skip if --lite)
   - Tasks: List with IDs, dependencies, effort (XS=1 day, S=2-3 days, M=1 week)
   - Test Scenarios
   - Theme Standards Compliance (reference `.agent-sdd/standards/theme-standards.md`)
5. **Create tasks.json**:
   - Use `file-creator` to generate `tasks.json` with the feature name and tasks derived from the **Tasks** section.
   - For each task:
     - Set required fields: `id` (e.g., `[FEATURE_NAME]-feature-[N]`), `type: "feature"`, `title` (from task description), `description` (detailed task details), `status: "pending"`, `priority` (from SDD or default "medium"), `created_date` (from `date-checker`), `ux_ui_reviewed: false`, `theme_changes` (true for `--ui-only`, else false).
     - Set optional fields: `target_files` (from Technical Specs or user input), `dependencies` (from SDD), `linked_task` (if task is a follow-up), `acceptance_criteria` (from SDD's success criteria or Test Scenarios), `theme_name` (auto-populated if `theme_changes: true`).
   - Validate against `.agent-sdd/standards/task-schema.md`.
6. **If `--lite`**: Only include Overview and Tasks, set `theme_changes: false` unless specified.
7. **If `--ui-only`**: Focus on UI Requirements and Theme Standards, set `theme_changes: true` and `theme_name` for tasks.
8. **Check alignment** with `.agent-sdd/product/*` (e.g., `roadmap.md`); update `decisions.md` if needed.
9. **Prompt user**: `"Proceed with Task 1? (yes/no)"`
EOF

cat << 'EOF' > .agent-sdd/instructions/sdd-execute-task.md
# /sdd-execute-task <task-id> [--no-tests] [--quick | --no-spec] [--fix-style]
Execute a task end‑to‑end and enforce Theme Standards.

## Modes
- `default` → Load `.agent-sdd/specs/*/tasks.json`, `sdd.md`, and `.agent-sdd/product/*`.
- `--quick` → Load only `.agent-sdd/specs/*/tasks.json` and `sdd.md` (skip roadmap sync).
- `--no-spec` → Skip spec loading. If `<task-id>` not found, prompt and create ad‑hoc task under `.agent-sdd/specs/execute-task-[task-id]-[CURRENT-DATE]/` (use **date-checker** agent first).
- `--no-tests` → Skip test writing/execution.
- `--fix-style` → When review runs, apply safe style fixes automatically (calls `/sdd-review-code --fix`).

## Workflow
1. **Detect mode** and **resolve task**: Look up `<task-id>` in `.agent-sdd/specs/*/tasks.json`.
2. **Confirm target paths** with the user.
3. **Implement code** per the spec/task and ensure **WCAG 2.1 AA**.
4. **Commit step**: Suggest message: `"[task-id]: <short description>"`.
5. **Tests**: If not `--no-tests` and a `package.json` exists, write tests and run via **test-runner** agent.
6. **Theme review**: Use `/sdd-review-code <modified-paths> [--fix]` instruction.
7. **Update task state**:
   - Mark status `"completed"` and set `completed_date` using **date-checker** agent
   - Set `ux_ui_reviewed: true` after successful theme review
   - Update `target_files` array with actually modified files
   - Validate final task object against `.agent-sdd/standards/task-schema.md`
8. **Summary**: Report implemented files, review results, test outcomes, next steps.
EOF

cat << 'EOF' > .agent-sdd/instructions/sdd-fix.md
# /sdd-fix [--no-tests] <description>
Apply a quick fix:
1. Use date-checker agent to get current date, then create task in .agent-sdd/specs/fix-[task-id]-[CURRENT-DATE]/tasks.json.
2. Implement fix, ensuring .agent-sdd/standards/theme-standards.md compliance.
3. Use Agent-SDD instruction: /sdd-review-code on modified files (NOT bash command) to ensure UX/UI compliance.
4. Commit with message "fix: [description]".
5. Update task status to "completed" and set ux_ui_reviewed: true.
6. Notify user with summary.
EOF

cat << 'EOF' > .agent-sdd/instructions/sdd-tweak.md
# /sdd-tweak [--fix-style] [--no-tests] <description>
Apply a minor UI tweak:
1. Use date-checker agent to get current date, then create task in .agent-sdd/specs/tweak-[task-id]-[CURRENT-DATE]/tasks.json.
2. Implement tweak, strictly following .agent-sdd/standards/theme-standards.md.
3. Use Agent-SDD instruction: /sdd-review-code on modified files (NOT bash command) to ensure UX/UI compliance.
4. Commit with message "tweak: [description]".
5. Update task status to "completed" and set ux_ui_reviewed: true.
6. Notify user with summary.
EOF

cat << 'EOF' > .agent-sdd/instructions/sdd-analyze.md
# /sdd-analyze
Analyze project state:
1. Review .agent-sdd/product/roadmap.md for progress.
2. Check .agent-sdd/specs/*/tasks.json for completed tasks.
3. Analyze codebase for theme compliance.
4. Update .agent-sdd/product/decisions.md with insights.
5. Suggest next steps based on roadmap.
6. Notify user with summary: completed features, next tasks.
EOF

cat << 'EOF' > .agent-sdd/instructions/sdd-review-code.md
# /sdd-review-code <file-path>
Review code for theme standards compliance:
1. Read .agent-sdd/standards/theme-standards.md for rules.
2. Scan <file-path> for non-compliant styles (colors, typography, components).
3. Apply fixes (e.g., replace invalid Tailwind classes).
4. Commit with message "style: Update [file-path] for theme compliance".
5. Notify user with report: issues found, fixes applied.
EOF

cat << 'EOF' > .agent-sdd/instructions/sdd-check-task.md
# /sdd-check-task <task-id>
Verify task completion and documentation:
1. Locate task in .agent-sdd/specs/*/tasks.json.
2. Verify folder naming: <action>-<task-id>-[date].
3. Check status: "completed" and ux_ui_reviewed: true.
4. Validate documentation in sdd.md.
5. Check theme compliance of modified files.
6. Look for commit with task ID.
7. Generate check report with overall status.
EOF

cat << 'EOF' > .agent-sdd/instructions/sdd-queue-tweak.md
# /sdd-queue-tweak <task-id> <description>
Queue UI/UX improvement for batch processing:
1. Check if task exists in specs.
2. Use date-checker for current date.
3. Create/update spec: queue-tweak-[task-id]-[date].
4. Add to tweaks-queue.json sorted by priority.
5. Estimate effort (XS/S/M).
6. Show queue position and next steps.
EOF

cat << 'EOF' > .agent-sdd/instructions/sdd-queue-fix.md
# /sdd-queue-fix <task-id> <description>
Queue bug/issue for systematic resolution:
1. Categorize by severity and type.
2. Use date-checker for current date.
3. Create/update spec: queue-fix-[task-id]-[date].
4. Add to fixes-queue.json sorted by severity.
5. Link to original task if regression.
6. Generate fix ticket with priority score.
EOF

cat << 'EOF' > .agent-sdd/instructions/sdd-vibe-task.md
# /sdd-vibe-task
Create a simple task for rapid development (vibe coding):
1. **Prompt user**: `"What do you want to build? (describe in 1-2 sentences)"`
2. **Parse input**: Extract feature name (kebab-case, max 5 words) and detect if UI-related (keywords: button, component, style, theme, design, layout).
3. **Use date-checker** agent to get current date.
4. **Create folder**: `.agent-sdd/specs/vibe-task-[feature-name]-[CURRENT-DATE]/`
5. **Generate minimal `sdd.md`**:
   - Title: derived from user input
   - Overview: 2-3 sentences based on user description
   - Tasks: Single task entry
6. **Create `tasks.json`**:
   - Use `file-creator` to generate `tasks.json` with the feature name (derived from `title`) and a single task.
   - Set required fields: `id`, `type: "feature"`, `title`, `description`, `status: "pending"`, `priority: "medium"`, `created_date`, `ux_ui_reviewed: false`, `theme_changes` (based on user input or default `false`).
   - Set optional fields: `target_files`, `acceptance_criteria` (if provided), `theme_name` (auto-populated if `theme_changes: true`).
   - Validate against `.agent-sdd/standards/task-schema.md`.
7. **Prompt user**: `"Proceed with task? (yes/no)"`.
EOF

cat << 'EOF' > .agent-sdd/instructions/sdd-apply-theme.md
# /sdd-apply-theme
Apply a visual theme to the project:
1. Prompt to choose: `minimal` / `classic` / `vibrant` / `custom`.
2. If `custom`: ask for `primary`, `secondary`, `success`, `error` (hex or rgb).
3. Discover paths (with fallbacks):
   - `app.css`: tries `src/app/globals.css`, `src/app.css`, `app/globals.css`
   - `components`: tries `src/components/ui`, `components/ui`
4. Write or update:
   - `.agent-sdd/standards/theme-files/[theme]/theme.css` (CSS variables + small utilities)
   - `.agent-sdd/standards/theme-standards.md` (colors + allow‑list + examples)
5. Append decision to `.agent-sdd/product/decisions.md` with date and chosen settings.
6. **Update existing tasks** (if applicable):
   - Find tasks with `theme_changes: true` in `.agent-sdd/specs/*/tasks.json`
   - Update their `theme_name` field to match the applied theme
   - Validate updated tasks against schema
7. Print a short "what changed" summary with import snippet.
EOF

cat << 'EOF' > .agent-sdd/instructions/sdd-update.md
# /sdd-update
Update the Agent-SDD system to the latest standards:
1. **Backup current system**: Create `.agent-sdd-backup-[DATE]/` with current configuration.
2. **Update standards**: Refresh `.agent-sdd/standards/` files with latest schema and best practices.
3. **Migrate tasks**: Update all `tasks.json` files to comply with latest schema (`.agent-sdd/standards/task-schema.md`):
   - Add missing required fields with appropriate defaults
   - Validate existing field values and formats
   - Update task ID format if needed: `[TASK-ID]-[type]-[N]`
4. **Update agents**: Refresh agent files in `.agent-sdd/agents/` with latest capabilities.
5. **Update instructions**: Refresh instruction files in `.agent-sdd/instructions/` with schema compliance.
6. **Validate system**: Check all files for consistency and compliance.
7. **Generate report**: Show what was updated, migrated, or needs manual attention.
EOF

# Agent files
echo "📥 Creating agent files..."
cat << 'EOF' > .agent-sdd/agents/context-fetcher.md
---
name: context-fetcher
description: Retrieves relevant information from Agent-SDD documentation files.
tools: Read, Grep, Glob
color: blue
---

You are a specialized information retrieval agent for Agent-SDD workflows. Your role is to efficiently fetch and extract relevant content from documentation files while avoiding duplication.

## Core Responsibilities
1. **Context Check First**: Determine if requested information is already in the main agent's context.
2. **Selective Reading**: Extract only the specific sections or information requested.
3. **Smart Retrieval**: Use grep to find relevant sections rather than reading entire files.
4. **Task Schema Support**: Retrieve task schema information for validation and compliance.
5. **Return Efficiently**: Provide only new information not already in context.

## Supported File Types
- Specs: sdd.md, tasks.json
- Product docs: overview.md, roadmap.md, decisions.md
- Standards: theme-standards.md, code-style.md, best-practices.md, task-schema.md

## Workflow
1. Check if the requested information is in context.
2. If not, locate the requested file(s).
3. Extract relevant sections using grep.
4. Return specific information needed.

## Output Format
For new information:
\`\`\`
📄 Retrieved from [file-path]
[Extracted content]
\`\`\`
For already-in-context:
\`\`\`
✓ Already in context: [brief description]
\`\`\`

## Constraints
- Never return duplicated information.
- Extract minimal necessary content.
- Use grep for targeted searches.
- Never modify files.
EOF

cat << 'EOF' > .agent-sdd/agents/date-checker.md
---
name: date-checker
description: Determines today's date in YYYY-MM-DD format using file system timestamps.
tools: Read, Grep, Glob
color: pink
---

You are a specialized date determination agent for Agent-SDD workflows. Your role is to accurately determine the current date in YYYY-MM-DD format.

## Core Responsibilities
1. **Context Check**: Verify if the date is already in context.
2. **File System Method**: Use temporary file creation to extract timestamps.
3. **Format Validation**: Ensure YYYY-MM-DD format for task schema compliance.
4. **Task Schema Support**: Provide dates for `created_date` and `completed_date` fields.
5. **Output Clearly**: Output date at the end of response.

## Workflow
1. Check if date is in context.
2. If not, create temporary file: `.agent-sdd/specs/.date-check`.
3. Extract timestamp and parse to YYYY-MM-DD.
4. Clean up temporary file.
5. Validate format and output.

## Output Format
\`\`\`
✓ Date already in context: YYYY-MM-DD
Today's date: YYYY-MM-DD
\`\`\`
or
\`\`\`
📅 Determining current date...
✓ Date extracted: YYYY-MM-DD
Today's date: YYYY-MM-DD
\`\`\`

## Constraints
- Always output date as: `Today's date: YYYY-MM-DD`.
- Never ask user for date unless method fails.
- Clean up temporary files.
EOF

cat << 'EOF' > .agent-sdd/agents/file-creator.md
---
name: file-creator
description: Creates files and directories for Agent-SDD workflows.
tools: Write, Bash, Read
color: green
---

You are a specialized file creation agent for Agent-SDD projects. Your role is to create files and directories with consistent templates.

## Core Responsibilities
1. **Directory Creation**: Create proper directory structures.
2. **File Generation**: Create files with headers and metadata.
3. **Template Application**: Apply standard templates.
4. **Naming Conventions**: Ensure proper naming.
5. **Task Schema Validation**: Ensure `tasks.json` tasks conform to `.agent-sdd/standards/task-schema.md`.

## Templates
### sdd.md
\`\`\`markdown
# Software Design Document: [FEATURE_NAME]
**Created**: [CURRENT_DATE]
**Status**: Draft
## Overview
[OVERVIEW_CONTENT]
## Tasks
[TASKS_CONTENT]
\`\`\`

### tasks.json
\`\`\`json
{
  "feature": "[FEATURE_NAME]",
  "tasks": [
    {
      "id": "[TASK-ID]-[type]-[N]",
      "type": "feature|fix|tweak",
      "title": "[Short title]",
      "description": "[Detailed description]",
      "status": "pending",
      "priority": "medium",
      "created_date": "[CURRENT-DATE]",
      "completed_date": null,
      "target_files": [],
      "dependencies": [],
      "linked_task": null,
      "acceptance_criteria": [],
      "ux_ui_reviewed": false,
      "theme_changes": false,
      "theme_name": null
    }
  ]
}
\`\`\`

## Workflow
1. Create directories with `mkdir -p`.
2. Apply template with provided content.
3. Use date from **date-checker** agent (YYYY-MM-DD).
4. **Populate Tasks**: For `tasks.json`, populate with objects conforming to `.agent-sdd/standards/task-schema.md`. Ensure required fields are set.
5. **Validate Schema**: Validate task objects against schema before writing.
6. Report success or errors.

## Output Format
\`\`\`
✓ Created directory: [path]
✓ Created file: [file]
\`\`\`
or
\`\`\`
⚠️ File already exists: [path]
→ Action: Skipping file creation
\`\`\`

## Constraints
- Never overwrite existing files.
- Use relative paths from project root.
- Maintain template structure.
EOF

cat << 'EOF' > .agent-sdd/agents/git-workflow.md
---
name: git-workflow
description: Handles git operations for Agent-SDD workflows.
tools: Bash, Read, Grep
color: orange
---

You are a specialized git workflow agent for Agent-SDD projects. Your role is to handle git operations efficiently.

## Core Responsibilities
1. **Branch Management**: Create/switch branches (kebab-case, no dates).
2. **Commit Operations**: Stage and commit with descriptive messages.
3. **Status Checking**: Monitor git status.
4. **Task Status Management**: Update task status and completion dates in tasks.json.
5. **Schema Compliance**: Ensure commit messages follow task ID format [TASK-ID]-[type]-[N].

## Workflow
1. Check current branch.
2. Update task status to "completed" and set completed_date if task is finished.
3. Stage changes and commit with "[task-id]: [description]" format.
4. Push to remote (if applicable).

## Output Format
\`\`\`
✓ Committed changes: [message]
✓ Pushed to origin/[branch]
\`\`\`
or
\`\`\`
⚠️ Uncommitted changes detected
→ Action: Staging all changes
\`\`\`

## Constraints
- Never force push without permission.
- Check for uncommitted changes before switching branches.
- Verify remote exists before pushing.
EOF

cat << 'EOF' > .agent-sdd/agents/test-runner.md
---
name: test-runner
description: Runs tests and analyzes failures for Agent-SDD tasks.
tools: Bash, Read, Grep, Glob
color: yellow
---

You are a specialized test execution agent. Your role is to run tests and provide failure analysis.

## Core Responsibilities
1. **Run Tests**: Execute specified tests.
2. **Analyze Failures**: Provide actionable failure information.
3. **Validate Acceptance Criteria**: Check test results against task acceptance_criteria.
4. **Task Status Updates**: Update task status based on test results.
5. **Return Control**: Never attempt fixes.

## Workflow
1. Check for package.json to run tests.
2. Parse test results.
3. Compare results against task acceptance_criteria from tasks.json.
4. Update task status based on test success/failure.
5. Report failures with test name, expected vs. actual, and fix suggestion.

## Output Format
\`\`\`
✅ Passing: X tests
❌ Failing: Y tests
Failed Test: [test_name]
Expected: [description]
Actual: [description]
Fix location: [file]
Suggested approach: [suggestion]
\`\`\`

## Constraints
- Run only specified tests.
- Keep analysis concise.
- Never modify files.
EOF

cat << 'EOF' > .agent-sdd/agents/code-reviewer.md
---
name: code-reviewer
description: Reviews code for UX/UI compliance with theme standards.
tools: Read, Grep, Write, Glob
color: purple
---

You are a specialized UX/UI code review agent for Agent-SDD projects. Your role is to crawl code files, verify compliance with `.agent-sdd/standards/theme-standards.md`, and update styling.

## Core Responsibilities
1. **Code Crawling**: Scan `*.tsx` and `*.css` in `components/` and `app/`.
2. **Theme Compliance**: Check colors, typography, components, spacing.
3. **Accessibility**: Ensure WCAG 2.1 AA, ARIA labels, touch targets.
4. **Responsive Design**: Verify responsive Tailwind classes.
5. **Animations**: Add subtle animations (e.g., `animate-in`).
6. **Styling Updates**: Apply fixes for non-compliant styles.
7. **Task Status Updates**: Update task `ux_ui_reviewed` field when review is complete.
8. **Reporting**: Provide report of issues and fixes.

## Workflow
1. Identify files with glob.
2. Check compliance against theme-standards.md.
3. Apply fixes (e.g., replace invalid classes).
4. Update corresponding task in `tasks.json` with `ux_ui_reviewed: true` if review passes.
5. Commit with "style: Update [file] for theme compliance".
6. Report issues and fixes.

## Output Format
\`\`\`
📝 Reviewing [file-path]...
✓ Compliant: [e.g., Uses Roboto font]
❌ Non-compliant:
  - Issue: Uses bg-blue-500
  - Fix: Replaced with bg-gray-500
✓ File updated: [file-path]
\`\`\`

## Constraints
- Never modify logic/functionality.
- Backup files as `.bak`.
- Run automatically after /sdd-execute-task, /sdd-fix, /sdd-tweak.
EOF

# Copy instructions and agents to Claude
echo "📥 Configuring Claude Code..."
mkdir -p ~/.claude/commands
cp .agent-sdd/instructions/*.md ~/.claude/commands/
cp .agent-sdd/agents/*.md ~/.claude/commands/

# Ensure scripts directory exists
mkdir -p .agent-sdd/scripts

# Make scripts executable if any exist
if [ -d ".agent-sdd/scripts" ]; then
  chmod +x .agent-sdd/scripts/*.sh 2>/dev/null || true
  echo "🔑 Made all scripts in .agent-sdd/scripts executable."
fi

# Add sdd-review-code npm script if not already in package.json
if [ -f "package.json" ]; then
  if ! grep -q '"sdd-review-code"' package.json; then
    echo "📦 Adding sdd-review-code script to package.json..."
    npx json -I -f package.json -e 'this.scripts["sdd-review-code"]=".agent-sdd/scripts/sdd-review-code.sh"'
  else
    echo "ℹ️  sdd-review-code script already exists in package.json."
  fi
fi

# Ask user if they want to apply a theme right after install
read -r -p "🎨 Do you want to apply a theme now? (y/N): " APPLY_THEME
if [[ "$APPLY_THEME" =~ ^[Yy]$ ]]; then
  echo "Select a theme preset:"
  select opt in "minimal" "classic" "vibrant" "custom"; do
    ./.agent-sdd/scripts/sdd-apply-theme.sh --preset "$opt"
    break
  done
fi

echo # just a newline, no quotes needed
echo "📍 Files installed to .agent-sdd/"
if [[ ! "$APPLY_THEME" =~ ^[Yy]$ ]]; then
  echo "💡 No theme applied. Use /sdd-apply-theme to set a custom or default theme."
fi
echo "🚀 Run /sdd-plan-product or /sdd-apply-theme in Claude Code to start!"
echo "✅ Agent-SDD setup complete."
