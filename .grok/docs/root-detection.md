ROOT_DETECTION_PROTOCOL:

VARIABLE_SYSTEM_FIRST:
- CHECK {{paths.base_dir}} resolved
- IF resolved: USE auto-discovered path
- IF not: FALLBACK to manual detection

MANUAL_DETECTION:
- CHECK current directory for {{paths.base_dir}}
- SEARCH parent directories up to depth 3
- CACHE result for workflow

PATH_RESOLUTION:
- RESOLVE absolute paths
- UPDATE variable system
- VALIDATE directory structure

REQUIRED_STRUCTURE:
{{paths.base_dir}}
├── agents/ ({{system_counts.agents}} files)
├── commands/
├── config/
├── docs/
├── product/
├── specs/
└── templates/

SEARCH_CONFIG:
- DEPTH: 3 parent directories
- PARENT_SEARCH: enabled
- CACHE_RESULTS: enabled

ERROR_RECOVERY:
- NOT_FOUND: Run #sdd-task --init
- INVALID_STRUCTURE: Regenerate missing components
- PERMISSIONS: Check directory access

SECURITY:
- SANDBOX to configured depth
- PREVENT directory traversal
- VALIDATE permissions
