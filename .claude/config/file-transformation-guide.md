# Agent-SDD File Transformation Guide (Markdown-Based)

## Overview
This guide replaces the JavaScript transformation utilities with manual, step-by-step instructions for converting hardcoded paths to variable templates and vice versa.

## 1. Directory Path Transformations

### Standard Directory Transformations
Replace these hardcoded paths with variable templates:

#### From:
```markdown
.claude/standards/
.claude/product/
.claude/specs/
.claude/agents/
.claude/templates/
.claude/commands/
```

#### To:
```markdown
{{paths.standards_dir}}/
{{paths.product_dir}}/
{{paths.specs_dir}}/
{{paths.agents_dir}}/
{{paths.templates_dir}}/
{{paths.commands_dir}}/
```

### File Path Transformations
Replace these hardcoded file paths:

#### From:
```markdown
.claude/standards/theme-standards.md
.claude/standards/tech-stack.md
.claude/standards/best-practices.md
.claude/product/overview.md
.claude/product/roadmap.md
.claude/changelog.md
```

#### To:
```markdown
{{paths.standards_dir}}/theme-standards.md
{{paths.standards_dir}}/tech-stack.md
{{paths.standards_dir}}/best-practices.md
{{paths.overview_file}}
{{paths.roadmap_file}}
{{paths.changelog_file}}
```

## 2. Agent File Transformations

### Agent File References
Replace hardcoded agent file paths:

#### From:
```markdown
agents/context-manager.md
agents/date-checker.md
agents/file-creator.md
agents/task-decomposer.md
agents/task-schema-validator.md
agents/test-runner.md
agents/code-reviewer.md
agents/logger.md
agents/project-analyzer.md
agents/project-starter.md
```

#### To:
```markdown
{{agents.context_manager}}
{{agents.date_checker}}
{{agents.file_creator}}
{{agents.task_decomposer}}
{{agents.task_schema_validator}}
{{agents.test_runner}}
{{agents.code_reviewer}}
{{agents.logger}}
{{agents.project_analyzer}}
{{agents.project_starter}}
```

### Workflow File Transformations
Replace hardcoded workflow file paths:

#### From:
```markdown
commands/workflows/init.md
commands/workflows/spec.md
commands/workflows/execute.md
commands/workflows/improve.md
commands/workflows/audit.md
```

#### To:
```markdown
{{commands.init.workflow}}
{{commands.spec.workflow}}
{{commands.execute.workflow}}
{{commands.improve.workflow}}
{{commands.audit.workflow}}
```

## 3. Configuration File Transformations

### Config File References
Replace hardcoded config file paths:

#### From:
```markdown
.claude/config/variables.yml
.claude/config/mcp-config.yml
.claude/config.json
```

#### To:
```markdown
{{paths.config_dir}}/variables.yml
{{mcp.server.url}}
{{paths.config_dir}}/config.json
```

## 4. Transformation Workflow

### Step 1: Prepare Your Environment
1. Open your text editor or IDE
2. Navigate to the `.claude` directory
3. Have the variables.yml file open for reference
4. Create a backup of files before transformation

### Step 2: Transform Workflow Files
Process each workflow file in `commands/workflows/`:

#### Files to Transform:
- [ ] `init.md`
- [ ] `spec.md`
- [ ] `execute.md`
- [ ] `bootstrap.md`
- [ ] Core workflows updated
- [ ] `next.md`

#### Transformation Steps for Each File:
1. Open the workflow file
2. Search for hardcoded paths (see sections 1-3 above)
3. Replace with variable templates
4. Save the file
5. Verify the changes

### Step 3: Transform Agent Files
Process each agent file in `agents/`:

#### Files to Transform:
- [ ] `code-reviewer.md`
- [ ] `context-manager.md` updated
- [ ] `date-checker.md`
- [ ] `file-creator.md`
- [ ] `logger.md`
- [ ] `project-analyzer.md`
- [ ] `project-starter.md`
- [ ] `task-decomposer.md`
- [ ] `task-schema-validator.md`
- [ ] `test-runner.md`

#### Transformation Steps for Each File:
1. Open the agent file
2. Search for hardcoded paths and agent references
3. Replace with variable templates
4. Save the file
5. Verify the changes

### Step 4: Transform Documentation Files
Process documentation files:

#### Files to Transform:
- [ ] `README.md` (if it contains hardcoded paths)
- [ ] `CLAUDE.md` (if it contains hardcoded paths)
- [ ] Any other documentation files

## 5. Batch Transformation Commands

While manual transformation is preferred, you can use these commands to assist:

```bash
# Find all files that need transformation
grep -r "\.claude/" .claude/ --include="*.md" | wc -l

# Preview transformations (dry run)
sed 's|\.claude/standards/|{{paths.standards_dir}}/|g' .claude/commands/workflows/init.md

# Transform directory paths in all workflow files
find .claude/commands/workflows/ -name "*.md" -exec sed -i 's|\.claude/standards/|{{paths.standards_dir}}/|g' {} \;

# Transform agent file references
find .claude/ -name "*.md" -exec sed -i 's|agents/project-analyzer\.md|{{agents.project_analyzer}}|g' {} \;
```

## 6. Variable Resolution Examples

### Example 1: Workflow File Transformation

