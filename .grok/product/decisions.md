# Project Decisions

## Purpose
Records significant technical, process, and product decisions that shape the project’s direction, updated by `/sdd-task --roadmap` and other workflows. Stored in `.claude/product/decisions.md` for reference by `.claude/agents/context-fetcher.md`.

## Usage
- Log decisions affecting project direction or implementation.
- Use the template below for consistency.
- Do not delete old decisions; mark as "Reversed" if changed.
- Updated by `.claude/agents/file-creator.md` during `/sdd-task --roadmap`.

## Entry Template
```
[YYYY-MM-DD] – [Decision Title]
What: [Brief description of what was decided]
Why: [Reasoning, constraints, or context]
Impact: [Effects on development, users, or scope]
Status: Active / Reversed on [date]
```

## What to Record
- **Technical**: Framework/library choices, architecture patterns, database design, security implementations.
- **Process**: Workflow changes, testing strategies, deployment approaches, code review processes.
- **Product**: Feature prioritization, UX choices, scope changes, business rules.

## Example Decisions
```
[2025-01-15] – Use REST API Instead of GraphQL
What: Build a REST API for the backend instead of GraphQL.
Why: Team expertise in REST, simpler caching, straightforward client needs.
Impact: API endpoints follow REST conventions, affects frontend data fetching.
Status: Active

[2025-02-03] – Prioritize User Authentication
What: Develop login/signup before social features like commenting.
Why: Authentication is foundational for other features and database design.
Impact: Social features deferred to Phase 2, auth system must be scalable.
Status: Active

[2025-02-20] – Weekly Code Reviews
What: Mandate weekly code review sessions for all pull requests.
Why: Improve code quality, knowledge sharing, and early bug detection.
Impact: PRs require approval, may slow development but enhances quality.
Status: Active
```

## Project Decisions
*Record your project-specific decisions here using the template above.*