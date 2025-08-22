# Claude Code Project Structure

A lightweight, Claude‑first system for structured software development. Uses a `.claude/` folder to manage specs, standards, tasks, and theme assets.

---

## ✨ Features
- **Project‑Specific**: All files live in `.claude/` folder for better integration with Claude Code.
- **Claude Commands**: `/sdd-plan-product`, `/sdd-next-phase`, `/sdd-create-spec [--lite | --ui-only]`, `/sdd-execute-task [--fix-style]`, `/sdd-analyze`, `/sdd-review-code`, `/sdd-check-task <task-id>`, `/sdd-vibe-task`, `/sdd-update`.
- **Theme Standards**: Unified design system defined in `.claude/standards/theme-standards.md`.
- **Sub‑agents**: `context-fetcher`, `date-checker`, `file-creator`, `git-workflow`, `test-runner`, `code-reviewer` (UX/UI focus).
- **UX/UI Enforcement**: Automatic style reviews after task execution with accessibility, responsive, and dark‑mode checks.
- **Theme Enforcement**: Design tokens and styling rules enforced via `code-reviewer` using `theme-standards.md`.

---

## 🧰 Installation
Create the `.claude/` directory structure in your project:

```bash
# Create the directory structure
mkdir -p .claude/{standards,product,specs,instructions,agents,commands}

# Add your project files to the appropriate directories
# Then customize theme-standards.md with your design system
```

---

## 🚀 Usage

### Getting Started

1) **Initialize**
Ensure the `.claude/` directory structure exists in your project root.

2) **Theme Configuration**
Update `.claude/standards/theme-standards.md` with your design tokens, colors, and component styles. Reference the approved Tailwind utilities in your components.

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
"update the project structure"
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
  `.claude/standards/theme-standards.md`  
- Contains design tokens, approved color utilities, typography, spacing, and component guidelines.
- All agents that enforce UI rules (**/sdd-review-code**, **/sdd-execute-task**, **/sdd-analyze**) reference `theme-standards.md` for compliance.

---

## 🧪 Testing
- **Plan Product**: Updates product docs with mission and roadmap.
- **Next Phase**: Automatically creates specs for next roadmap items with `/sdd-next-phase`.
- **Create Spec**: Creates `spec.md` and `tasks.json` under `.claude/specs/create-spec-[task-id]-[date]/`.
- **Execute Task**: Implements feature code and runs `/sdd-review-code` (optionally `--fix-style`).
- **Vibe Task**: Quick task creation for rapid development.
- **Review Code**: Ensures accessibility, responsive utilities, dark mode pairing (`dark:`), and theme color usage.
- **Analyze**: Broad scan for drift and opportunities.
- **Check Task**: Validates task completion, documentation, and theme compliance.
- **Update**: Updates system to latest standards and migrates existing tasks to current schema.
- **Note**: Test runner requires a `package.json` and Jest/Vitest to execute tests.

---

## 📁 Directory Structure
```
.claude/
├── standards/           # Tech stack, theme standards, best practices
│   ├── tech-stack.md
│   ├── theme-standards.md
│   └── best-practices.md
├── product/             # Product docs
│   ├── overview.md
│   ├── roadmap.md
│   └── decisions.md
├── specs/               # SDDs and tasks
├── instructions/        # Commands (sdd-*.md files)
├── agents/              # Subagents (context-fetcher.md, task-schema-validator.md, etc.)
├── commands/            # Claude Code command directory
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
