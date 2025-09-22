ERROR_CODES:
- ERR_001: Invalid flag
- ERR_002: Missing required arguments
- ERR_002A: Invalid optional parameter format
- ERR_003: Invalid task schema
- ERR_004: Required file not found
- ERR_005: Task ID not found
- ERR_006: Git operation failed
- ERR_007: Tests failed
- ERR_008: Theme compliance check failed
- ERR_009: Cannot acquire file lock
- ERR_010: Direct file modification detected
- ERR_011: Required agent not invoked
- ERR_012: Workflow steps executed out of order
- ERR_013: Context manager not invoked
- ERR_014: Pre-flight validation failed
- ERR_015: MCP server unreachable
- ERR_016: MCP command execution failed
- ERR_017: Network timeout
- ERR_018: File write failure
- ERR_019: Directory creation failed
- ERR_020: Permission denied
- ERR_021: Invalid workflow type
- ERR_022: High-risk change rejected
- ERR_023: Target not found
- ERR_024: Date format error

FRAMEWORK_CRITICAL: ERR_010-014 (workflows must fail immediately)
INFRASTRUCTURE_ERRORS: ERR_015-017 (require infrastructure fixes)
OPERATION_ERRORS: ERR_018-020 (require permission/access fixes)
VALIDATION_ERRORS: ERR_021-024 (require input corrections)
