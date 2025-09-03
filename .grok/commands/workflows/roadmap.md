# grok_sdd_roadmap() Workflow

Plans the product roadmap, features, and milestones when `grok_sdd_roadmap()` is invoked. Operates within the `.grok/` directory structure and integrates with the Agent-SDD Dashboard.

## Purpose
- Break down the product vision into actionable phases and milestones.
- Ensure features align with `.grok/standards/theme-standards.md`.

## Directory Context
Uses the `.grok/` structure:
- **Product**: `.grok/product/` (overview.md, roadmap.md, decisions.md)
- **Standards**: `.grok/standards/` (theme-standards.md for theme compliance)
- **Agents**: `.grok/agents/` (context-fetcher.md, file-creator.md)

## Command Syntax
```
grok_sdd_roadmap()
```
- **Arguments**: None.

## Workflow
1. **Parse Input**:
   - Read `grok_sdd_roadmap()` via CLI or dashboard.
2. **Read Changelog Context**:
   - Use `.grok/agents/logger.md` in read mode to gather recent project changes and context.
3. **Review Context**:
   - Use `.grok/agents/context-fetcher.md` to load:
     - `.grok/product/overview.md` for high-level goals.
     - `.grok/product/roadmap.md` for existing progress.
     - `.grok/product/decisions.md` for past technical decisions.
4. **Confirm Theme Standards**:
   - Verify new features will use approved colors, typography, and spacing from `.grok/standards/theme-standards.md`.
5. **Define Milestones**:
   - Create milestones with clear deliverables and measurable outcomes.
6. **List Features**:
   - Assign each feature a priority (P0 = critical, P1 = high, P2 = nice-to-have).
   - Note dependencies between features.
7. **Identify Risks**:
   - Document potential risks and mitigation strategies.
8. **Save Plan**:
   - Use `.grok/agents/file-creator.md` to write milestones, features, and risks to `.grok/product/roadmap.md`.
   - Append strategic decisions to `.grok/product/decisions.md`.
9. **Log Roadmap Update**:
   - Use `.grok/agents/logger.md` in write mode to record roadmap changes in `.grok/changelog.md`.

## Dashboard Integration
- The dashboard provides a form to input milestones, features, priorities, and risks.
- Displays the updated roadmap for review before saving.

## Error Handling
- **Missing Files** [ERR_004]: Return "Error [ERR_004]: Required file (e.g., `.grok/product/overview.md`) not found."
- **Invalid Theme Standards** [ERR_004]: Return "Error [ERR_004]: `.grok/standards/theme-standards.md` not found."

## Example Usage
```
grok_sdd_roadmap()
```
**Example Output**:
```
Roadmap updated at .grok/product/roadmap.md
Added 2 milestones with 5 features
Decisions logged at .grok/product/decisions.md
```