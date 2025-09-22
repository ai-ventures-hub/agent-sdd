# Agent-SDD Variable Validation Checklist (Automated System)

## Overview
This checklist documents the automated validation process for Agent-SDD variable configurations. Use this to verify that your variable system is properly configured for automated resolution.

## 1. Configuration File Structure Validation

### Required Sections
- [ ] `paths` section exists
- [ ] `agents` section exists
- [ ] `commands` section exists
- [ ] `config` section exists
- [ ] `framework` section exists
- [ ] `errors` section exists

### Optional Sections
- [ ] `mcp` section exists (if using MCP features)
- [ ] `templates` section exists (if using templates)

## 2. Path Variables Validation

### Base Directory Validation
- [ ] `paths.base_dir` is defined
- [ ] `paths.base_dir` uses `{{CLAUDE_DIR}}` placeholder
- [ ] `paths.base_dir` resolves to valid directory path

### Subdirectory Validation
- [ ] `paths.product_dir` uses `{{paths.base_dir}}/product`
- [ ] `paths.standards_dir` uses `{{paths.base_dir}}/standards`
- [ ] `paths.specs_dir` uses `{{paths.base_dir}}/specs`
- [ ] `paths.agents_dir` uses `{{paths.base_dir}}/agents`
- [ ] `paths.templates_dir` uses `{{paths.base_dir}}/templates`
- [ ] `paths.commands_dir` uses `{{paths.base_dir}}/commands`
- [ ] `paths.workflows_dir` uses `{{paths.commands_dir}}/workflows`
- [ ] `paths.config_dir` uses `{{paths.base_dir}}/config`

### Core File Validation
- [ ] `paths.overview_file` uses `{{paths.product_dir}}/overview.md`
- [ ] `paths.roadmap_file` uses `{{paths.product_dir}}/roadmap.md`
- [ ] `paths.changelog_file` uses `{{paths.base_dir}}/changelog.md`

### Project-Aware Path Validation
- [ ] `paths.project_root` uses `{{PROJECT_ROOT}}`
- [ ] `paths.current_dir` uses `{{CURRENT_DIR}}`

## 3. Agent Variables Validation

### Core Initialization Agents
- [ ] `agents.project_analyzer` uses `{{paths.agents_dir}}/project-analyzer.md`
- [ ] `agents.project_starter` uses `{{paths.agents_dir}}/project-starter.md`

### Task Management Agents
- [ ] `agents.task_decomposer` uses `{{paths.agents_dir}}/task-decomposer.md`
- [ ] `agents.task_schema_validator` uses `{{paths.agents_dir}}/task-schema-validator.md`

### Content Creation Agents
- [ ] `agents.file_creator` uses `{{paths.agents_dir}}/file-creator.md`

### Utility Agents
- [ ] `agents.context_manager` uses `{{paths.agents_dir}}/context-manager.md`
- [ ] `agents.date_checker` uses `{{paths.agents_dir}}/date-checker.md`
- [ ] `agents.logger` uses `{{paths.agents_dir}}/logger.md`

### Quality Assurance Agents
- [ ] `agents.test_runner` uses `{{paths.agents_dir}}/test-runner.md`
- [ ] `agents.code_reviewer` uses `{{paths.agents_dir}}/code-reviewer.md`

## 4. Command Configuration Validation

### Base Command
- [ ] `commands.base_command` is "/sdd-task"

### Command Definitions
Each command must have:
- [ ] `flag` property (starts with --)
- [ ] `description` property (non-empty string)
- [ ] `workflow` property (uses `{{paths.workflows_dir}}/*.md`)

#### Individual Commands
- [ ] `commands.init` has valid flag, description, and workflow
- [ ] `commands.spec` has valid flag, description, and workflow
- [ ] `commands.execute` has valid flag, description, and workflow
- [ ] `commands.improve` has valid flag, description, and workflow

