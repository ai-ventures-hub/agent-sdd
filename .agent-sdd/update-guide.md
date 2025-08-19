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
- ✅ **theme-standards.md**: Configure your theme through the setup wizard
  - File will be regenerated with your chosen palette

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
2. **Configure your theme** through the setup wizard  
3. **Update product/overview.md** with your project details
4. **Add initial items to product/roadmap.md**
5. **Start using `/sdd-create-spec`** for your first features

## 🔄 **Keeping Updated**

- Use `/sdd-update` to migrate to newer Agent-SDD versions
- Your customizations in product/ and tech-stack.md will be preserved
- Theme and instruction files may be updated with new features

## 💡 **Pro Tips**

- The `.agent-sdd` folder is detected by the desktop app for visual progress tracking
- Task schema compliance ensures compatibility with future Agent-SDD versions
- Custom themes are stored in `standards/theme-files/[theme-name]/` and persist across updates