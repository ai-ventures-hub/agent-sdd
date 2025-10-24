# Agent-SDD Agent Architecture

Agent-SDD uses **16 specialized sub-agents** organized into 5 functional categories. Each agent has a specific role in maintaining framework health, managing projects, or executing development workflows.

---

## 📊 Agent Categories Overview

| Category | Count | Purpose |
|----------|-------|---------|
| **Framework Infrastructure** | 5 | Keep framework healthy, validated, and optimized |
| **Framework Evolution** | 1 | Self-improvement and continuous optimization |
| **Project Management** | 2 | Initialize and bootstrap projects |
| **Development Workflow** | 6 | Execute development tasks and maintain quality |
| **Design & Architecture** | 2 | Maintain design consistency and documentation |
| **TOTAL** | **16** | Complete development lifecycle coverage |

---

## 1️⃣ Framework Infrastructure Agents (5)

These agents ensure the framework runs smoothly, maintains integrity, and optimizes performance.

### **logger**
- **Role:** Activity tracking & analytics
- **Purpose:** Maintains changelog.md and logs all activities to JSON Lines format
- **When:** Before and after EVERY command
- **Critical:** ✅ Yes - Provides context awareness across sessions
- **Location:** `.{framework}/agents/logger.md`

### **context_manager**
- **Role:** Performance optimization
- **Purpose:** Caches file contents to reduce redundant I/O operations
- **When:** Every workflow execution
- **Critical:** ✅ Yes - Provides 40-60% performance improvement
- **Location:** `.{framework}/agents/context_manager.md`

### **date_checker**
- **Role:** Temporal consistency
- **Purpose:** Ensures consistent date formatting across all workflows
- **When:** Task creation, logging, schema validation
- **Critical:** ✅ Yes - Prevents schema validation errors
- **Location:** `.{framework}/agents/date_checker.md`

### **agent_registry_validator**
- **Role:** Framework health monitoring
- **Purpose:** Validates agent registry integrity and path variable accessibility
- **When:** Pre-flight checks, `--validate_system`
- **Critical:** ✅ Yes - Framework cannot run without valid registry
- **Location:** `.{framework}/agents/agent_registry_validator.md`

### **analytics_collector**
- **Role:** Metrics & monitoring
- **Purpose:** Collects usage patterns, performance data, and error patterns
- **When:** `--evolve` workflow
- **Critical:** ⚪ Optional - Enhances insights but not required
- **Location:** `.{framework}/agents/analytics_collector.md`

---

## 2️⃣ Framework Evolution Agent (1)

Enables the framework to learn from usage and continuously improve itself.

### **framework_improver**
- **Role:** Self-healing & evolution
- **Purpose:** Analyzes patterns, implements improvements, detects corruption
- **When:** `--evolve` workflow
- **Critical:** ⚪ Optional - Framework works without evolution
- **Features:**
  - Pattern recognition from analytics data
  - Automated framework improvements
  - Corruption detection and self-healing
  - Predictive error prevention
- **Location:** `.{framework}/agents/framework_improver.md`

---

## 3️⃣ Project Management Agents (2)

Handle initial project setup, whether analyzing existing codebases or creating new projects.

### **project_analyzer**
- **Role:** Project profiling
- **Purpose:** Analyzes existing codebases and gathers project context
- **When:** `--init` workflow
- **Critical:** ✅ Yes for --init - Creates overview, roadmap, tech-stack
- **Outputs:**
  - `product/overview.md`
  - `product/roadmap.md`
  - `product/tech-stack.md`
  - `product/best-practices.md`
  - `product/architecture.md`
- **Location:** `.{framework}/agents/project_analyzer.md`

### **project_starter**
- **Role:** Project creation
- **Purpose:** Bootstraps new projects with MCP-powered component setup
- **When:** `--bootstrap` workflow
- **Critical:** ✅ Yes for --bootstrap - Sets up component libraries
- **Features:**
  - MCP integration for shadcn/ui and other frameworks
  - Theme standards generation
  - Project scaffolding
- **Location:** `.{framework}/agents/project_starter.md`

---

## 4️⃣ Development Workflow Agents (6)

The core development engine - from task planning to implementation to quality assurance.

### Task Planning

#### **task_decomposer**
- **Role:** Complexity analysis
- **Purpose:** Breaks complex specifications into manageable tasks with dependencies
- **When:** `--spec`, `--next` workflows
- **Critical:** ✅ Yes - Prevents overly complex tasks
- **Features:**
  - Complexity scoring (0-100)
  - Automatic task breakdown (4-8 tasks for complex specs)
  - Dependency relationship mapping
  - File conflict detection
- **Location:** `.{framework}/agents/task_decomposer.md`

#### **task_schema_validator**
- **Role:** Schema enforcement
- **Purpose:** Validates task objects against the 14-field schema
- **When:** Task creation or modification
- **Critical:** ✅ Yes - Ensures task structure integrity
- **14-Field Schema:**
  - id, type, title, description, status, priority
  - created_date, ux_ui_reviewed, theme_changes, completed_date
  - target_files, dependencies, linked_task, acceptance_criteria
- **Location:** `.{framework}/agents/task_schema_validator.md`

### Code Creation

#### **file_creator**
- **Role:** File generation
- **Purpose:** Creates spec.md, tasks.json, wireframes, and other project files
- **When:** All workflows that generate files
- **Critical:** ✅ Yes - Primary file creation mechanism
- **Capabilities:**
  - Specification documents (spec.md)
  - Task definitions (tasks.json)
  - Design artifacts (wireframe.md, user-journey.md)
  - Template-based file generation