## 5. Runtime Configuration Validation (config.json)

### Complexity Thresholds
- [ ] `task_decomposer.complexity_threshold_high` is number (0-100)
- [ ] `task_decomposer.complexity_threshold_medium` is number (0-100)
- [ ] High > Medium ordering is maintained

### Task Limits
- [ ] `task_decomposer.max_tasks_per_decomposition` is number ≥ 1
- [ ] `task_decomposer.default_task_priority` is valid priority

### Schema Requirements
- [ ] `validation.default_mode` is one of: "strict", "lenient", "full"
- [ ] `validation.light_mode_fields` is array

### System Timeouts
- [ ] Lock timeout values are reasonable (> 0)
- [ ] Analysis timeout values are practical (> 10)

### Quality Thresholds
- [ ] `test.coverage_thresholds.branches` is number (0-100)
- [ ] `test.coverage_thresholds.functions` is number (0-100)
- [ ] Accessibility scores are reasonable (0-100)

## 6. Framework Settings Validation

### Testing Frameworks
- [ ] `framework.testing_frameworks` is array
- [ ] `framework.testing_frameworks` contains at least one framework
- [ ] Supported frameworks: "jest", "vitest", "mocha"

### Boilerplate Types
- [ ] `framework.boilerplate_types` is array
- [ ] `framework.boilerplate_types` contains at least one type
- [ ] Supported types: "shadcn", "antd", "mui", "chakra", "tailwind"

### File Extensions
- [ ] `framework.extensions` exists
- [ ] `framework.extensions.typescript` is array with [".ts", ".tsx"]
- [ ] `framework.extensions.javascript` is array with [".js", ".jsx"]
- [ ] `framework.extensions.python` is array with [".py"]
- [ ] `framework.extensions.go` is array with [".go"]
- [ ] `framework.extensions.rust` is array with [".rs"]

## 7. Error Code Validation

### Error Registry
- [ ] `errors` section exists
- [ ] All error codes follow pattern: ERR_XXX
- [ ] All error messages are non-empty strings

#### Required Error Codes
- [ ] `errors.ERR_001` exists ("Invalid flag. Use /sdd-task --help for options.")
- [ ] `errors.ERR_002` exists ("Missing required arguments")
- [ ] `errors.ERR_002A` exists ("Invalid parameter format")
- [ ] `errors.ERR_003` exists ("Invalid task schema")
- [ ] `errors.ERR_004` exists ("Required file not found")
- [ ] `errors.ERR_005` exists ("Task ID not found")
- [ ] `errors.ERR_006` exists ("Git operation failed")
- [ ] `errors.ERR_007` exists ("Tests failed")
- [ ] `errors.ERR_008` exists ("Theme compliance check failed")
- [ ] `errors.ERR_009` exists ("Cannot acquire file lock")

## 8. MCP Configuration Validation (Optional)

### Server Configuration
- [ ] `mcp.server` exists (if MCP used)
- [ ] `mcp.server.name` is non-empty string
- [ ] `mcp.server.url` uses `{{paths.config_dir}}/mcp-config.yml`
- [ ] `mcp.server.connection_timeout` is number ≥ 1
- [ ] `mcp.server.retries` is number ≥ 0

### Registry Endpoints
- [ ] `mcp.registries` exists (if MCP used)
- [ ] `mcp.registries.primary` is valid URL
- [ ] `mcp.registries.components` is valid URL template
- [ ] `mcp.registries.blocks` is valid URL template

### MCP Commands
- [ ] `mcp.commands` exists (if MCP used)
- [ ] All command templates are non-empty strings
- [ ] Templates use proper placeholder syntax

## 9. Template Configuration Validation (Optional)

### Project Templates
- [ ] `templates.project` exists (if templates used)
- [ ] `templates.project.overview` uses `{{paths.templates_dir}}/overview.md`
- [ ] `templates.project.roadmap` uses `{{paths.templates_dir}}/roadmap.md`
- [ ] `templates.project.standards` uses `{{paths.templates_dir}}/standards/`

