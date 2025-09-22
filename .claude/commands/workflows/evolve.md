# Agent-SDD Evolution Workflow: --evolve

WORKFLOW_DESCRIPTION: Framework self-improvement and optimization cycle. Analyzes usage patterns, identifies bottlenecks, and implements automated improvements.

DEPENDENCIES:
- Requires active Agent-SDD framework
- No specific file dependencies (can run anytime)
- May reference changelog.md and analytics data

WORKFLOW_PHASES:

## PHASE 1: Analytics Collection & Analysis
**Duration**: 2-5 minutes
**Agents**: analytics-collector, framework-improver

1. **COLLECT_METRICS**
   - Task tool subagent_type="analytics-collector" mode="collect"
   - Gather usage statistics, performance data, error patterns
   - Analyze recent framework activity and health indicators

2. **ANALYZE_PATTERNS**
   - Task tool subagent_type="framework-improver" mode="analyze"
   - Identify performance bottlenecks and optimization opportunities
   - Review error trends and systemic issues
   - Assess workflow efficiency and agent performance

## PHASE 2: Framework Health Assessment
**Duration**: 1-3 minutes
**Agents**: framework-improver

3. **VALIDATE_FRAMEWORK**
   - Task tool subagent_type="framework-improver" mode="validate"
   - Run comprehensive framework self-tests
   - Check configuration consistency and integrity
   - Validate agent availability and performance
   - Verify workflow dependencies and error handling

4. **GENERATE_REPORTS**
   - Task tool subagent_type="analytics-collector" mode="report"
   - Create framework health and performance reports
   - Generate optimization recommendations
   - Produce trend analysis and forecasting

## PHASE 3: Automated Improvements
**Duration**: 3-10 minutes
**Agents**: framework-improver, file-creator

5. **APPLY_OPTIMIZATIONS**
   - Task tool subagent_type="framework-improver" mode="optimize"
   - Implement performance optimizations (caching, parallelization)
   - Streamline workflows and reduce unnecessary dependencies
   - Update agent configurations for better performance
   - Apply automated fixes for common issues

6. **EVOLVE_FEATURES**
   - Task tool subagent_type="framework-improver" mode="evolve"
   - Analyze usage patterns to identify feature gaps
   - Propose incremental improvements based on user behavior
   - Implement safe, low-risk enhancements
   - Update framework documentation and configurations

## PHASE 4: Validation & Documentation
**Duration**: 1-2 minutes
**Agents**: code-reviewer, logger

7. **VALIDATE_CHANGES**
   - Task tool subagent_type="code-reviewer" mode="framework_review"
   - Verify framework integrity after changes
   - Ensure backward compatibility and stability
   - Test critical workflows and agent functions

8. **UPDATE_DOCUMENTATION**
   - Task tool subagent_type="file-creator" mode="framework_docs"
   - Update framework version and changelog
   - Document implemented improvements and their impact
   - Generate evolution summary and recommendations

WORKFLOW_SUCCESS_CRITERIA:
- Framework health score >= 90
- No critical issues introduced
- Performance improvements demonstrated
- Backward compatibility maintained
- Documentation updated and accurate

ERROR_HANDLING:
- ERR_025: Framework health check failed
- ERR_026: Optimization application failed
- ERR_027: Validation tests failed
- ERR_028: Documentation update failed

EXECUTION_FREQUENCY:
- Recommended: Weekly or after significant usage periods
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
```
Framework Evolution Complete
==========================
Health Score: 95 (+5 points)
Improvements Applied: 3
Performance Gains: 15% faster execution
Error Reduction: 20% fewer failures
New Features: 1 automated optimization

Next Evolution: Scheduled in 7 days
Recommendations: Monitor cache performance, consider workflow parallelization
```
