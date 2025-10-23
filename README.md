# Agent-SDD: Universal Software Development Framework

Streamlined system for structured software development across Claude, Grok, and Codex platforms, featuring automated variable resolution, comprehensive error handling, workflow dependency enforcement, path validation, framework resilience with self-healing capabilities, living architecture diagrams, and {{system_counts.agents}} specialized sub-agents for reliable execution.

## 🎯 How It Works: Platform Adaptation

Agent-SDD is a framework that automatically adapts to the AI platform you're using (Claude, Grok, or Codex). The framework uses a simple 3-step configuration to switch between platforms:

1. **Directory naming**: `.claude/`, `.grok/`, or `.codex/` contains the framework files
2. **Configuration file**: `.sddrc` with `FRAMEWORK=claude`, `FRAMEWORK=grok`, or `FRAMEWORK=codex`
3. **Instruction file**: `CLAUDE.md`, `GROK.md`, or `CODEX.md` (all contain identical universal instructions)

### Platform Switching is Simple (Only 3 Changes!)
To switch from one AI platform to another (e.g., from Grok to Claude):
```bash
# Step 1: Rename the framework directory
mv .grok .claude

# Step 2: Update the .sddrc file
sed -i 's/FRAMEWORK=grok/FRAMEWORK=claude/' .sddrc

# Step 3: Rename the instruction file
mv GROK.md CLAUDE.md
```

**Note**: All three instruction files (CLAUDE.md, GROK.md, CODEX.md) contain identical content. The different names enable platform-specific auto-detection (e.g., Claude Code automatically loads CLAUDE.md).

The framework then automatically:
- Auto-loads the instruction file (Claude Code detects CLAUDE.md)
- Uses platform-appropriate tools (Read/Write for Claude, read_file/write_file for Grok, etc.)
- Adapts command prefixes (`/` for Claude, `@` for Grok, `#` for Codex)
- Maintains all your project files, specs, and configurations

## Why Agent-SDD
- **Universal orchestration**: {{system_counts.agents}} specialized sub-agents execute strict workflows for repeatable results across Claude, Grok, and Codex
- **Unified command surface**: Platform-specific prefixes (`/sdd-task`, `@sdd-task`, `#sdd-task`) with {{system_counts.workflows}} optimized flags for complete development lifecycle
- **Living architecture diagrams**: Automatic Mermaid diagram generation and maintenance throughout project lifecycle
- **Automated variable system**: Project-agnostic variable resolution with intelligent auto-discovery
- **Workflow dependency enforcement**: Automatic sequencing validation prevents execution errors
- **Comprehensive error handling**: Centralized error codes via `config/variables.yml` for clear failure diagnosis
- **Self-evolving framework**: `--evolve` command enables continuous framework improvement and optimization
- **Framework resilience**: Built-in corruption detection, self-healing, and health checkpoints
- **Analytics-driven insights**: Built-in metrics collection and performance monitoring
- **Flexible bootstrap options**: Standards-based or MCP-powered component library setup
- **Dev-optimized**: No environment switching; concise, agent-focused instructions
- **Conflict-free**: Resolved agent overlaps, error code conflicts, and configuration consolidation
- **Guardrails**: Enforced IDs, directory naming, mandatory agent gates, and pre-flight checks

## Quick Start

### First Time Setup
1. **Configure for your AI platform (3 steps):**
   ```bash
   # For Claude Code users:
   mv .grok .claude                                   # Step 1: Rename directory
   sed -i 's/FRAMEWORK=.*/FRAMEWORK=claude/' .sddrc   # Step 2: Update config
   mv GROK.md CLAUDE.md                               # Step 3: Rename instruction file

   # For Grok users:
   # Already configured if FRAMEWORK=grok

   # For Codex/GitHub Copilot users:
   mv .grok .codex                                    # Step 1: Rename directory
   sed -i 's/FRAMEWORK=.*/FRAMEWORK=codex/' .sddrc    # Step 2: Update config
   mv GROK.md CODEX.md                                # Step 3: Rename instruction file
   ```

2. **Start a new chat session with your AI:**
   - Claude Code automatically loads CLAUDE.md if present
   - For other platforms, paste the instruction file content (GROK.md or CODEX.md)
   - The AI will now recognize `sdd-task` commands