#### Before:
```markdown
## Initialize Project

1. Route to project analyzer
   - Agent: agents/project-analyzer.md
   - Config: .claude/config/variables.yml

2. Read standards
   - File: .claude/standards/best-practices.md

3. Generate roadmap
   - Output: .claude/product/roadmap.md
```

#### After:
```markdown
## Initialize Project

1. Route to project analyzer
   - Agent: {{agents.project_analyzer}}
   - Config: {{paths.config_dir}}/variables.yml

2. Read standards
   - File: {{paths.standards_dir}}/best-practices.md

3. Generate roadmap
   - Output: {{paths.roadmap_file}}
```

### Example 2: Agent File Transformation

#### Before:
```markdown
# Project Analyzer Agent

## Responsibilities
- Analyze project structure in .claude/product/
- Read standards from .claude/standards/tech-stack.md
- Generate overview at .claude/product/overview.md

## Dependencies
- File: agents/task-decomposer.md
- Config: .claude/config/variables.yml
```

#### After:
```markdown
# Project Analyzer Agent

## Responsibilities
- Analyze project structure in {{paths.product_dir}}/
- Read standards from {{paths.standards_dir}}/tech-stack.md
- Generate overview at {{paths.overview_file}}

## Dependencies
- File: {{agents.task_decomposer}}
- Config: {{paths.config_dir}}/variables.yml
```

## 7. Framework Exclusion Patterns

### Patterns to Keep as Literals
Some paths should NOT be converted to variables because they're intentional exclusions:

#### Framework-Specific Exclusions:
```markdown
# Keep these as literals (do not convert):
node_modules/
.git/
build/
dist/
coverage/
```

#### Intentional Hardcoded Paths:
```markdown
# These are meant to be static:
README.md
package.json
tsconfig.json
```

### When to Use Literal Paths
- Framework-specific directories that should always be excluded
- Well-known configuration files
- Standard project structure files
- Paths that are intentionally static

## 8. Quality Assurance

### Transformation Verification
After transforming each file:

- [ ] All `{{variable}}` templates are properly formatted
- [ ] No leftover hardcoded paths that should be variables
- [ ] File paths are resolvable
- [ ] Cross-references between files are maintained

### Testing Transformations
1. Process files with variable resolution
2. Verify all paths resolve correctly
3. Test that workflows still function
4. Check that agents can find their referenced files

## 9. Rollback Procedures

### If Transformation Goes Wrong
1. Restore from backup
2. Check transformation logs
3. Fix specific issues
4. Re-apply transformation selectively

### Selective Rollback Commands
```bash
# Restore a specific file
git checkout HEAD -- .claude/commands/workflows/init.md

# Check what changed
git diff .claude/commands/workflows/init.md
```

## 10. Maintenance and Updates

### Adding New Variables
When new variables are added to the system:

1. Update variables.yml with new variable definitions
2. Update this transformation guide
3. Transform affected files using the new variables
4. Update validation checklist

### Updating Existing Variables
When variable definitions change:

1. Update variables.yml
2. Identify files using the old variable pattern
3. Transform files to use new variable names
4. Update documentation

## 11. Project-Specific Transformations

### Adapting for Different Project Structures
1. Identify your project's `.claude` directory location
2. Adjust base path variables accordingly
3. Transform files with project-specific paths
4. Document project-specific transformation notes

### Multi-Project Scenarios
1. Maintain separate variable configurations per project
2. Transform files based on each project's structure
3. Keep transformation logs per project
4. Document differences between projects

## 12. Automation Alternatives

While this guide focuses on manual transformation, you can create simple scripts for specific cases:

### Simple Find and Replace Script
```bash
#!/bin/bash
# transform-paths.sh

# Directory transformations
find .claude/ -name "*.md" -exec sed -i 's|\.claude/standards/|{{paths.standards_dir}}/|g' {} \;
find .claude/ -name "*.md" -exec sed -i 's|\.claude/agents/|{{paths.agents_dir}}/|g' {} \;

echo "Basic transformations complete. Manual review recommended."
```

### Validation Script
```bash
#!/bin/bash
# validate-transformations.sh

echo "Checking for remaining hardcoded paths..."
HARD_CODED=$(grep -r "\.claude/" .claude/ --include="*.md" | grep -v "node_modules" | wc -l)

if [ "$HARD_CODED" -gt 0 ]; then
    echo "⚠️  Found $HARD_CODED remaining hardcoded paths"
    grep -r "\.claude/" .claude/ --include="*.md" | grep -v "node_modules"
else
    echo "✅ No hardcoded paths found"
fi
```

## 13. Best Practices

### Transformation Best Practices
- Always backup files before transformation
- Transform files in logical order (workflows first, then agents)
- Test transformations on a single file first
- Review changes before committing
- Document any project-specific customizations

### Maintenance Best Practices
- Keep transformation guide updated
- Document project-specific variations
- Maintain backup of original files
- Use version control for all changes
- Test transformations in development first

---

## Transformation Summary

**Files Processed:** [count]
**Variables Applied:** [count]
**Hardcoded Paths Replaced:** [count]
**Files Requiring Manual Review:** [count]

**Completion Checklist:**
- [ ] All workflow files transformed
- [ ] All agent files transformed
- [ ] Documentation files updated
- [ ] Validation completed
- [ ] Testing successful

**Next Steps:**
1. Run variable processing on transformed files
2. Validate configuration
3. Test workflows and agents
4. Commit changes with descriptive message
