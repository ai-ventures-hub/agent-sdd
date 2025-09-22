---
name: evolve-ops
description: Telemetry-driven improvement outputs for Agent-SDD evolution
---

# Evolve Ops

- Emit metrics keys only: usage_stats, perf_data, error_patterns, recommendations.
- No human prose; ensure order with {{errors.shared.ERR_012}} guard.
- Record final status; reference {{errors.evolve.*}} for failures.

