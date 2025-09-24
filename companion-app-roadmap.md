# Agent-SDD Dashboard - Visual File Manager

## Executive Summary

**Agent-SDD Dashboard** is a desktop application that provides a visual interface for managing Agent-SDD project files. It includes a simple setup wizard to install the Agent-SDD framework, then serves as an editor and viewer for the files that Claude generates through Agent-SDD commands.

**Target Users**: Developers who want to easily view, edit, and manage Agent-SDD project files without directly editing markdown.

**Core Value Proposition**: "Visual file management for Agent-SDD - see your project structure, edit files, and track progress at a glance."

---

## Simple MVP

### Setup Wizard
**Goal**: Simple installation of Agent-SDD framework files

**Deliverables**:
[ ] One-click Agent-SDD framework installation
[ ] .claude directory creation with CLAUDE.md at the root
[ ] Framework health verification

### Project Discovery
**Goal**: Scan directories and discover Agent-SDD projects

**Deliverables**:
[ ] Directory browser to select project root directories
[ ] Automatic .claude folder detection across selected directories
[ ] Project card grid displaying discovered Agent-SDD projects
[ ] Basic project info display (name, path, last modified)

### File Viewer
**Goal**: Basic viewing of Agent-SDD project files

**Deliverables**:
[ ] Project file browser (.claude directory structure)
[ ] Markdown file viewer with syntax highlighting
[ ] Basic file structure visualization
[ ] File status indicators (exists/edited/modified)

### File Editor
**Goal**: Simple editing capabilities for Agent-SDD files

**Deliverables**:
[ ] In-app markdown editor for project files
[ ] Basic validation for Agent-SDD file formats
[ ] Save/load project file changes
[ ] Edit history and basic undo/redo

### Settings & Preferences
**Goal**: Comprehensive settings page for app configuration and subscription management