- **Location:** `.{framework}/agents/file_creator.md`

### Quality Assurance

#### **test_runner**
- **Role:** Automated testing
- **Purpose:** Executes tests and validates acceptance criteria
- **When:** `--execute`, `--improve` workflows
- **Critical:** ✅ Yes - Ensures code quality
- **Features:**
  - Test execution across multiple frameworks (Jest, Vitest, Cypress)
  - Acceptance criteria validation
  - Test result analysis
  - Coverage reporting
- **Location:** `.{framework}/agents/test_runner.md`

#### **code_reviewer**
- **Role:** Code quality & compliance
- **Purpose:** Reviews code for theme compliance, accessibility, and quality
- **When:** After code modifications
- **Critical:** ✅ Yes - Enforces standards
- **Checks:**
  - Theme standards compliance (theme-standards.md)
  - WCAG 2.1 AA accessibility
  - Responsive design patterns
  - Code quality and best practices
- **Location:** `.{framework}/agents/code_reviewer.md`

#### **style**
- **Role:** Theme enforcement
- **Purpose:** Scans files against theme-standards.md for compliance
- **When:** `--style` workflow, auto-triggered during execute
- **Critical:** ⚪ Optional - Enhances consistency but not required
- **Features:**
  - Proactive theme validation
  - Auto-updates theme standards when needed
  - Style compliance reporting
- **Location:** `.{framework}/agents/style.md`

---

## 5️⃣ Design & Architecture Agents (2)

Maintain design consistency and living documentation throughout the project lifecycle.

### **designer**
- **Role:** Design consultation & artifacts
- **Purpose:** Creates wireframes, user journeys, and provides theme guidance
- **When:** `--spec` workflow, proactively during `--execute`
- **Critical:** ⚪ Optional - Enhances UX but not required for execution
- **Outputs:**
  - Wireframes (wireframe.md)
  - User journeys (user-journey.md)
  - Theme consultation during implementation
- **Location:** `.{framework}/agents/designer.md`

### **architecture_visualizer**
- **Role:** Living documentation
- **Purpose:** Generates and maintains Mermaid architecture diagrams
- **When:** `--init`, after major changes
- **Critical:** ⚪ Optional - Valuable but not required for execution
- **Features:**
  - Component relationship diagrams
  - Data flow visualizations
  - File structure diagrams
  - Automatic diagram updates
  - Mermaid 10.6.1 syntax
- **Location:** `.{framework}/agents/architecture_visualizer.md`

---

## 🔄 Agent Invocation Patterns

### Always Invoked (Every Command)
These agents run automatically on every `sdd-task` command:
1. **logger** (read mode) - Load context
2. **context_manager** - Initialize cache
3. **date_checker** - Verify temporal consistency
4. *(workflow executes)*
5. **logger** (write mode) - Record activities

### Workflow-Specific Agents

| Workflow | Required Agents |
|----------|----------------|
| `--init` | project_analyzer, file_creator, architecture_visualizer |
| `--bootstrap` | project_starter, file_creator |
| `--next` | task_decomposer, task_schema_validator, file_creator |
| `--spec` | task_decomposer, task_schema_validator, file_creator, designer* |
| `--execute` | file_creator, test_runner, code_reviewer, designer* |
| `--improve` | code_reviewer, test_runner |
| `--edit` | file_creator |
| `--evolve` | analytics_collector, framework_improver |
| `--style` | style |
| `--validate_system` | agent_registry_validator |

*Agents marked with asterisk are invoked proactively

---

## 🎯 Critical vs Optional Agents

### Critical Agents (Framework Cannot Function Without)
Core infrastructure and workflow execution:
- logger
- context_manager
- date_checker
- task_schema_validator
- file_creator
- code_reviewer
- test_runner

### Workflow-Required Agents
Specific workflows fail without these:
- project_analyzer (--init)
- project_starter (--bootstrap)
- task_decomposer (--spec, --next)
- agent_registry_validator (--validate_system)

### Optional Enhancement Agents
Improve experience but not required:
- analytics_collector
- framework_improver
- designer
- architecture_visualizer
- style

---

## 🛠️ Adding New Agents

To add a new agent to the framework:

```bash
# Use the framework's built-in agent scaffolder
@sdd-task --agent my_agent --capabilities file_read,file_write,terminal_exec
```

Or manually create:
1. Create agent file in `.{framework}/agents/my_agent.md`
2. Add frontmatter with universal agent spec
3. Register in `.{framework}/config/variables.yml` under `agents:`
4. Reference in workflow files using `{{agents.my_agent}}`

See `.{framework}/templates/agent-template.md` for the standard structure.

---

## 📚 Agent Capabilities

All agents use universal capabilities that auto-map to platform-specific tools:

| Universal Capability | Claude | Grok | Codex |
|---------------------|--------|------|-------|
| `file_read` | Read | read_file | readFile |
| `file_write` | Write | write_file | writeFile |
| `terminal_exec` | Bash | run_command | execTerminal |
| `search_glob` | Glob | glob_search | findFiles |
| `search_grep` | Grep | grep_search | searchText |
| `task_invoke` | Task | invoke_agent | callAgent |

This universal capability system ensures agents work consistently across all platforms (Claude, Grok, and Codex).

---

## 🔗 Related Documentation

- `.{framework}/docs/error-codes.md` - Comprehensive error handling
- `.{framework}/docs/naming-standards.md` - Conventions and patterns
- `.{framework}/docs/templates-guide.md` - Using framework templates
- `README.md` - Framework overview and quick start

---

**Last Updated:** 2025-10-23
**Framework Version:** 2.0.0
**Total Agents:** 16
