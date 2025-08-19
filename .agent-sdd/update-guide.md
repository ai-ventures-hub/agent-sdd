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
- ❌ **code-style.md**: Keep default unless your team has specific conventions
- ❌ **best-practices.md**: Keep default unless your workflow requires changes
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
5. **Start using `/sdd-create-spec`** for your first features

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

## 💡 **Pro Tips**

- The `.agent-sdd` folder is detected by the desktop app for visual progress tracking
- Task schema compliance ensures compatibility with future Agent-SDD versions
- Theme standards are defined in `standards/theme-standards.md` and persist across updates

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