# {{platform_vars.command_prefix}}sdd-task --style [file_path]

PURPOSE: Theme standards enforcement and compliance checking.

WORKFLOW_STEPS:

1. PARSE_TARGET:
   - file_path: optional (default: scan current context)
   - IF no path → scan referenced files in conversation

2. INVOKE_STYLE_AGENT:
   - READ {{agents.style}} for style guidance
- EXECUTE style using appropriate platform tools
   - Compare against {{paths.theme_standards_file}}
   - Auto-correct minor violations
   - Flag major inconsistencies

3. UPDATE_STANDARDS:
   - IF new patterns detected → update theme-standards.md
   - READ {{agents.style}} for style guidance
- EXECUTE style using appropriate platform tools

4. APPLY_CORRECTIONS:
   - READ {{agents.style}} for style guidance
- EXECUTE style using appropriate platform tools
   - Direct file updates for theme compliance

ERROR_HANDLING:
- FILE_NOT_FOUND [ERR_004]
- THEME_COMPLIANCE [ERR_008]
