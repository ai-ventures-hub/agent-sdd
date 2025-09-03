name: sdd-debug
description: Verbose debugging mode for Agent-SDD troubleshooting with detailed execution traces

## Purpose
Provide comprehensive debugging information during Agent-SDD workflow execution to identify and resolve issues quickly. Shows internal decision-making, data flow, and validation states.

## Instructions

### Debug Output Format
```
[DEBUG] Component::Method - Message
[TRACE] Data state at checkpoint
[ERROR] Failure with stack context
[WARN] Potential issue detected
[INFO] State transition
```

### Agent Invocation Tracing
Show complete agent call chain:
```
[DEBUG] Workflow::execute.md - Starting task BTN-012
├─ [TRACE] Loading workflow from .claude/commands/workflows/execute.md
├─ [INFO] Workflow steps: 7 total, 0 completed
└─ [DEBUG] First agent: logger.md (READ mode)

[DEBUG] Agent::logger.md - Invoked with params:
{
  "mode": "read",
  "context_limit": 10,
  "auto_archive": true
}

[TRACE] Logger output:
{
  "recent_changes": [...],
  "total_entries": 47,
  "context_summary": "Recent focus on button components"
}
```

### File Operation Debugging
Track all file system operations:
```
[DEBUG] FileSystem::Read - Attempting to read tasks.json
├─ Path: .claude/specs/button-enhancement_feature_2024-08-15/tasks.json
├─ Size: 2.3KB
├─ Permissions: rw-r--r--
└─ Last modified: 2024-08-15 14:23:01

[TRACE] File contents (first 200 chars):
{
  "tasks": [
    {
      "id": "BTN-012",
      "type": "feature",
      "title": "Add disabled state",
      ...
    }
  ]
}

[INFO] Successfully parsed JSON with 3 tasks
```

### Task Schema Validation Details
Show field-by-field validation:
```
[DEBUG] TaskValidator::validate - Checking task BTN-012
├─ [✓] id: "BTN-012" (matches pattern: [A-Z]{2,5}-[0-9]{1,4})
├─ [✓] type: "feature" (valid enum value)
├─ [✓] title: "Add disabled state" (length: 18, max: 100)
├─ [✓] description: Present (length: 145)
├─ [✓] status: "in_progress" (valid enum)
├─ [✓] priority: "high" (valid enum)
├─ [✓] created_date: "2024-08-15" (valid format: YYYY-MM-DD)
├─ [✓] ux_ui_reviewed: false (boolean)
├─ [✓] theme_changes: true (boolean)
├─ [✗] completed_date: null (expected for in_progress)
├─ [✓] target_files: ["src/components/Button.tsx"] (array)
├─ [✓] dependencies: [] (valid array)
├─ [✓] linked_task: null (optional)
└─ [✓] acceptance_criteria: 4 items (array)

[INFO] Task validation: PASSED (13/14 fields valid, 1 expected null)
```

### Error Stack Traces
Detailed error context:
```
[ERROR] ThemeCompliance::check - Validation failed
├─ File: src/components/Button.tsx
├─ Line: 45
├─ Column: 12-24
├─ Issue: Missing dark mode color class
│
├─ Expected pattern: bg-[color]-[shade] dark:bg-[color]-[shade]
├─ Found: bg-blue-500
├─ Missing: dark:bg-blue-400
│
├─ Stack trace:
│  ├─ code-reviewer.md:performThemeCheck():line 234
│  ├─ workflow/execute.md:step6():line 67
│  └─ sdd-task:dispatch():line 45
│
└─ Related files checked:
   ├─ theme-standards.md:26 (color definition)
   ├─ decisions.md:78 (dark mode requirement)
   └─ Button.test.tsx:89 (test expecting dark mode)

[DEBUG] Attempting auto-fix...
├─ Analyzing context: 3 lines before, 3 lines after
├─ Pattern match: className prop on line 45
├─ Proposed fix: className="bg-blue-500 dark:bg-blue-400"
└─ Confidence: 95% (direct replacement)
```

### Git Operations Debugging
```
[DEBUG] Git::status - Checking repository state
├─ Branch: feature/BTN-012-disabled-state
├─ Upstream: origin/feature/BTN-012-disabled-state
├─ Status: up-to-date
├─ Modified files: 3
│  ├─ M src/components/Button.tsx
│  ├─ M src/components/Button.test.tsx
│  └─ M .claude/specs/button-enhancement_feature_2024-08-15/tasks.json
└─ Untracked: 0

[TRACE] Diff summary:
├─ Button.tsx: +12 -3 lines
├─ Button.test.tsx: +24 -0 lines
└─ tasks.json: +1 -1 lines (status field)
```

### Test Execution Debugging
```
[DEBUG] TestRunner::execute - Running test suite
├─ Framework: Jest v29.5.0
├─ Config: jest.config.js
├─ Pattern: Button.test.tsx
└─ Environment: jsdom

[TRACE] Test execution:
├─ Test 1: "renders with default props" - PASS (12ms)
├─ Test 2: "handles click events" - PASS (8ms)
├─ Test 3: "applies disabled state" - FAIL (15ms)
│  ├─ Expected: opacity: 0.5
│  ├─ Received: opacity: 1
│  └─ Location: Button.test.tsx:45
├─ Test 4: "meets WCAG contrast" - PASS (23ms)
└─ Summary: 3/4 passed, 1 failed

[DEBUG] Analyzing test failure:
├─ Component prop 'disabled' is passed correctly
├─ Style calculation shows opacity not applied
├─ Likely cause: CSS class condition error
└─ Suggested fix: Check conditional className logic
```

