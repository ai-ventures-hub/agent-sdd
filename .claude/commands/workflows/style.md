# sdd-task --style [file_path]

PURPOSE: Theme standards enforcement and compliance checking.

WORKFLOW_STEPS:

1. PARSE_TARGET:
   - file_path: optional (default: scan current context)
   - IF no path → scan referenced files in conversation

2. INVOKE_STYLE_AGENT:
   - {{agents.style}}(mode="scan", target=file_path)
   - Compare against {{paths.standards_dir}}/theme-standards.md
   - Auto-correct minor violations
   - Flag major inconsistencies

3. UPDATE_STANDARDS:
   - IF new patterns detected → update theme-standards.md
   - {{agents.style}}(mode="update_standards")

4. APPLY_CORRECTIONS:
   - {{agents.style}}(mode="apply", violations=detected_issues)
   - Direct file updates for theme compliance

ERROR_HANDLING:
- FILE_NOT_FOUND [ERR_004]
- THEME_COMPLIANCE [ERR_008]