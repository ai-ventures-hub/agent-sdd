# Agent-SDD Update Guide

This guide tells you which files you should customize for your project and which ones to leave as defaults.

## 🔧 **Files You SHOULD Customize**

### **Standards** (`.agent-sdd/standards/`)
- ✅ **tech-stack.md**: Update with your actual tools, frameworks, and versions
  - Replace placeholders like "React (update version)" with "React 18.2.0"
  - Add your specific testing framework, build tools, etc.

### **Product** (`.agent-sdd/product/`)
- ✅ **overview.md**: Replace with your project's actual mission, target users, and goals
- ✅ **roadmap.md**: Add your real development phases and features
- ✅ **decisions.md**: Document your project's architectural and technical decisions

### **Theme** (`.agent-sdd/standards/`)
- ✅ **theme-standards.md**: Update with your project's design tokens, colors, and component styles

## 📋 **Files You Should LEAVE AS DEFAULT**

### **Standards**
- ❌ **best-practices.md**: Keep default unless your workflow requires changes (now includes code style guidelines)
- ❌ **task-schema.md**: Never modify - this ensures consistency across projects

### **System Files**
- ⚠️ **instructions/*.md**: Only modify if you need custom workflow commands
- ⚠️ **agents/*.md**: Only modify if you need specific agent behavior changes

## 🚀 **Initial Setup Checklist**

After installing Agent-SDD:

1. **Update tech-stack.md** with your actual project stack
2. **Update theme standards** in `theme-standards.md` with your design system  
3. **Update product/overview.md** with your project details
4. **Add initial items to product/roadmap.md**
5. **For existing projects with roadmap**: Start with `/sdd-next-phase` to work on next roadmap item
6. **For new features**: Use `/sdd-create-spec` to define requirements first
7. **For quick fixes**: Use `/sdd-vibe-task` or `/sdd-update` for rapid changes

## 🔄 **Keeping Updated**

### **Smart Update System**

The `setup-agent-sdd.sh` script now intelligently handles updates:

**Fresh Install** (no `.agent-sdd` exists):
- Downloads complete Agent-SDD from GitHub
- Sets up all files and directories
- Everything ready for customization

**Smart Update** (`.agent-sdd` exists):
- Downloads latest version to temp directory
- Updates system files (instructions, agents, core standards)
- **Preserves your customizations** in:
  - `standards/tech-stack.md`
  - `standards/theme-standards.md`
  - `product/overview.md`
  - `product/roadmap.md`
  - `product/decisions.md`
  - `specs/` directory (all your spec files)

### **Update Commands**

1. **Script Method**: `./setup-agent-sdd.sh`
   - Handles both fresh install and updates
   - Preserves customizations automatically
   - Validates installation afterward

2. **Claude Command**: `/sdd-update`
   - Updates from within Claude Code
   - Same preservation logic

## 📚 **Available Instructions Reference**

All instructions in `.agent-sdd/instructions/`:

1. **`/sdd-plan-product`** - Plan product roadmap, features, and milestones
2. **`/sdd-next-phase`** - Automatically create spec for next roadmap item (great for existing projects!)
3. **`/sdd-create-spec`** - Create detailed Software Design Documents
   - `--lite` flag for minimal specs
   - `--ui-only` flag for UI-focused specs
4. **`/sdd-execute-task`** - Implement tasks with theme compliance
   - `--fix-style` flag for auto-fixing style issues
   - `--no-tests` flag to skip test generation
   - `--no-spec` flag for ad-hoc tasks
5. **`/sdd-vibe-task`** - Quick task creation with minimal input
6. **`/sdd-update`** - Apply UI/UX tweaks or fixes to existing code
   - `--type tweak|fix` to specify update type
   - `--fix-style` flag for auto-fixing
7. **`/sdd-review-code`** - Review code for theme compliance
   - `--fix` flag to auto-apply safe style changes
8. **`/sdd-analyze`** - Analyze project for issues and improvements
9. **`/sdd-check-task`** - Verify task completion and documentation

## 💡 **Pro Tips**

- The `.agent-sdd` folder is detected by the desktop app for visual progress tracking
- Task schema compliance ensures compatibility with future Agent-SDD versions
- Theme standards are defined in `standards/theme-standards.md` and persist across updates
- For existing projects with roadmaps, `/sdd-next-phase` is your best starting point

## 🚨 **Preventing Duplicate .agent-sdd Directories**

**Issue**: Agents may create duplicate `.agent-sdd` directories in subdirectories instead of using the root one.

**Solution**: All agents now search upward from current directory to find existing `.agent-sdd`:
- If you have: `root/.agent-sdd`, `root/my-app/` 
- Running agents from `root/my-app/` will find and use `root/.agent-sdd`
- **Never** creates duplicates

**Setup Script Enhancement**: 
- `setup-agent-sdd.sh` now searches for existing `.agent-sdd` directories
- Prevents multiple installations
- Always updates the root installation