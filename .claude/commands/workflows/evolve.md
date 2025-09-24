# sdd-task --evolve

PURPOSE: Evolve and optimize the Agent-SDD framework via analytics-driven improvements and validation.

WORKFLOW_STEPS:

SEQUENCE_GUARDS:
- PRE_FLIGHT:
  - REQUIRE dispatcher pre-flight validations completed
  - IF not → RETURN {{errors.shared.ERR_014}}
- ORDER_ENFORCEMENT:
  - IF steps executed out of order → RETURN {{errors.shared.ERR_012}}

DEPENDENCIES:
- Requires active .claude framework
- May reference {{paths.changelog_file}} and {{paths.analytics_dir}} data

1. COLLECT_METRICS: {{agents.analytics_collector}}(mode="collect") → usage_stats, perf_data, error_patterns
2. ANALYZE_PATTERNS: {{agents.framework_improver}}(mode="analyze") → bottlenecks, opportunities
3. VALIDATE_FRAMEWORK: {{agents.framework_improver}}(mode="validate") → self_test_report
4. GENERATE_REPORTS: {{agents.analytics_collector}}(mode="report") → health_report, recommendations
5. APPLY_OPTIMIZATIONS: {{agents.framework_improver}}(mode="optimize") → changes_applied
6. EVOLVE_FEATURES: {{agents.framework_improver}}(mode="evolve") → enhancements
7. VALIDATE_CHANGES: {{agents.code_reviewer}}(mode="framework_review") → review_ok
8. UPDATE_DOCUMENTATION: {{agents.file_creator}}(mode="framework_docs") → version_bump, changelog_updates

WORKFLOW_SUCCESS_CRITERIA:
- Framework health score >= 90
- No critical issues introduced
- Performance improvements demonstrated
- Backward compatibility maintained
- Documentation updated and accurate

ERROR_HANDLING:
- {{errors.evolve.ERR_025}}: Framework health check failed
- {{errors.evolve.ERR_026}}: Optimization application failed
- {{errors.evolve.ERR_027}}: Validation tests failed
- {{errors.evolve.ERR_028}}: Documentation update failed

EXECUTION_FREQUENCY:
- Trigger conditions: Error rate spikes, performance degradation, user feedback
- Automated: Can be scheduled or triggered by analytics thresholds

IMPROVEMENT_PRIORITIES:
1. **Critical**: Security fixes, stability improvements, error rate reduction
2. **High**: Performance optimizations, usability enhancements
3. **Medium**: Feature additions, workflow streamlining
4. **Low**: Minor improvements, experimental features

ROLLBACK_MECHANISMS:
- Automatic backup of framework state before changes
- Incremental application with validation checkpoints
- Quick rollback capability for failed improvements
- Impact assessment before permanent deployment

MONITORING_POST_EVOLUTION:
- Track improvement effectiveness and user impact
- Monitor for unintended side effects or regressions
- Collect feedback on implemented changes
- Schedule follow-up evolution cycles based on results

FRAMEWORK_EVOLUTION_METRICS:
- Health score improvement percentage
- Error rate reduction metrics
- Performance improvement measurements
- User satisfaction indicators
- Adoption rate of new features

SUCCESS_OUTPUT:
- health_score: number
- improvements_applied: number
- performance_gain_pct: number
- error_reduction_pct: number
