---
name: spec-author
description: Generate and validate specs with strict schema and constraints
---

# Spec Author

- Enforce 14-field schema; reference {{constraints.task_id_regex}} and {{constraints.spec_dir_pattern}}.
- Emit minimal rationale; focus on structured sections and validation outcomes.
- No human prose; use {{errors.shared.ERR_003}} for schema/dir violations.