### UI Components
- [ ] `templates.ui_components` exists (if templates used)
- [ ] `templates.ui_components.source` is "shadcn-registry"

## 10. Cross-Section Validation

### Variable Dependencies
- [ ] All `{{variable}}` references point to defined variables
- [ ] No circular dependencies in variable resolution
- [ ] Base variables (PROJECT_ROOT, CLAUDE_DIR) are properly used

### Path Consistency
- [ ] All paths use forward slashes (/) for consistency
- [ ] Relative paths are correct from their usage context
- [ ] No hardcoded paths that should use variables

### Business Rules
- [ ] Complexity thresholds follow logical ordering
- [ ] Task limits are within reasonable ranges
- [ ] Quality thresholds are achievable percentages
- [ ] Timeout values are practical for operations

## 11. File Path Validation

### Directory Existence
- [ ] All referenced directories exist in project structure
- [ ] Parent directories are created before child directories
- [ ] Paths are accessible from the project's root

### File References
- [ ] All referenced .md files exist
- [ ] File extensions match their intended use
- [ ] Paths are resolvable from their usage context

### Directory Structure Validation
- [ ] `.claude/` directory exists and contains required subdirectories
- [ ] `agents/`, `commands/`, `config/`, `docs/`, `templates/` exist in `.claude/`
- [ ] Runtime directories created as needed: `product/`, `standards/`, `specs/`
- [ ] All directories are within `.claude/` structure (no root-level creation)

### System Counts Validation
- [ ] `system_counts.agents` matches actual agent files in agents/ directory
- [ ] `system_counts.workflows` matches workflow files in commands/workflows/
- [ ] `system_counts.templates` matches template files in templates/ directory
- [ ] `system_counts.error_codes` matches error codes in docs/error-codes.md

## 12. Environment-Specific Validation

### Development Configuration
- [ ] `environments/dev.yml` exists
- [ ] Lower complexity thresholds for aggressive decomposition
- [ ] More permissive validation rules
- [ ] Additional debug logging enabled

### Staging Configuration
- [ ] `environments/staging.yml` exists
- [ ] Balanced thresholds between dev and prod
- [ ] Moderate validation strictness
- [ ] Standard logging levels

### Production Configuration
- [ ] `environments/prod.yml` exists
- [ ] Higher complexity thresholds for conservative decomposition
- [ ] Strict validation rules
- [ ] Minimal logging for performance

## 13. Validation Commands

Use these commands to diagnose variable resolution issues:

```bash
# Check for undefined variables
grep -r "{{[^}]*}}" .claude/config/ --include="*.yml"

# Count total variables in config
grep -c "{{" .claude/config/variables.yml

# Find potential path issues
grep -r "\.\./\|\./" .claude/config/ --include="*.yml"

# Validate YAML syntax
python3 -c "import yaml; yaml.safe_load(open('.claude/config/variables.yml'))"
```

## 14. Post-Validation Checklist

After completing validation:
- [ ] All checkboxes above are marked
- [ ] No validation errors remain
- [ ] Configuration loads without syntax errors
- [ ] Variable resolution works correctly
- [ ] All file paths are accessible
- [ ] Cross-references between sections are valid

## 15. Documentation Updates

When validation is complete:
- [ ] Update this checklist with any new validation rules
- [ ] Document any project-specific validation requirements
- [ ] Add examples for common validation failures
- [ ] Include troubleshooting steps for validation issues

---

**Validation Summary:**
- ✅ **Sections Checked:** [count]
- ✅ **Variables Validated:** [count]
- ✅ **Errors Found:** [count]
- ✅ **Warnings:** [count]

**Next Steps:**
1. Fix any validation errors found
2. Address warnings if applicable
3. Test configuration in actual usage
4. Update documentation as needed
