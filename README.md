# Agent-SDD

A lightweight, Claude‑first system for structured software development. Uses a `.agent-sdd/` folder to manage specs, standards, tasks, and theme assets.

---

## ✨ Features
- **Project‑Specific**: All files live in `.agent-sdd/`, initialized by `setup-agent-sdd.sh`.
- **Claude Commands**: `/sdd-plan-product`, `/sdd-next-phase`, `/sdd-create-spec [--lite | --ui-only]`, `/sdd-execute-task [--fix-style]`, `/sdd-analyze`, `/sdd-review-code`, `/sdd-check-task <task-id>`, `/sdd-vibe-task`, `/sdd-update`.
- **Theme Standards**: Unified design system defined in `.agent-sdd/standards/theme-standards.md`.
- **Sub‑agents**: `context-fetcher`, `date-checker`, `file-creator`, `git-workflow`, `test-runner`, `code-reviewer` (UX/UI focus).
- **UX/UI Enforcement**: Automatic style reviews after task execution with accessibility, responsive, and dark‑mode checks.
- **Theme Enforcement**: Design tokens and styling rules enforced via `code-reviewer` using `theme-standards.md`.

---

## 🧰 Installation
Use the setup script (remote) or a local copy.

```bash
# Remote (from your repo)
curl -s -o setup-agent-sdd.sh https://raw.githubusercontent.com/ai-ventures-hub/agent-sdd/main/setup-agent-sdd.sh
bash setup-agent-sdd.sh

# OR: Local (if the script is already in your project)
bash setup-agent-sdd.sh

# Note: Customize theme-standards.md with your design system.
```

---

## 🚀 Usage

1) **Initialize**
```bash
bash setup-agent-sdd.sh
```

2) **Theme Configuration**
Update `.agent-sdd/standards/theme-standards.md` with your design tokens, colors, and component styles. Reference the approved Tailwind utilities in your components.

3) **Next Phase** (Roadmap Integration)
```bash
# Automatically create spec for next roadmap item
/sdd-next-phase
```

4) **Create a Spec**
```bash
# Lite (overview + tasks only)
/sdd-create-spec --lite "Add text display component"

# UI‑only spec (focus on UI requirements + Theme Standards)
/sdd-create-spec --ui-only "Update modal styling"
```

5) **Execute a Task**
```bash
# Executes code, runs tests (if present), and enforces theme via review
/sdd-execute-task TDC-002 --fix-style
```

6) **Vibe Task** (Quick Development)
```bash
# Create a simple task for rapid development
/sdd-vibe-task
```

7) **Review Code**
```bash
# Review and auto‑fix style issues per Theme Standards
/sdd-review-code components/TextDisplay/TextDisplay.tsx --fix
```

8) **Analyze**
```bash
/sdd-analyze src/components
```

9) **Check Task Completion**
```bash
# Verify task was executed and documented properly
/sdd-check-task BTN-012
```

10) **Update System**
```bash
# Update Agent-SDD system to latest standards
/sdd-update
```

---

## 🎨 Theme Standards (Important)
- The **single source of truth** for theme information is:  
  `.agent-sdd/standards/theme-standards.md`  
- Contains design tokens, approved color utilities, typography, spacing, and component guidelines.
- All agents that enforce UI rules (**/sdd-review-code**, **/sdd-execute-task**, **/sdd-analyze**) reference `theme-standards.md` for compliance.

---

## 🧪 Testing
- **Plan Product**: Updates product docs with mission and roadmap.
- **Next Phase**: Automatically creates specs for next roadmap items with `/sdd-next-phase`.
- **Create Spec**: Creates `sdd.md` and `tasks.json` under `.agent-sdd/specs/create-spec-[task-id]-[date]/`.
- **Execute Task**: Implements feature code and runs `/sdd-review-code` (optionally `--fix-style`).
- **Vibe Task**: Quick task creation for rapid development.
- **Review Code**: Ensures accessibility, responsive utilities, dark mode pairing (`dark:`), and theme color usage.
- **Analyze**: Broad scan for drift and opportunities.
- **Check Task**: Validates task completion, documentation, and theme compliance.
- **Update**: Updates Agent-SDD system to latest standards and migrates existing tasks to current schema.
- **Note**: Test runner requires a `package.json` and Jest/Vitest to execute tests.

---

## 📁 Directory Structure
```
.agent-sdd/
├── agents/              # Subagents (context-fetcher.md, code-reviewer.md, etc.)
├── instructions/        # Commands (sdd-create-spec.md, etc.)
├── product/             # Product docs (overview.md, roadmap.md, decisions.md)
├── specs/               # SDDs and tasks
├── standards/           # Tech stack and theme standards
│   └── theme-standards.md
└── update-guide.md      # Guidance on which files users should customize
src/                     # Application code
```

---

## 🤝 Contributing
- Fork the repo.
- Create a feature branch: `git checkout -b feature-name`.
- Commit using `[type]: [description] (TASK-ID)` format, e.g., `git commit -m "feat: add theme validation (TDC-002)"`.
- Push and open a PR.

---

## 📄 License
MIT
