# Migration Guide: From Agent-SDD to Grok-SDD

This guide helps you migrate from the Claude-based Agent-SDD framework to the Grok-compatible Grok-SDD framework.

## Overview

The core framework remains the same, but the interface has been adapted for Grok's conversational model:

| Aspect | Agent-SDD (Claude) | Grok-SDD (Grok) |
|--------|-------------------|-----------------|
| **Interface** | `/sdd-task --flag` commands | Natural language → Function calls |
| **Directory** | `.claude/` | `.grok/` |
| **Integration** | Claude Code + Dashboard | Grok conversations |
| **Workflows** | Command-based | Function call-based |

## Quick Migration Checklist

- [ ] **Step 1**: Rename `.claude/` to `.grok/` (or create new)
- [ ] **Step 2**: Update all documentation references
- [ ] **Step 3**: Test core workflows with natural language
- [ ] **Step 4**: Verify agent integrations work
- [ ] **Step 5**: Update team training materials

---

## Step 1: Directory Structure Migration

### Option A: Rename Existing Directory (Recommended)
```bash
# Navigate to your project root
cd /path/to/your/project

# Rename the directory
mv .claude .grok
```

### Option B: Create New Directory (Fresh Start)
```bash
# Navigate to your project root
cd /path/to/your/project

# Create new .grok directory
mkdir .grok

# Copy existing content (optional)
cp -r .claude/* .grok/ 2>/dev/null || true
```

---

## Step 2: Update Documentation References

### Files to Update:
- `README.md` - Project documentation
- Any internal documentation referencing `.claude/`
- Team documentation and runbooks

### Search & Replace Patterns:
```bash
# In your project files
find . -type f -name "*.md" -exec sed -i '' 's|\.claude|\.grok|g' {} \;
find . -type f -name "*.md" -exec sed -i '' 's|Agent-SDD|Grok-SDD|g' {} \;
find . -type f -name "*.md" -exec sed -i '' 's|agent-sdd\.com|N/A|g' {} \;
```

---

## Step 3: Command to Natural Language Mapping

### Old vs New Usage Patterns:

| Task | Agent-SDD (Claude) | Grok-SDD (Grok) |
|------|-------------------|-----------------|
| **Create Spec** | `/sdd-task --spec "Login" "Create login form"` | `"Create a spec for user login with validation"` |
| **Execute Task** | `/sdd-task --execute BTN-012` | `"Execute task BTN-012 from the specs"` |
| **Update Code** | `/sdd-task --update src/Button.tsx` | `"Update the Button component styling"` |
| **Fix Bug** | `/sdd-task --fix BTN-012` | `"Fix the button hover state issue"` |
| **Review Code** | `/sdd-task --review src/components/` | `"Review the recent changes for theme compliance"` |
| **Plan Roadmap** | `/sdd-task --roadmap` | `"Plan the product roadmap"` |

### Natural Language Examples:
- ✅ `"Create a spec for user authentication"`
- ✅ `"Execute the login feature I just specified"`
- ✅ `"Fix the validation bug in the form"`
- ✅ `"Update the header component with better styling"`
- ✅ `"Review my recent changes"`
- ✅ `"Analyze the project for issues"`

---

## Step 4: Agent Integration Verification

### Core Agents (Should Work Immediately):
- ✅ **Logger Agent**: Context awareness and changelog tracking
- ✅ **Task Schema Validator**: 14-field task validation
- ✅ **Context Fetcher**: File and information retrieval
- ✅ **File Creator**: Specification and documentation generation
- ✅ **Date Checker**: Consistent date formatting

### Workflow-Specific Agents:
- ✅ **Code Reviewer**: Theme compliance and accessibility
- ✅ **Test Runner**: Automated testing integration
- ✅ **Task Validator**: User verification workflows

### Testing Agent Integration:
```bash
# Test logger agent context reading
"Show me recent project changes"

# Test file operations
"Create a new feature spec for user registration"

# Test validation
"Check if task BTN-012 follows the schema"
```

---

## Step 5: Workflow Testing

### Test Each Workflow:
1. **Spec Creation**: `"Create a spec for shopping cart functionality"`
2. **Task Execution**: `"Execute the shopping cart task"`
3. **Code Updates**: `"Update the cart component with better UX"`
4. **Bug Fixes**: `"Fix the cart total calculation bug"`
5. **Code Review**: `"Review the cart changes for theme compliance"`
6. **Analysis**: `"Analyze the project for potential improvements"`

### Expected Behaviors:
- **Conversational Flow**: Grok should ask clarifying questions when needed
- **Context Awareness**: Previous conversations should inform current work
- **Error Handling**: Clear error messages for missing files or invalid inputs
- **File Operations**: Proper creation and updating of specs and tasks

---

## Step 6: Team Training & Adoption

### Training Materials to Update:
- [ ] Developer onboarding documentation
- [ ] Workflow documentation
- [ ] Code review guidelines
- [ ] Project contribution guides

### Key Changes to Communicate:
1. **Interface Change**: No more `/sdd-task` commands
2. **Conversational Approach**: Describe what you want in natural language
3. **Directory Location**: `.grok/` instead of `.claude/`
4. **Workflow Continuity**: Same structured development benefits

---

## Troubleshooting

### Common Issues & Solutions:

**Issue**: "Grok doesn't understand my request"
**Solution**: Be more specific: `"Create a software design document for user login with form validation"`

**Issue**: "Directory not found errors"
**Solution**: Ensure `.grok/` directory exists and contains required structure

**Issue**: "Agent references not working"
**Solution**: Verify all `.grok/agents/` files are present and accessible

**Issue**: "Function calls not triggering"
**Solution**: Use clearer natural language or reference specific task IDs

### Getting Help:
- Check `.grok/GROK.md` for framework instructions
- Review `.grok/commands/grok-sdd.md` for function call specifications
- Test with simple workflows first before complex operations

---

## Migration Validation Checklist

- [ ] `.grok/` directory exists with complete structure
- [ ] All documentation updated to reference `.grok/` instead of `.claude/`
- [ ] Basic workflows tested (spec creation, task execution)
- [ ] Agent integrations verified
- [ ] Team members trained on new conversational interface
- [ ] Backup of original `.claude/` directory (if needed)

---

## Benefits of Grok-SDD

### Advantages Over Claude Version:
1. **Natural Interaction**: More intuitive conversational interface
2. **Context Awareness**: Grok maintains conversation context across sessions
3. **Flexibility**: Adaptable to different communication styles
4. **Integration**: Seamless integration with Grok's capabilities
5. **Scalability**: Easier to extend with new conversational patterns

### Maintained Benefits:
- ✅ Structured development workflows
- ✅ Theme standards enforcement
- ✅ Comprehensive testing integration
- ✅ Quality assurance processes
- ✅ Documentation generation
- ✅ Task tracking and validation

---

## Rollback Plan

If you need to rollback to the Claude version:

```bash
# Rename directories back
mv .grok .claude

# Update documentation back
find . -type f -name "*.md" -exec sed -i '' 's|\.grok|\.claude|g' {} \;
find . -type f -name "*.md" -exec sed -i '' 's|Grok-SDD|Agent-SDD|g' {} \;
```

---

## Support & Resources

- **Framework Documentation**: `.grok/GROK.md`
- **Command Reference**: `.grok/commands/grok-sdd.md`
- **Workflow Details**: `.grok/commands/workflows/*.md`
- **Agent Specifications**: `.grok/agents/*.md`

The migration preserves all the structured development benefits while adapting to Grok's conversational interface. The core framework remains robust and reliable.
