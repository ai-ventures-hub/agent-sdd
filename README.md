# Agent-SDD

A lightweight, Claude-first system for structured software development. Uses a `.agent-sdd/` folder to manage specs, standards, and tasks.

## Features
- **Project-Specific**: All files in `.agent-sdd/`, initialized by `setup-agent-sdd.sh`.
- **Claude Commands**: `/sdd-plan-product`, `/sdd-create-spec [--lite | --ui-only]`, `/sdd-execute-task`, `/sdd-fix --quick`, `/sdd-tweak --quick`, `/sdd-analyze`, `/sdd-review-code`, `/sdd-apply-theme`.
- **Themes**: Supports default (purple/Inter), minimal (gray/Roboto), corporate (navy/Lora), and custom themes (e.g., Syntax) with color customization via `theme-standards.md`.
- **Subagents**: `context-fetcher`, `date-checker`, `file-creator`, `git-workflow`, `test-runner`, `code-reviewer` (UX/UI focus).
- **UX/UI Enforcement**: Automatic style reviews after task execution, ensuring responsive design, animations, and accessibility.
- **Custom Theme Integration**: Apply custom themes (e.g., Syntax) with user-defined colors, enforced by `code-reviewer`.
- **Use Case**: Tested with Text Display component (no database dependencies).

## Installation
```bash
curl -s -o setup-agent-sdd.sh https://raw.githubusercontent.com/ai-ventures-hub/agent-sdd/main/setup-agent-sdd.sh
bash setup-agent-sdd.sh
# Choose theme: default, minimal, or corporate
```

## Usage
1. Initialize: `bash setup-agent-sdd.sh`.
2. Apply custom theme (optional): `/sdd-apply-theme` to integrate a theme (e.g., Syntax) with custom colors.
3. Create spec: `/sdd-create-spec --lite 'Add text display component'`.
4. Execute task: `/sdd-execute-task TDC-002`.
5. Fix/tweak: `/sdd-fix --quick` or `/sdd-tweak --quick`.
6. Review code: `/sdd-review-code components/TextDisplay/TextDisplay.tsx`.
7. Analyze: `/sdd-analyze`.

## Testing
- **Plan Product**: Updates product docs with mission and roadmap.
- **Apply Theme**: Integrates custom themes (e.g., Syntax) with user-defined colors, updating `theme-standards.md` and creating `syntax-custom.css`.
- **Create Spec**: Creates `sdd.md` and `tasks.json`.
- **Execute Task**: Implements `components/TextDisplay/TextDisplay.tsx` with theme styles.
- **Fix/Tweak**: Updates styling per `theme-standards.md`.
- **Review Code**: Ensures UX/UI compliance (responsive classes, animations, ARIA, custom colors).
- **Analyze**: Summarizes project state.
- **Note**: Test runner requires `package.json` and Jest/Vitest for full test execution.

## Directory Structure
```
.agent-sdd/
├── agents/              # Subagents (context-fetcher.md, code-reviewer.md, etc.)
├── instructions/        # Claude commands (sdd-apply-theme.md, etc.)
├── product/             # Product docs (overview.md, roadmap.md, decisions.md)
├── specs/               # SDDs and tasks
├── standards/           # Tech stack, theme standards, theme-files/
components/              # Test components (e.g., TestButton/)
```

## Contributing
- Fork the repo.
- Create a feature branch: `git checkout -b feature-name`.
- Commit: `git commit -m "feat: description"`.
- Push and create a PR.

## License
MIT