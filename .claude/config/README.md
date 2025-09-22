# Agent-SDD: Optimized Claude-First Software Development Framework

A conflict-free, streamlined system for structured software development in Claude Code, featuring automated variable resolution, comprehensive error handling, workflow dependency enforcement, and {{system_counts.agents}} specialized sub-agents for reliable execution.

## Why Agent-SDD
- **Claude-first orchestration**: {{system_counts.agents}} specialized sub-agents execute strict workflows for repeatable results
- **Single command surface**: `/sdd-task` with {{system_counts.workflows}} optimized flags for complete development lifecycle
- **Automated variable system**: Project-agnostic variable resolution with intelligent auto-discovery
- **Workflow dependency enforcement**: Automatic sequencing validation prevents execution errors
- **Comprehensive error handling**: Centralized error codes via `config/variables.yml` for clear failure diagnosis
- **Self-evolving framework**: `--evolve` command enables continuous framework improvement and optimization
- **Analytics-driven insights**: Built-in metrics collection and performance monitoring
- **Flexible bootstrap options**: Standards-based or MCP-powered component library setup
- **Dev-optimized**: No environment switching; concise, agent-focused instructions
- **Conflict-free**: Resolved agent overlaps, error code conflicts, and configuration consolidation
- **Guardrails**: Enforced IDs, directory naming, mandatory agent gates, and pre-flight checks

## Quick Start
```bash
# 1) Initialize project with overview analysis
/sdd-task --init

# 2) Choose bootstrap approach:
# For new projects (standards-based or MCP-powered)
/sdd-task --bootstrap              # Review standards for styling
/sdd-task --bootstrap --shadcn     # MCP-powered shadcn/ui setup

# For existing projects (analyze roadmap for next task)
/sdd-task --next                   # Auto-generate next specification

# 3) Execute development tasks
/sdd-task --execute TASK-001       # Implement with testing & quality checks

# 4) Improve or edit as needed
/sdd-task --improve enhancement "Adjust button spacing"
/sdd-task --edit "Fix typo in component"

# 5) Evolve the framework (optional)
/sdd-task --evolve  # Run self-improvement and analytics cycle
```

## Directory Layout (Claude workspace)
```
.claude/
├── agents/           # Sub-agent definitions ({{system_counts.agents}} specialized agents)
├── analytics/        # Framework analytics and metrics
│   ├── history/      # Historical analytics data
│   ├── logs/         # Analytics processing logs
│   ├── metrics.json  # Current framework metrics
│   └── reports/      # Generated analytics reports
├── changelog.md      # Development activity tracking
├── commands/
│   ├── sdd-task.md   # Main command dispatcher
│   └── workflows/    # Workflow definitions
│       ├── bootstrap.md
│       ├── edit.md
│       ├── evolve.md
│       ├── execute.md
│       ├── improve.md
│       ├── init.md
│       ├── next.md
│       └── spec.md
├── config/           # Variable system documentation
│   ├── file-transformation-guide.md
│   ├── mcp-config.yml
│   ├── README.md     # This file
│   ├── variable-processing-guide.md
│   ├── variable-validation-checklist.md
│   └── variables.yml
├── config.json       # Runtime configuration (single source of truth)
├── docs/
│   ├── error-codes.md
│   ├── naming-standards.md
│   ├── root-detection.md
│   └── templates-guide.md
├── errors/           # Error logs and diagnostics
├── product/          # Generated: overview.md, roadmap.md (from --init)
├── settings.local.json # Local configuration overrides
├── specs/            # Generated: task specifications (from --spec/--next)
├── standards/        # Generated: tech-stack.md, theme-standards.md, best-practices.md
└── templates/        # Template files for generation
    ├── best-practices.md
    ├── overview.md
    ├── roadmap.md
    ├── spec-template.md
    ├── tech-stack.md
    ├── theme-standards.md
    └── wireframe-templates.md
```

## Centralized Variables
- constraints:
  - task_id_regex: `{{constraints.task_id_regex}}`
  - spec_dir_pattern: `{{constraints.spec_dir_pattern}}`
- errors:
  - shared: `{{errors.shared.ERR_003}}`, `{{errors.shared.ERR_010}}`–`{{errors.shared.ERR_014}}`
  - next/spec docs: `{{errors.next_spec_docs.ERR_004}}`–`{{errors.next_spec_docs.ERR_007}}`
  - bootstrap: `{{errors.bootstrap.ERR_015}}`–`{{errors.bootstrap.ERR_020}}`
  - improve: `{{errors.improve.ERR_021}}`–`{{errors.improve.ERR_024}}`
  - evolve: `{{errors.evolve.ERR_025}}`–`{{errors.evolve.ERR_028}}`
- agents: All agent paths are defined under `agents.*` in `variables.yml` and referenced as `{{agents.NAME}}` in workflows.

## Commands ({{system_counts.workflows}} optimized flags)
- --init: Initialize project with intelligent analysis and roadmap generation
- --bootstrap: Setup development foundation (standards-based or --shadcn for MCP-powered)
- --next: Analyze roadmap and auto-generate next specification from completed phases
- --spec: Create specification with intelligent task decomposition
- --execute: Implement task with testing, quality checks, and phase completion tracking
- --improve: Apply enhancements, fixes, refactors, accessibility, performance
- --edit: Lightweight edits without full spec overhead
- --evolve: Run framework self-improvement and analytics cycle

