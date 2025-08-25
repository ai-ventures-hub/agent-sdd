# /sdd-task --roadmap Workflow

Plans the product roadmap, features, and milestones when `/sdd-task --roadmap` is invoked. Operates within the `.claude/` directory structure and integrates with the Agent-SDD Dashboard.

## Purpose
- Break down the product vision into actionable phases and milestones.
- Ensure features align with `.claude/standards/theme-standards.md`.

## Directory Context
Uses the `.claude/` structure:
- **Product**: `.claude/product/` (overview.md, roadmap.md, decisions.md)
- **Standards**: `.claude/standards/` (theme-standards.md for theme compliance)
- **Agents**: `.claude/agents/` (context-fetcher.md, file-creator.md)

## Command Syntax
```
/sdd-task --roadmap
```
- **Arguments**: None.

## Workflow
1. **Parse Input**:
   - Read `/sdd-task --roadmap` via CLI or dashboard.
2. **Read Changelog Context**:
   - Use `.claude/agents/logger.md` in read mode to gather recent project changes and context.
3. **Review Context**:
   - Use `.claude/agents/context-fetcher.md` to load:
     - `.claude/product/overview.md` for high-level goals.
     - `.claude/product/roadmap.md` for existing progress.
     - `.claude/product/decisions.md` for past technical decisions.
4. **Confirm Theme Standards**:
   - Verify new features will use approved colors, typography, and spacing from `.claude/standards/theme-standards.md`.
5. **Define Milestones**:
   - Create milestones with clear deliverables and measurable outcomes.
6. **List Features**:
   - Assign each feature a priority (P0 = critical, P1 = high, P2 = nice-to-have).
   - Note dependencies between features.
7. **Identify Risks**:
   - Document potential risks and mitigation strategies.
8. **Save Plan**:
   - Use `.claude/agents/file-creator.md` to write milestones, features, and risks to `.claude/product/roadmap.md`.
   - Append strategic decisions to `.claude/product/decisions.md`.
9. **Log Roadmap Update**:
   - Use `.claude/agents/logger.md` in write mode to record roadmap changes in `.claude/changelog.md`.

## Dashboard Integration
- The dashboard provides a form to input milestones, features, priorities, and risks.
- Displays the updated roadmap for review before saving.

## Error Handling
- **Missing Files** [ERR_004]: Return "Error [ERR_004]: Required file (e.g., `.claude/product/overview.md`) not found."
- **Invalid Theme Standards** [ERR_004]: Return "Error [ERR_004]: `.claude/standards/theme-standards.md` not found."

## Example Usage
```
/sdd-task --roadmap
```
**Example Output**:
```
Roadmap updated at .claude/product/roadmap.md
Added 2 milestones with 5 features
Decisions logged at .claude/product/decisions.md
```