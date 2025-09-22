SPEC_DIRECTORY_PATTERN: .claude/specs/{slug}_{type}_{YYYY-MM-DD}/

VALIDATION_REGEX: ^[a-z0-9](?:[a-z0-9-]{0,58}[a-z0-9])?_(feature|enhancement|refactor|fix)_[0-9]{4}-[0-9]{2}-[0-9]{2}$

SLUG_ALGORITHM:
1. NORMALIZE Unicode NFKD, strip diacritics
2. LOWERCASE
3. REPLACE non-alphanumeric sequences with single hyphen
4. COLLAPSE repeated hyphens
5. TRIM leading/trailing hyphens
6. TRUNCATE to 60 chars max
7. FALLBACK: 'task' if empty

TYPE_MAPPING:
- --spec: feature (default)
- --improve enhancement: enhancement
- --improve fix: fix
- --improve refactor: refactor

TASK_ID_PATTERN: {PREFIX}-{NUMBER}[-{SUFFIX}]
- PREFIX: 2-5 uppercase letters from feature name
- NUMBER: 3-digit zero-padded (001, 002)
- SUFFIX: optional sub-task identifier

TASK_ID_REGEX: ^[A-Z]{2,5}-[0-9]{1,4}(-[a-z]+(-[0-9]+)?)?$

DIRECTORY_STRUCTURE:
.claude/specs/{directory-name}/
├── spec.md
├── tasks.json

TYPE_HIERARCHY: feature > enhancement > refactor > fix