## Enforcement (hard rules)
- **Workflow Dependencies**: Automatic validation of required files and execution order
- **Unmapped flag**: If flag not found in `variables.yml.commands` → return `ERR_001` (no inference)
- **Agent gates**: Missing logger/context-manager at required gates → `ERR_011`/`ERR_013`
- **Pre-flight/order**: Missing pre-flight → `ERR_014`; steps out of order → `ERR_012`
- **Task ID format**: Enforce regex `{{constraints.task_id_regex}}` (reject underscores) → {{errors.shared.ERR_003}}
- **Spec dir naming**: Enforce `{{constraints.spec_dir_pattern}}` (reject legacy patterns) → {{errors.shared.ERR_003}}

## Agent Architecture

Agent-SDD uses {{system_counts.agents}} specialized sub-agents following Anthropic's Claude Code sub-agent specification:

### Core Agents
- **date-checker**: Provides consistent date formatting for task schemas
- **logger**: Manages changelog and tracks phase completion
- **context-manager**: Caches file contents and agent results for performance

### Workflow Agents
- **file-creator**: Generates spec.md and tasks.json files with schema validation
- **task-schema-validator**: Validates task objects against 14-field schema
- **test-runner**: Executes tests and analyzes results against acceptance criteria
- **code-reviewer**: Performs quality checks and theme compliance validation

### Project Management Agents
- **project-analyzer**: Analyzes existing projects and enhances documentation with technical insights
- **project-starter**: Creates new projects from scratch with MCP-powered component installation
- **designer**: Handles design artifacts and theme consultation
- **task-decomposer**: Analyzes complexity and decomposes complex specs

### Analytics & Evolution Agents
- **analytics-collector**: Collects usage metrics, performance data, and error patterns
- **framework-improver**: Analyzes patterns and implements automated framework improvements

### Performance Optimizations
- **Streamlined agent files**: Optimized content for faster processing
- **Automated variable resolution**: Eliminates manual processing overhead
- **Context caching**: Reduces redundant file operations by 40-60%
- **Selective validation**: Appropriate validation levels for different operations
- **Workflow dependency validation**: Prevents execution errors before they occur
- **Analytics-driven optimization**: Continuous performance monitoring and improvement via `--evolve`
- **Comprehensive error handling**: 24 categorized error codes for efficient debugging

## Workflow Dependencies

Agent-SDD enforces proper workflow execution order through comprehensive dependency validation:

### Workflow Dependency Matrix
- `--init`: Can run first on any project (no dependencies)
- `--bootstrap`: Can run on empty projects OR after `--init` on existing projects
- `--next`: Requires `.claude/product/overview.md` and `.claude/product/roadmap.md`
- `--spec`: Requires product docs + design artifacts (wireframe.md, user-journey.md)
- `--execute`: Requires `.claude/specs/{task}/spec.md` and `tasks.json`
- `--improve` & `--edit`: Independent (can run anytime)
- `--evolve`: Independent (can run anytime to improve framework health)

### Dependency Types
- **Workflow Dependencies**: Required files and execution order validation
- **Task Dependencies**: Define prerequisite tasks that must complete first
- **File Dependencies**: Prevent conflicts when tasks modify the same files

### Automatic Management
- Dependencies established during intelligent task decomposition
- Circular dependency prevention
- Phase-based execution ordering
- Cached validation for performance
- Pre-flight dependency checking

## Error Codes
### Framework Critical (ERR_010-014)
- ERR_010: Workflow bypass detected
- ERR_011: Missing required agent invocation
- ERR_012: Workflow steps executed out of order
- ERR_013: Context manager not invoked
- ERR_014: Pre-flight validation failed

### Infrastructure Errors (ERR_015-017)
- ERR_015: MCP server unreachable
- ERR_016: MCP command execution failed
- ERR_017: Network timeout

### Operation Errors (ERR_018-020)
- ERR_018: File write failure
- ERR_019: Directory creation failed
- ERR_020: Permission denied

### Validation Errors (ERR_021-024)
- ERR_021: Invalid workflow type
- ERR_022: High-risk change rejected
- ERR_023: Target not found
- ERR_024: Date format error

### Standard Errors (ERR_001-009)
- ERR_001: Invalid flag
- ERR_002: Missing required arguments
- ERR_002A: Invalid parameter format
- ERR_003: Invalid task schema (includes invalid task ID/dir naming)
- ERR_004: Required file not found
- ERR_005: Task ID not found
- ERR_006: Git operation failed
- ERR_007: Tests failed
- ERR_008: Theme compliance check failed
- ERR_009: Cannot acquire file lock

## Configuration
- **variables.yml**: Variable definitions and command routing (automated processing)
- **config.json**: Single source of truth for runtime configuration values
- **mcp-config.yml**: MCP server configuration for component registries
- **file-transformation-guide.md**: File transformation and processing guidelines
- **variable-processing-guide.md**: Automated variable resolution documentation
- **variable-validation-checklist.md**: Configuration validation for automated system
- **README.md**: This comprehensive framework documentation

## Generation Policy
- `.claude/product/`, `.claude/specs/`, `.claude/standards/` start EMPTY
- `--init` (project-analyzer): Generates `standards/tech-stack.md`, `standards/best-practices.md`
- `--bootstrap` (project-starter): Generates `product/overview.md`, `product/roadmap.md`, `standards/theme-standards.md`
- Choose workflow path after init:
  - New projects: `--bootstrap` (MCP-powered setup for empty directories)
  - Existing projects: `--next` (analyzes roadmap for next phase tasks)
- `--spec`/`--next` generate specification directories in `.claude/specs/`
- All generation follows strict naming: `{slug}_{type}_{YYYY-MM-DD}`

## License
MIT