### Workflow State Machine
```
[DEBUG] Workflow::State - Current execution state
┌────────────────────────────────────┐
│ Workflow: execute.md               │
│ Task: BTN-012                      │
│ Started: 2024-08-15 14:30:00      │
│ Elapsed: 00:02:34                 │
├────────────────────────────────────┤
│ Steps:                             │
│ [✓] 1. Resolve task               │
│ [✓] 2. Confirm paths              │
│ [✓] 3. Implement code             │
│ [✓] 4. Git commit                 │
│ [●] 5. Run tests <- CURRENT       │
│ [ ] 6. Theme review               │
│ [ ] 7. Update task state          │
└────────────────────────────────────┘

[TRACE] Step 5 substeps:
├─ [✓] 5.1: Locate test files
├─ [✓] 5.2: Run test suite
├─ [●] 5.3: Analyze failures
└─ [ ] 5.4: Report results
```

### Performance Metrics
```
[DEBUG] Performance::Metrics - Execution timing
├─ Total workflow time: 154.3s
├─ Agent execution breakdown:
│  ├─ logger.md (READ): 0.8s
│  ├─ date-checker.md: 0.2s
│  ├─ task-validator.md: 1.4s
│  ├─ test-runner.md: 45.6s
│  ├─ code-reviewer.md: 3.2s
│  └─ logger.md (WRITE): 0.5s
├─ File operations: 15 reads, 3 writes
├─ Network requests: 0
└─ Cache hits: 4/7 (57%)
```

### Decision Points Logging
```
[DEBUG] Decision::RouteSelection - Choosing implementation approach
├─ Option 1: Modify existing Button component
│  ├─ Pros: Maintains single source of truth
│  ├─ Cons: Risk of breaking existing usage
│  └─ Risk score: 3/10
├─ Option 2: Create DisabledButton wrapper
│  ├─ Pros: Isolation of new behavior
│  ├─ Cons: Code duplication
│  └─ Risk score: 6/10
└─ Selected: Option 1 (lower risk, better maintainability)

[TRACE] Decision factors:
├─ Existing tests: 12 (good coverage)
├─ Component usage: 47 instances found
├─ Complexity: Low (single prop addition)
└─ Rollback plan: Git revert if needed
```

### Data Flow Visualization
```
[DEBUG] DataFlow::TaskUpdate - Tracking data transformation
BTN-012 State Transitions:
1. Initial:    {status: "pending", ux_ui_reviewed: false}
2. Started:    {status: "in_progress", ux_ui_reviewed: false}
3. Coded:      {status: "in_progress", target_files: [...]}
4. Tested:     {status: "in_progress", acceptance_criteria[0]: true}
5. Reviewed:   {status: "in_progress", ux_ui_reviewed: true}
6. Final:      {status: "completed", completed_date: "2024-08-15"}

[TRACE] File modifications at each step:
├─ Step 1-2: tasks.json (status field)
├─ Step 3: Button.tsx, Button.test.tsx
├─ Step 4: tasks.json (acceptance_criteria)
├─ Step 5: tasks.json (ux_ui_reviewed)
└─ Step 6: tasks.json (status, completed_date)
```

### Memory and Resource Tracking
```
[DEBUG] Resources::Usage - System resource consumption
├─ Memory usage: 142MB / 512MB available
├─ CPU usage: 23% (single core)
├─ Disk I/O: 2.3MB read, 0.8MB written
├─ Open file handles: 7
└─ Active processes: 3 (main, test-runner, watcher)
```

### Validation Chain Details
```
[DEBUG] ValidationChain::Execute - Running validation sequence
├─ Pre-execution validations:
│  ├─ [✓] .claude directory exists
│  ├─ [✓] Task ID format valid
│  ├─ [✓] Required agents available
│  └─ [✓] Workflow file readable
├─ During execution:
│  ├─ [✓] File write permissions
│  ├─ [✓] Git repository accessible
│  ├─ [⚠] Test framework configured (using defaults)
│  └─ [✓] Theme standards loaded
└─ Post-execution:
   ├─ [✓] Task state updated
   ├─ [✓] Changelog written
   ├─ [✓] Git commit created
   └─ [✓] All agents reported success
```

## Output Control

### Verbosity Levels
Configure debug detail:
```
[DEBUG:L1] Basic execution flow
[DEBUG:L2] + Data snapshots
[DEBUG:L3] + Full traces and metrics
```

### Filtering
Focus on specific components:
```
# Only show agent-related debug info
[DEBUG:AGENT] ...

# Only show file operations
[DEBUG:FILE] ...

# Only show errors and warnings
[ERROR|WARN] ...
```

## Error Recovery Hints
When errors occur, provide fix suggestions:
```
[ERROR] Task validation failed: missing acceptance_criteria

Suggested fixes:
1. Add acceptance_criteria array to task:
   "acceptance_criteria": ["User can see disabled state", "Keyboard navigation skips disabled"]
   
2. Or mark task as "type": "chore" (doesn't require acceptance criteria)

3. Run: /sdd-task --check BTN-012 --fix
   to auto-populate missing fields
```

## Integration Notes
- Increases output by 300-500% vs normal mode
- Ideal for CI/CD pipeline debugging
- Can be combined with log aggregation tools
- Includes timestamps for all operations
- Preserves debug logs in `.claude/debug/` when configured

## Activation Context
Use this style when:
- Troubleshooting failed workflows
- Debugging agent interactions
- Analyzing performance issues
- Understanding validation failures
- Training on Agent-SDD internals
- Setting up CI/CD pipelines

## Performance Impact
- Token usage: Very high (+400% baseline)
- Execution time: +10-15% due to logging overhead
- Recommended for single task debugging only
- Not suitable for batch operations