### Quick Platform Switching Script
Save this as `switch-platform.sh` for easy switching:
```bash
#!/bin/bash
# Usage: ./switch-platform.sh [current] [target]
# Example: ./switch-platform.sh grok claude

OLD=${1,,}  # lowercase
NEW=${2,,}  # lowercase

# Step 1: Rename directory
mv .${OLD} .${NEW}

# Step 2: Update config
sed -i "s/FRAMEWORK=${OLD}/FRAMEWORK=${NEW}/" .sddrc

# Step 3: Rename instruction file
mv ${OLD^^}.md ${NEW^^}.md  # uppercase for filenames

echo "✅ Switched from ${OLD} to ${NEW}"
echo "   Directory: .${OLD} → .${NEW}"
echo "   Config: FRAMEWORK=${NEW}"
echo "   Instruction: ${OLD^^}.md → ${NEW^^}.md"
```

### Using the Framework
```bash
# Choose your platform prefix: / (Claude), @ (Grok), # (Codex)

# 1) Initialize project with overview analysis
@sdd-task --init                    # Grok
/sdd-task --init                    # Claude
#sdd-task --init                    # Codex

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

### Add a new agent
```bash
# Universal format (recommended)
sdd-task --agent my_agent --capabilities file_read,file_write,terminal_exec

# Platform-specific formats
/sdd-task --agent my_agent --tools Read,Write,Bash                            # Claude
@sdd-task --agent my_agent --capabilities file_read,file_write,terminal_exec  # Grok
#sdd-task --agent my_agent --capabilities file_read,file_write,terminal_exec  # Codex
```

## Directory Layout (Framework Workspace)
```
.{framework}/         # .claude, .grok, or .codex (auto-detected from .sddrc)
├── agents/           # Sub-agent definitions ({{system_counts.agents}} specialized agents)
├── analytics/        # Framework analytics and metrics
│   ├── history/      # Archived JSON Lines log files
│   ├── logs/         # Active JSON Lines log files
│   │   ├── commands.jsonl  # Command execution logs (single-line JSON)
│   │   └── errors.jsonl    # Error event logs (single-line JSON)
│   ├── metrics.json  # Aggregated usage metrics
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
├── config/           # Variable system configuration
│   ├── config.json       # Runtime settings (development profile)
│   ├── mcp-config.yml    # MCP integration settings
│   └── variables.yml     # Centralized paths, agents, and workflows
├── config.json       # Runtime configuration (single source of truth)
├── docs/
│   ├── error-codes.md
│   ├── naming-standards.md
│   ├── root-detection.md
│   └── templates-guide.md
├── errors/           # Error logs and diagnostics
├── product/          # Generated docs: overview.md, roadmap.md, tech-stack.md, best-practices.md, architecture.md, theme-standards.md
├── settings.local.json # Local configuration overrides
├── specs/            # Generated: task specifications (from --spec/--next)
└── templates/        # Template files for generation (centralized)
    ├── agent-registry-validator.md
    ├── agent-template.md
    ├── architecture.md
    ├── best-practices.md
    ├── overview.md
    ├── roadmap.md
    ├── spec-template.md
    ├── tech-stack.md
    ├── theme-standards.md
    └── wireframe-templates.md
