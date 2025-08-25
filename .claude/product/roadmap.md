# Project Roadmap

## Purpose
Outlines project phases, tasks, and milestones to guide `/sdd-task --roadmap` and `/sdd-task --next` workflows. Stored in `.claude/product/roadmap.md`, updated by `.claude/agents/file-creator.md` and referenced by `.claude/agents/context-fetcher.md`.

## Usage
- Replace example phases with project-specific milestones.
- Mark tasks with `[x]` (completed) or `[ ]` (pending).
- Update the Progress Log via `/sdd-task --next` or `/sdd-task --check`.
- Use realistic timeframes and dependencies.

## Phase 1: [Replace with Phase Name] (Target: [Timeline])
- [ ] [First task]
- [ ] [Second task]
- [ ] [Third task]

## Phase 2: [Replace with Phase Name] (Target: [Timeline])
- [ ] [First task]
- [ ] [Second task]
- [ ] [Third task]

## Phase 3: [Replace with Phase Name] (Target: [Timeline])
- [ ] [First task]
- [ ] [Second task]
- [ ] [Third task]

## Progress Log
Log task completions and milestones with date and notes.

**Template:**
```
[YYYY-MM-DD] – [Task Name]
Status: completed / in_progress / blocked
Spec: .claude/specs/[spec_name]-[spec_type]-[spec_date]/
Notes: [Description of accomplishment, challenges, or next steps]
```

**Examples:**
```
[2025-08-22] – Create User Login Page
Status: completed
Spec: .claude/specs/create-a-login-page_feature_2025_08_25/
Notes: Implemented login form with auth API integration.

[2025-08-23] – Increase Button Padding
Status: in_progress
Spec: .claude/specs/update-BTN-012-2025-08-23/
Notes: Awaiting theme compliance review.
```

## Project Progress
*Log your project-specific progress here using the template above.*