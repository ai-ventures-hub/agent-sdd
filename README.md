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

### Getting Started

1) **Initialize**
```bash
bash setup-agent-sdd.sh
```

2) **Theme Configuration**
Update `.agent-sdd/standards/theme-standards.md` with your design tokens, colors, and component styles. Reference the approved Tailwind utilities in your components.

### Natural Language Commands
Claude Code understands natural language! You can use formal commands or just describe what you want:

**Formal Command** → **Natural Language Alternatives**
- `/sdd-next-phase` → "what's next on the roadmap" or "create spec for next item"
- `/sdd-create-spec` → "create a spec for user login" or "I need a spec"
- `/sdd-execute-task BTN-001` → "implement task BTN-001" or "execute the button task"
- `/sdd-review-code` → "review my code for theme compliance" or "check styling"
- `/sdd-vibe-task` → "quick task" or "create a simple task"

### Command Reference

3) **Next Phase** (Roadmap Integration)
```bash
# Formal command
/sdd-next-phase

# Or just ask naturally:
"what's next on the roadmap?"
"create spec for the next phase"
```

4) **Create a Spec**
```bash
# Formal commands
/sdd-create-spec --lite "Add text display component"
/sdd-create-spec --ui-only "Update modal styling"

# Or describe naturally:
"create a lite spec for adding user authentication"
"I need a UI-only spec for the dashboard redesign"
"make a spec for the payment flow"
```

5) **Execute a Task**
```bash
# Formal command
/sdd-execute-task TDC-002 --fix-style

# Or ask naturally:
"implement task TDC-002"
"execute the text display task and fix any style issues"
"let's work on TDC-002"
```

6) **Vibe Task** (Quick Development)
```bash
# Formal command
/sdd-vibe-task

# Or simply say:
"quick task for fixing the header"
"create a simple task"
"vibe mode: add a loading spinner"
```

7) **Review Code**
```bash
# Formal command
/sdd-review-code components/TextDisplay/TextDisplay.tsx --fix

# Or request naturally:
"review the TextDisplay component for theme compliance"
"check if my code follows the style guide and fix issues"
"fix styling in components folder"
```

8) **Analyze**
```bash
# Formal command
/sdd-analyze src/components

# Or describe what you need:
"analyze the components folder"
"check for code drift in src"
"scan for improvement opportunities"
```

9) **Check Task Completion**
```bash
# Formal command
/sdd-check-task BTN-012

# Or ask naturally:
"is task BTN-012 complete?"
"check the button task status"
"verify BTN-012 was done properly"
```

10) **Update System**
```bash
# Formal command
/sdd-update

# Or simply request:
"update agent-sdd"
"migrate to latest schema"
"update the system"
```

### 💡 Pro Tips for Natural Language

- **Be conversational**: "Hey, can you create a spec for the user dashboard?"
- **Combine actions**: "Create and execute a lite spec for adding a footer"
- **Ask questions**: "What tasks are pending?" or "Show me the roadmap"
- **Use context**: After viewing a task, just say "execute it" or "implement this"
- **Request help**: "How do I create a UI-focused spec?" or "What's the next step?"

Claude Code understands your intent, so don't worry about exact syntax!

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
- **Create Spec**: Creates `spec.md` and `tasks.json` under `.agent-sdd/specs/create-spec-[task-id]-[date]/`.
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
