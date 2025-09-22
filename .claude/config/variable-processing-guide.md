# Agent-SDD Variable Processing Guide (Automated System)

## Overview
This guide documents the automated variable processing system used by Agent-SDD. The system provides project-agnostic variable resolution with auto-discovery capabilities for seamless workflow execution.

## Variable Resolution Process

### 1. Understanding Variable Types

#### Project-Agnostic Variables
- `{{PROJECT_ROOT}}` - Auto-discovered project root directory
- `{{CLAUDE_DIR}}` - Auto-discovered .claude directory location
- `{{CURRENT_DIR}}` - Current working directory

#### Path Variables
- `{{paths.base_dir}}` - Claude directory (usually `.claude`)
- `{{paths.agents_dir}}` - Agents directory
- `{{paths.templates_dir}}` - Templates directory
- `{{paths.commands_dir}}` - Commands directory
- `{{paths.workflows_dir}}` - Workflow files directory

#### Agent Variables
- `{{agents.project_analyzer}}` - Project analyzer agent file
- `{{agents.task_decomposer}}` - Task decomposer agent file
- `{{agents.file_creator}}` - File creator agent file
- And many more...

### 2. Automated Variable Resolution Process

#### Step 1: Auto-Discovery Process
The system automatically discovers project structure using these indicators:

1. **Project Root Detection:**
   - Searches for package.json, .git, README.md
   - Uses current directory or parent directories up to depth 3

2. **Claude Directory Detection:**
   - Searches for .claude directory in project root or parent directories
   - Defaults to PROJECT_ROOT/.claude if not found

#### Step 2: Base Variable Resolution
System resolves base variables automatically:

```
{{PROJECT_ROOT}} → Auto-discovered project root
{{CLAUDE_DIR}} → Auto-discovered .claude directory
{{CURRENT_DIR}} → Current working directory
```

#### Step 3: Path Variable Construction
Using resolved base variables, system builds path variables:

```
{{paths.base_dir}} → {{CLAUDE_DIR}}
{{paths.agents_dir}} → {{paths.base_dir}}/agents
{{paths.templates_dir}} → {{paths.base_dir}}/templates
```

#### Step 4: Agent Variable Resolution
System resolves agent file paths automatically:

```
{{agents.project_analyzer}} → {{paths.agents_dir}}/project-analyzer.md
```

### 3. Automated File Processing

#### Variable Resolution During Runtime
1. Agent-SDD automatically resolves all `{{variable}}` placeholders at runtime
2. Uses discovered project structure to populate variable values
3. Applies consistent path resolution across all workflows and agents

#### Template Processing
1. Templates are processed automatically when used by agents
2. Variables are resolved based on current project context
3. No manual intervention required for variable substitution

### 4. Environment-Specific Processing

#### Development Environment
```yaml
# Use dev.yml configuration
# Lower thresholds, more verbose output
complexity_thresholds:
  high: 60    # More aggressive decomposition
  medium: 35  # Earlier medium trigger
```

#### Production Environment
```yaml
# Use prod.yml configuration
# Higher thresholds, stricter validation
complexity_thresholds:
  high: 75    # Conservative decomposition
  medium: 45  # Later medium trigger
```

### 5. Common Resolution Examples

#### Example 1: Workflow File
**Before:**
```markdown
- Route to: {{agents.task_decomposer}}
- Use config: {{paths.config_dir}}/variables.yml
```

**After:**
```markdown
- Route to: .claude/agents/task-decomposer.md
- Use config: .claude/config/variables.yml
```

#### Example 2: Agent File
**Before:**
```markdown
Read standards from: {{paths.standards_dir}}/best-practices.md
Write to: {{paths.product_dir}}/roadmap.md
```

**After:**
```markdown
Read standards from: .claude/standards/best-practices.md
Write to: .claude/product/roadmap.md
```

### 6. System Validation

The automated system validates:

- [ ] All base variables (PROJECT_ROOT, CLAUDE_DIR) are resolved
- [ ] Path variables construct valid file paths
- [ ] Referenced files exist in project structure
- [ ] Agent files are accessible and properly formatted

### 7. Troubleshooting

#### Variable Not Resolved
- Check if the variable is defined in variables.yml
- Verify the path structure matches your project
- Ensure nested variables are resolved in correct order

#### Path Doesn't Exist
- Confirm your .claude directory location
- Check if the referenced file/directory exists
- Adjust paths for your specific project structure

#### Nested Variable Issues
- Resolve base variables first (PROJECT_ROOT, CLAUDE_DIR)
- Then resolve path variables (paths.*)
- Finally resolve specific file variables (agents.*, commands.*)

### 8. Project Structure Discovery

#### Automatic Discovery Logic
The system looks for these indicators in order:

1. **Project Root Indicators:**
   - `package.json`
   - `Cargo.toml`
   - `go.mod`
   - `pyproject.toml`
   - `requirements.txt`
   - `.git`
   - `README.md`

2. **Claude Directory Search:**
   - Current project root
   - Parent directories (up to 3 levels)
   - Default fallback: `PROJECT_ROOT/.claude`

#### Manual Discovery
```bash
# Find project root
find /path -name "package.json" -o -name ".git" | head -1

# Find .claude directory
find /path -name ".claude" -type d | head -1
```

### 9. System Diagnostics

For debugging variable resolution issues, use these diagnostic commands:

```bash
# Check for variable resolution in agent files
grep -r "{{.*}}" .claude/agents/ --include="*.md"

# Validate variable definitions in config
grep -A 5 -B 5 "^{{" .claude/config/variables.yml

# Check if all expected directories exist
ls -la .claude/ | grep "^d"

# Test path resolution (manual verification)
echo "Base dir: .claude"
echo "Agents dir: .claude/agents"
```

### 10. Integration Points

The automated variable system integrates with:

- **Claude Code workflows** - Variables resolved automatically during execution
- **Agent invocations** - All agents receive resolved variable values
- **Template processing** - Templates are processed with resolved variables
- **File operations** - All file paths use resolved variable values

### 11. Maintenance

#### Updating Variables
1. Modify variables.yml with new/changed variables
2. Update this processing guide
3. Re-process affected files manually
4. Test the changes

#### Adding New Projects
1. Follow project discovery steps
2. Resolve variables for the new structure
3. Update documentation with project-specific notes
4. Verify all paths work correctly

---

**Note:** This markdown-based approach provides better maintainability, transparency, and doesn't require JavaScript execution. All variable processing is done manually with clear documentation of each step.
