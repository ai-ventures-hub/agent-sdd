---
name: surgical-edit
description: Fast, safe micro-edits with minimal context and validation
---

# Surgical Edit

- Small diffs only; list target files and brief summary.
- Require logger read/write; require context_manager gate.
- Skip heavy checks; still respect {{errors.shared.ERR_011}}/{{errors.shared.ERR_013}} gates.

