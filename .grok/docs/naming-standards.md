SPEC_DIRECTORY_PATTERN: {{paths.specs_dir}}/{slug}_{type}_{YYYY-MM-DD}/

**Components:**
- `slug`: URL-safe identifier (see Slug Algorithm below)
- `type`: Work type (feature|enhancement|refactor|fix)
- `YYYY-MM-DD`: Creation date

**Examples:**
```
{{paths.specs_dir}}/user-authentication_feature_2025-10-02/
{{paths.specs_dir}}/dark-mode-enhancement_2025-10-01/
{{paths.specs_dir}}/refactor-api-refactor_2025-09-30/
{{paths.specs_dir}}/bug-fix-fix_2025-09-29/
```

### Validation Regex
```
VALIDATION_REGEX: ^[a-z0-9](?:[a-z0-9-]{0,58}[a-z0-9])?_(feature|enhancement|refactor|fix)_[0-9]{4}-[0-9]{2}-[0-9]{2}$
```

This regex ensures:
- Starts and ends with alphanumeric character
- Only lowercase letters, numbers, and single hyphens
- Valid type suffix
- Proper date format
- Maximum 60 characters for slug portion

## Slug Algorithm

### Step-by-Step Process
1. **NORMALIZE**: Unicode NFKD normalization, strip diacritics
2. **LOWERCASE**: Convert all characters to lowercase
3. **REPLACE**: Non-alphanumeric sequences → single hyphen
4. **COLLAPSE**: Multiple consecutive hyphens → single hyphen
5. **TRIM**: Remove leading/trailing hyphens
6. **TRUNCATE**: Limit to 60 characters maximum
7. **FALLBACK**: Use 'task' if result is empty

### Examples
```
Input: "User Authentication & Login"
1. Normalize: "User Authentication & Login"
2. Lowercase: "user authentication & login"
3. Replace: "user-authentication-login"
4. Collapse: "user-authentication-login"
5. Trim: "user-authentication-login"
6. Truncate: "user-authentication-login" (fits)
Output: "user-authentication-login"

Input: "API Réfactoring (v2.0)!!!"
1. Normalize: "API Refactoring (v2.0)!!!"
2. Lowercase: "api refactoring (v2.0)!!!"
3. Replace: "api-refactoring-v2-0"
4. Collapse: "api-refactoring-v2-0"
5. Trim: "api-refactoring-v2-0"
6. Truncate: "api-refactoring-v2-0" (fits)
Output: "api-refactoring-v2-0"
```

## Type Mapping

### Command to Type Mapping
```
--spec: feature (default)
--improve enhancement: enhancement
--improve fix: fix
--improve refactor: refactor
```

### Type Hierarchy (Priority Order)
```
feature > enhancement > refactor > fix
```
Higher-priority types take precedence in scheduling and resource allocation.

### Type Descriptions
- **feature**: New functionality or major additions
- **enhancement**: Improvements to existing features
- **refactor**: Code restructuring without functional changes
- **fix**: Bug fixes and corrections

## Task ID Pattern

### Structure
```
TASK_ID_PATTERN: {PREFIX}-{NUMBER}[-{SUFFIX}]
```

**Components:**
- `PREFIX`: 2-5 uppercase letters from feature name
- `NUMBER`: 3-digit zero-padded (001, 002, etc.)
- `SUFFIX`: Optional sub-task identifier

### Examples
```
AUTH-001          # Basic task
UI-015            # Higher numbered task
API-002-auth      # Sub-task with suffix
DB-045-migration  # Complex sub-task
```

### Validation Regex
```
TASK_ID_REGEX: ^[A-Z]{2,5}-[0-9]{1,4}(-[a-z]+(-[0-9]+)?)?$
```

This ensures:
- 2-5 uppercase letters for prefix
- 1-4 digits for number
- Optional lowercase suffix with possible number

DIRECTORY_STRUCTURE:
{{paths.specs_dir}}/{directory-name}/
├── spec.md
├── tasks.json

### File Naming Within Specs
- `spec.md`: Always lowercase, standard name
- `tasks.json`: Always lowercase, standard name
- Assets: Use descriptive names with kebab-case

## Implementation Notes

### Platform Considerations
- **Claude**: Automatic validation during sub-agent orchestration
- **Grok adapter**: Manual validation during sequential execution
- **Codex**: VS Code integration with real-time validation

### Automation Integration
- **File Creator Agent**: Uses these patterns for directory creation
- **Task Schema Validator**: Validates task IDs against regex
- **Project Analyzer**: Applies slug algorithm to project names
- **Logger**: Records naming convention adherence

### Error Handling
Invalid naming triggers these errors:
- `ERR_003`: Invalid task schema (includes naming violations)
- `ERR_008`: Directory pattern validation failed
- `ERR_023`: Target not found (due to naming mismatches)

## Migration Guide

### From Legacy Naming
If upgrading from older Agent-SDD versions:

1. **Task IDs**: Convert to new format (e.g., `TASK_001` → `TASK-001`)
2. **Directories**: Rename using current pattern
3. **Validation**: Run `--validate_system` to check compliance
4. **Migration**: Use `--improve refactor` for bulk renaming

### Tool Support
```bash
# Validate current naming
sdd-task --validate_system

# Fix naming issues
sdd-task --improve refactor "Standardize naming conventions"

# Create new spec with proper naming
sdd-task --spec "Feature description"
```

---

*These naming standards ensure consistent, automated workflows across all supported platforms.*