```

## Centralized Variables
- paths: All file paths are centralized in `variables.yml` for maintainability:
  - `{{paths.base_dir}}` - Root framework directory (.claude, .grok, or .codex)
  - `{{paths.product_dir}}` - Generated product docs
  - `{{paths.specs_dir}}` - Generated specifications
  - `{{paths.tech_stack_file}}` - Tech stack documentation
  - `{{paths.best_practices_file}}` - Best practices guide
  - `{{paths.architecture_file}}` - Living architecture diagrams
  - `{{paths.theme_standards_file}}` - Theme standards
  - `{{paths.analytics_dir}}` - Analytics and metrics
  - `{{paths.commands_log}}` - JSON Lines command logs
  - `{{paths.errors_log}}` - JSON Lines error logs
- constraints:
  - task_id_regex: `{{constraints.task_id_regex}}`
  - spec_dir_pattern: `{{constraints.spec_dir_pattern}}`
- errors:
  - shared: `{{errors.shared.ERR_003}}`, `{{errors.shared.ERR_010}}`–`{{errors.shared.ERR_014}}`
  - next/spec docs: `{{errors.next_spec_docs.ERR_004}}`–`{{errors.next_spec_docs.ERR_007}}`
  - bootstrap: `{{errors.bootstrap.ERR_015}}`–`{{errors.bootstrap.ERR_020}}`
  - improve: `{{errors.improve.ERR_021}}`–`{{errors.improve.ERR_024}}`
  - evolve: `{{errors.evolve.ERR_025}}`–`{{errors.evolve.ERR_028}}`
  - architecture: `{{errors.architecture.ERR_045}}`–`{{errors.architecture.ERR_047}}`
- agents: All agent paths are defined under `agents.*` in `variables.yml` and referenced as `{{agents.NAME}}` in workflows.

## Commands ({{system_counts.workflows}} optimized flags)
Workflow definitions are maintained in `.{framework}/config/variables.yml` under the `commands` map. Update that file when workflows change; other files read from the same registry to stay synchronized.

- Authoritative registry: `.{framework}/config/variables.yml` → `commands`
- Dispatcher: `.{framework}/commands/sdd-task.md` consumes the registry
- Documentation: this section intentionally references the registry instead of duplicating the list

## Enforcement (hard rules)
- **Optimized Pre-flight Validation**: Framework integrity validated once during `--init`; subsequent commands use selective health checks for resilience
- **Framework Health Checkpoints**: Critical commands like `--evolve` include corruption detection and self-healing capabilities
- **Workflow Dependencies**: Automatic validation of required files and execution order
- **Unmapped flag**: If flag not found in `variables.yml.commands` → return `ERR_001` (no inference)
- **Agent gates**: Missing logger/context_manager at required gates → `ERR_011`/`ERR_013`
- **Pre-flight/order**: Missing pre-flight → `ERR_014`; steps out of order → `ERR_012`
- **Task ID format**: Enforce regex `{{constraints.task_id_regex}}` (reject underscores) → {{errors.shared.ERR_003}}
- **Spec dir naming**: Enforce `{{constraints.spec_dir_pattern}}` (reject legacy patterns) → {{errors.shared.ERR_003}}

## Agent Architecture

Agent-SDD uses {{system_counts.agents}} specialized sub-agents with universal capabilities that auto-map to platform-specific tools:

### Core Agents
- **date-checker**: Provides consistent date formatting for task schemas
- **logger**: Manages changelog and tracks phase completion
- **context-manager**: Caches file contents and agent results for performance

### Workflow Agents
- **file-creator**: Generates spec.md and tasks.json files with schema validation
- **task-schema-validator**: Validates task objects against 14-field schema
- **test-runner**: Executes tests and analyzes results against acceptance criteria
- **code-reviewer**: Performs quality checks and theme compliance validation
- **agent-registry-validator**: Validates agent registry, path variables, and provides health checkpoints with selective validation modes

### Project Management Agents
- **project-analyzer**: Analyzes existing projects and enhances documentation with technical insights
- **project-starter**: Creates new projects from scratch with MCP-powered component installation
- **designer**: Handles design artifacts and theme consultation
- **task-decomposer**: Analyzes complexity and decomposes complex specs
- **architecture_visualizer**: Generates and maintains living Mermaid architecture diagrams

### Analytics & Evolution Agents
- **analytics-collector**: Collects usage metrics, performance data, and error patterns from JSON Lines logs
- **framework-improver**: Analyzes patterns, implements automated improvements, and provides corruption detection with self-healing capabilities
- **logger**: Manages changelog.md and automatically logs all command executions to JSON Lines format

### Universal Agent Capabilities
Agent capabilities auto-map to platform-specific tools:
- `file_read` → Read (Claude), read_file (Grok), readFile (Codex)
- `file_write` → Write (Claude), write_file (Grok), writeFile (Codex)
- `terminal_exec` → Run_terminal_cmd (Claude), run_command (Grok), execTerminal (Codex)

### JSON Lines Logging Infrastructure
Automatic usage tracking with lean, single-line JSON entries:
- **commands.jsonl**: Every command execution logged with performance metrics, agent usage, and timestamps
- **errors.jsonl**: Error events captured with full context and error codes
- **Auto-archiving**: Files automatically archived when exceeding size limits (1000 lines for commands, 500 for errors)
- **Analytics aggregation**: Raw logs processed into metrics.json for --evolve analysis
- **Historical preservation**: Archived logs maintained for trend analysis

### Performance Optimizations
- **Streamlined agent files**: Optimized content for faster processing
- **Automated variable resolution**: Eliminates manual processing overhead
- **Context caching**: Reduces redundant file operations by 40-60%
- **Selective validation**: Framework validated once during `--init`; subsequent commands use health checkpoints
- **Framework resilience**: Built-in corruption detection and self-healing for uninterrupted operation
- **Workflow dependency validation**: Prevents execution errors before they occur
- **Analytics-driven optimization**: Continuous performance monitoring and improvement via `--evolve`
- **Comprehensive error handling**: 26 categorized error codes for efficient debugging

## Workflow Dependencies

Agent-SDD enforces proper workflow execution order through comprehensive dependency validation:

### Workflow Dependency Matrix
- `--init`: Can run first on any project (no dependencies)
- `--bootstrap`: Can run on empty projects OR after `--init` on existing projects
- `--next`: Requires `{{paths.overview_file}}` and `{{paths.roadmap_file}}`
- `--spec`: Requires product docs + design artifacts (wireframe.md, user-journey.md)
- `--execute`: Requires `{{paths.specs_dir}}/{task}/spec.md` and `tasks.json`
- `--improve` & `--edit`: Independent (can run anytime)
- `--evolve`: Independent (analyzes `{{paths.analytics_dir}}` for framework improvements)

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

### Framework Resilience Errors (ERR_029-030)
- ERR_029: Framework corruption detected, self-healing failed
- ERR_030: Critical path validation failed, framework integrity compromised

### Architecture Errors (ERR_045-047)
- ERR_045: Architecture diagram generation failed
- ERR_046: Architecture file not found
- ERR_047: Mermaid syntax validation failed

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
- **.sddrc**: Framework selection and platform detection
- **variables.yml**: Centralized variable definitions and command routing (framework-agnostic)
- **config.json**: Runtime configuration (development profile, analytics + orchestration toggles)
- **mcp-config.yml**: MCP server configuration for component registries
- **settings.local.json**: Local overrides for command permissions

## Generation Policy
- `.{framework}/product/` and `.{framework}/specs/` start EMPTY
- `--init` (project-analyzer): Generates `product/overview.md`, `product/roadmap.md`, `product/tech-stack.md`, `product/best-practices.md`, `product/architecture.md`
- `--bootstrap` (project-starter): Generates `product/theme-standards.md`
- Choose workflow path after init:
  - New projects: `--bootstrap` (MCP-powered setup for empty directories)
  - Existing projects: `--next` (analyzes roadmap for next phase tasks)
- `--spec`/`--next` generate specification directories in `.{framework}/specs/`
- All generation follows strict naming: `{slug}_{type}_{YYYY-MM-DD}`

## Platform Switching (Details)

The framework is designed to work seamlessly across different AI platforms. Here's exactly how to switch:

### Current Configuration Check
```bash
# Check which platform is currently active
cat .sddrc | grep FRAMEWORK
# Output: FRAMEWORK=codex  (or claude/grok)