**Deliverables**:
[ ] Basic app settings (theme, UI preferences, startup options)
[ ] Visual theme customization via [tweakcn.com](https://tweakcn.com/) integration
[ ] Theme import/export with CSS variables support (light/dark mode, color schemes, typography)
[ ] Live theme preview and one-click application across the entire app
[ ] Agent-SDD framework configuration (default paths, validation settings)
[ ] Subscription management (license status, renewal reminders, update access)
[ ] Data management (backup/restore, data export, cache clearing)
[ ] Project discovery settings (scan paths, exclusions, auto-discovery)
[ ] AI settings (LLM provider configuration, API key management, model preferences)
[ ] Update management (check for updates, download/install, version history)

### Project Stats Dashboard
**Goal**: Detailed project statistics and health overview

**Deliverables**:
[ ] Comprehensive project stats (file counts, completion rates, health score)
[ ] File-by-file status breakdown with actionable insights
[ ] Project timeline showing creation and modification dates
[ ] Agent-SDD workflow completion tracking
[ ] Framework system stats integration (parse variables.yml system_counts)
[ ] Recommendations for next steps (--init usage, missing files, etc.)

---

## Phase 2: Advanced Management Features

### Enhanced Editing
**Goal**: Better file editing and management capabilities

**Deliverables**:
[ ] Rich markdown editor with live preview
[ ] Template insertion for common Agent-SDD sections
[ ] File comparison and diff viewing across projects
[ ] Batch file operations and multi-project organization

### Multi-Project Management
**Goal**: Advanced features for managing multiple Agent-SDD projects

**Deliverables**:
[ ] Cross-project search and content discovery
[ ] Project comparison and health benchmarking
[ ] Bulk operations across multiple projects
[ ] Project templates and duplication features
[ ] Framework system statistics dashboard (parse variables.yml)
[ ] System health monitoring and Agent-SDD framework insights
[ ] AI system helper integration with popular LLM SDKs

### Agent Creation Studio
**Goal**: Visual agent scaffolding and framework extension capabilities

**Deliverables**:
[ ] Agent creation wizard with guided setup (name, description, tools, capabilities)
[ ] Template selection from existing agent patterns (analyzer, creator, reviewer, etc.)
[ ] Tool configuration interface (Read, Write, Run_terminal_cmd, etc.)
[ ] Agent validation and registry integration
[ ] One-click agent deployment to .claude/agents/ directory
[ ] Framework refresh and agent registry update
[ ] Agent testing interface with sample invocations

### Workflows Command Generator
**Goal**: Interactive workflow discovery and command prompt generation for Claude integration

**Deliverables**:
[ ] Workflow cards grid displaying all 11 Agent-SDD workflows in logical execution order (--init → --bootstrap → --next → --spec → --execute → --improve → --edit → --evolve → --agent → --style → --validate_system)
[ ] Command generation wizards with guided forms for each workflow type
[ ] Context-aware argument collection (project paths, task IDs, enhancement descriptions)
[ ] Dependency validation showing required files/workflows before command execution
[ ] Generated prompt preview with proper Claude formatting and workflow guidance
[ ] One-click copy to clipboard for seamless Claude integration
[ ] Workflow history and favorites for frequently used command patterns
[ ] Smart suggestions based on current project state and available files

### Workflow Creation Wizard
**Goal**: Visual workflow scaffolding and system extension capabilities

**Deliverables**:
[ ] Workflow creation wizard with guided setup (name, description, triggers, sequence)
[ ] Template selection from existing workflow patterns (project-setup, task-execution, quality-assurance, etc.)
[ ] Agent orchestration interface for defining workflow steps and agent invocations
[ ] Dependency mapping and validation rules configuration
[ ] Workflow testing interface with simulation and validation
[ ] One-click workflow deployment to .claude/commands/workflows/ directory
[ ] Framework refresh and workflow registry update
[ ] Integration with existing workflow command generator

### Specifications Management View
**Goal**: Visual task management and specification tracking for Agent-SDD projects

**Deliverables**:
[ ] Specifications browser showing all spec.md files from .claude/specs/ directory
[ ] Task cards display with complete task information from tasks.json (id, title, description, status, priority, etc.)
[ ] Kanban board layout with columns for task statuses (pending, in_progress, completed, cancelled)
[ ] Interactive task editing with form validation for all 14 task schema fields
[ ] Drag-and-drop task status updates within the Kanban board
[ ] Task dependency visualization showing prerequisite relationships
[ ] Bulk task operations (status updates, priority changes, assignments)
[ ] Task filtering and search by status, priority, type, or assignee

### Project Health Dashboard
**Goal**: Intelligent project insights and health monitoring for Agent-SDD projects

**Deliverables**:
[ ] Visual health score with circular progress indicators for project phases
[ ] File status grid showing existence, modification status, and missing files
[ ] Framework metrics display parsing variables.yml system counts (15 agents, 11 workflows, 41 error codes)
[ ] Actionable recommendations based on project state (e.g., "Run --init to generate overview.md")
[ ] Project timeline showing file creation and modification dates
[ ] Quick stats panel with file counts, project age, and activity timestamps
[ ] Health trend indicators for framework stability and project completeness

---

## Technical Requirements

### Core Technology Stack
**Tauri**: For native desktop app (Rust backend, web frontend)
**React + TypeScript**: For the GUI components
**shadcn/ui**: **REQUIRED** - All UI components must be built using shadcn/ui library for consistency, accessibility, and centralized theming
**Tailwind CSS**: For utility-first styling with CSS variables support
**SQLite**: For storing project data, user preferences, and task management
**File System APIs**: For reading/writing Agent-SDD project files and specs

### Key Implementation Points
1. **Project Discovery**: Scan file systems for .claude directories and validate Agent-SDD projects
2. **Multi-Project Management**: Handle multiple Agent-SDD projects simultaneously with proper isolation
3. **File Management**: Read/write Agent-SDD project files across different project locations
4. **Project Analytics**: Calculate health scores, completion rates, and actionable insights
5. **System Stats Integration**: Parse variables.yml to extract and display framework statistics
6. **YAML Processing**: Use YAML parser to read system_counts and other configuration data
7. **Theme System**: Centralized CSS variables with [tweakcn.com](https://tweakcn.com/) integration for visual customization
8. **AI SDK Integration**: Popular LLM SDK for AI assistance (Vercel AI, LangChain, etc.)
9. **Secure API Management**: Encrypted storage and management of LLM API keys
10. **Subscription Management**: License validation, renewal tracking, and update access control
11. **Real-time Sync**: Monitor file changes across multiple projects and update UI accordingly

### Development Approach
Focus on file I/O operations and project discovery, not content generation
Build around Agent-SDD's existing file structure and validation patterns
Ensure proper project isolation while allowing cross-project operations
Integrate system statistics parsing for enhanced dashboard insights
Add secure AI SDK integration for intelligent assistance features
Test with multiple real Agent-SDD project structures from the beginning

---

## Success Criteria

### MVP Success
[ ] Users can install Agent-SDD framework with one-click wizard
[ ] Dashboard can discover and display Agent-SDD projects in card grid
[ ] Clicking project cards shows detailed stats and health metrics
[ ] Users can view and edit markdown files in the app
[ ] Comprehensive settings page manages app configuration and subscription
[ ] Project dashboard provides actionable insights

### Phase 2 Success
[ ] Rich editing experience with templates and validation
[ ] Powerful search finds content across all discovered projects
[ ] Multi-project management enables seamless workflow across projects
[ ] System statistics dashboard displays Agent-SDD framework metrics
[ ] Advanced analytics provide insights across entire Agent-SDD ecosystem
[ ] Dashboard becomes the central hub for all Agent-SDD project management

### Phase 3 Success
[ ] AI system helper successfully connects to multiple LLM providers
[ ] Context-aware AI assistance enhances file editing workflow
[ ] Intelligent Agent-SDD workflow recommendations improve productivity
[ ] AI-powered content generation accelerates project development
[ ] Natural language queries provide intuitive project insights

---

## Business Model: Annual Subscription

**Standalone Desktop App**: One-time annual payment for access to updates and new features
- **Yearly License**: Users pay annually to receive updates and new features
- **Lifetime Access**: App continues to work even without renewal (no forced obsolescence)
- **Graceful Degradation**: App remains functional but new features require active subscription
- **Transparent Pricing**: Clear communication about what requires active subscription

**Subscription Features**:
- **Update Access**: Download new versions with bug fixes and improvements
- **New Features**: Access to advanced features as they're developed
- **Priority Support**: Enhanced support for active subscribers
- **Community Access**: Access to user community and shared resources

**Settings Integration**:
- **License Status Display**: Current subscription status and expiration date
- **Renewal Reminders**: Notifications when subscription is approaching expiry
- **Update Management**: Check for and install updates based on subscription status
- **Feature Gating**: Clear indicators of which features require active subscription

---

## Phase 3: AI Integration & Intelligence

### AI System Helper Foundation
**Goal**: Integrate AI assistance capabilities using popular SDK frameworks

**Deliverables**:
[ ] Popular LLM SDK integration (Vercel AI SDK, LangChain, or similar)
[ ] API key management for multiple LLM providers (OpenAI, Anthropic, etc.)
[ ] Secure credential storage and provider switching
[ ] Basic AI chat interface within the dashboard
[ ] Context-aware AI assistance based on current project/file

### Advanced AI Features
**Goal**: Leverage AI for intelligent Agent-SDD assistance and content generation

**Deliverables**:
[ ] AI-powered content suggestions for Agent-SDD files
[ ] Intelligent workflow recommendations based on project state
[ ] Code generation and refactoring assistance
[ ] Natural language queries about Agent-SDD projects and files
[ ] AI-assisted error diagnosis and troubleshooting

## Development Principles

1. **File Management Focus**: Build around viewing/editing Agent-SDD's file structure
2. **--init Encouragement**: Guide users toward Claude's --init for content generation
3. **Simple Setup**: One-click framework installation, then file management
4. **Markdown-Centric**: Treat files as primary interface, not abstract away complexity
5. **Claude Integration**: Complement Claude's capabilities, don't replace them
6. **System Stats Integration**: Parse existing variables.yml for framework insights
7. **AI Enhancement**: Add intelligent assistance without competing with core Agent-SDD workflows
8. **Subscription Model**: Graceful feature gating with lifetime app access

### System Stats Integration
**Data Sources**: Parse variables.yml system_counts section
**Display Format**: Dashboard widgets showing:
- Agent count (15 active sub-agents)
- Workflow count (11 available commands)
- Template count (10 template files)
- Error codes count (41 total error codes)
**Update Mechanism**: Read on app startup and project discovery
**Use Cases**: Framework health overview, capability showcase, system monitoring

---

## User Workflow

1. **Setup**: Use dashboard to install Agent-SDD framework in project directory
2. **Discovery**: Dashboard automatically discovers all Agent-SDD projects with .claude folders
3. **Selection**: Choose project from card grid to view detailed stats and health
4. **Generation**: Use Claude with `/sdd-task --init` to generate project content
5. **Management**: Use dashboard to view, edit, and organize generated files
6. **Monitoring**: Dashboard shows real-time project health and completion status
7. **Multi-Project**: Switch between different Agent-SDD projects seamlessly

---

## --init Integration

The dashboard is designed to encourage and complement Claude's `--init` command:

### Setup Flow
1. **Dashboard**: Install Agent-SDD framework files
2. **Claude**: Run `/sdd-task --init` to generate project structure
3. **Dashboard**: View and edit the generated files
4. **Repeat**: Use Claude for generation, dashboard for management

### Key Integration Points
- **Framework Installation**: Dashboard handles .claude directory setup
- **Content Generation**: Claude's --init creates overview.md, roadmap.md, etc.
- **File Management**: Dashboard provides visual editing interface
- **Workflow Continuity**: Seamless handoff between Claude commands and dashboard editing

### Encouragement Strategy
- **Clear Instructions**: Dashboard guides users to use --init for content generation
- **File Status Indicators**: Shows which files need --init vs manual editing
- **Integration Prompts**: Suggests Claude commands for file generation
- **Workflow Guidance**: Explains when to use Claude vs dashboard
- **AI Assistance**: Provides AI help for understanding and using Agent-SDD workflows

---

## Conclusion

This dashboard serves as a comprehensive project manager and file editor for Agent-SDD ecosystems. Users can discover multiple Agent-SDD projects across their file system, view detailed project statistics at a glance, and seamlessly manage files across all their projects. The dashboard encourages --init usage for content generation while providing the visual interface that makes Agent-SDD projects manageable and organized.

**Success = Users have a unified dashboard for discovering, monitoring, and managing all their Agent-SDD projects with framework insights and AI assistance, backed by a sustainable subscription model that ensures continuous improvement while Claude remains the intelligent content generation engine.**