# Check which framework directory exists
ls -la | grep "^\." | grep -E "(claude|grok|codex)"
# Output: .codex  (or .claude/.grok)
```

### Switching Platforms (Only 2 Steps!)
**From Codex to Claude:**
```bash
mv .codex .claude
sed -i '' 's/FRAMEWORK=codex/FRAMEWORK=claude/' .sddrc
```

**From Claude to Grok:**
```bash
mv .claude .grok
sed -i '' 's/FRAMEWORK=claude/FRAMEWORK=grok/' .sddrc
```

**From Grok to Codex:**
```bash
mv .grok .codex
sed -i '' 's/FRAMEWORK=grok/FRAMEWORK=codex/' .sddrc
```

**Note**: The `platform-override.json` file now auto-syncs with `.sddrc`, so no manual update needed!

### What Changes When You Switch

| Platform | Directory | Command Prefix | Tools Used | Instruction File |
|----------|-----------|---------------|------------|------------------|
| Claude | `.claude/` | `/sdd-task` | Read, Write, Bash | CLAUDE.md |
| Grok | `.grok/` | `@sdd-task` | read_file, write_file, run_command | GROK.md |
| Codex | `.codex/` | `#sdd-task` | readFile, writeFile, execTerminal | CODEX.md |

### What Stays The Same
- All your project files, specs, and configurations
- Task history and analytics
- Generated documentation (product docs and theme standards)
- The workflow logic and agent specifications

The framework automatically adapts to use the correct tools and syntax for each platform

## Contributing

We welcome contributions! Please see our [Contributing Guide](CONTRIBUTING.md) for details on:

- Reporting issues and requesting features
- Setting up a development environment
- Code style and testing guidelines
- Submitting pull requests
- Development workflow and best practices

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
