# Agent-SDD Companion App - AI Agent Execution Instructions

## Overview

**Agent-SDD Companion App** is a desktop application that provides a visual interface for managing Agent-SDD project files. Built with Tauri (Rust backend) + React + TypeScript frontend + shadcn/ui components.

**Core Mission**: Create a sleek, useful dashboard companion for the Agent-SDD framework that enhances rather than replaces Claude's capabilities.

**Development Approach**:
- Execute phases sequentially with validation at each step
- Focus on file I/O operations and project discovery
- Build around Agent-SDD's existing file structure
- Maintain workflow integrity (Claude generates → Dashboard manages)
- Ensure proper project isolation and cross-project operations

## Progress Tracking & Context Management

**Critical**: All development progress must be tracked in `changelog.md` and roadmap deliverables must be checked off.

### Progress Logging Requirements
- **Update changelog.md** after completing each deliverable or significant milestone
- **Check off completed items** in `companion-app-roadmap.md` using `[x]` format
- **Log format**: Include date, completed feature, implementation details, and any challenges overcome
- **Context preservation**: Ensure new chat sessions can resume development by referencing these three files:
  1. `companion-app-roadmap.md` (current deliverables and status)
  2. `companion-app-agent-instructions.md` (execution guidelines)
  3. `changelog.md` (development history and progress)

### Session Continuity Protocol
1. **Start new session**: Read the three context files to understand current state
2. **Identify next tasks**: Find unchecked `[ ]` items in roadmap that match current phase
3. **Execute work**: Implement features according to these instructions
4. **Update progress**: Check off completed items and log in changelog
5. **Validate success**: Ensure success criteria are met before marking complete

### Changelog Entry Format
```
### YYYY-MM-DD | [FEATURE_NAME]
Brief description of completed work
- Technical details implemented
- Challenges overcome
- Files modified
- Testing completed
- Status: completed/partial/blocked
```

---

## Phase Execution Guidelines

### Simple MVP (Foundation Phase)

**Objective**: Establish core file management and project discovery capabilities.

#### Setup Wizard
- Implement one-click Agent-SDD framework installation
- Create `.claude` directory structure with `CLAUDE.md`
- Add framework health verification with status indicators
- Include clear success/failure feedback

**Success Criteria**:
- Users can install Agent-SDD framework without command-line knowledge
- Framework validation passes all checks
- Clear error messages for failed installations

#### Project Discovery
- Build directory browser for selecting project root directories
- Implement `.claude` folder detection across file systems
- Create project card grid with name, path, last modified info
- Add validation for legitimate Agent-SDD projects

**Success Criteria**:
- Discovers all Agent-SDD projects in specified directories
- Accurate project information display
- No false positives for non-Agent-SDD directories

#### File Viewer
- Create project file browser showing `.claude` directory structure
- Implement markdown file viewer with syntax highlighting
- Add file structure visualization
- Include file status indicators (exists/edited/modified)

**Success Criteria**:
- All Agent-SDD file types display correctly
- Syntax highlighting works for markdown
- File status updates in real-time

#### File Editor
- Build in-app markdown editor for project files
- Add basic validation for Agent-SDD file formats
- Implement save/load functionality
- Include edit history and undo/redo

**Success Criteria**:
- All edits save correctly to file system
- Validation prevents corrupted file formats
- Undo/redo works reliably

#### Settings & Preferences
- Create comprehensive settings page
- Implement visual theme customization via [tweakcn.com](https://tweakcn.com/)
- Add theme import/export with CSS variables
- Include live theme preview and application

**Success Criteria**:
- All settings persist between app sessions
- Theme changes apply instantly across entire app
- Settings validation prevents invalid configurations

#### Project Stats Dashboard
- Build detailed project statistics display
- Parse variables.yml system_counts (15 agents, 11 workflows, 41 error codes)
- Add actionable recommendations
- Include next steps guidance

**Success Criteria**:
- All system metrics display accurately
- Recommendations are actionable and accurate
- Stats update in real-time

---

### Phase 2: Advanced Management Features

**Objective**: Add sophisticated project and framework management capabilities.

#### Enhanced Editing
- Implement rich markdown editor with live preview
- Add template insertion for common Agent-SDD sections
- Include file comparison and diff viewing
- Build batch file operations

**Success Criteria**:
- All markdown features work seamlessly
- Templates integrate correctly
- File comparisons are accurate

#### Multi-Project Management
- Create cross-project search and content discovery
- Add project comparison and health benchmarking
- Implement bulk operations across projects
- Build project templates and duplication

**Success Criteria**:
- Search works across all discovered projects
- Bulk operations execute reliably
- Project templates create valid Agent-SDD structures

#### Agent Creation Studio
- Build agent creation wizard with guided setup
- Add template selection for existing agent patterns
- Implement tool configuration interface
- Create agent validation and registry integration

**Success Criteria**:
- All agent types can be created
- Validation prevents invalid agent configurations
- Registry updates correctly

#### Workflows Command Generator
- Create workflow cards grid in execution order
- Build command generation wizards
- Add dependency validation
- Implement prompt preview and clipboard copy

**Success Criteria**:
- All workflows generate correct prompts
- Dependency checking works accurately
- Generated prompts are ready for Claude

#### Workflow Creation Wizard
- Implement workflow creation wizard
- Add agent orchestration interface
- Create dependency mapping
- Build workflow testing interface

**Success Criteria**:
- Workflows deploy to correct directories
- Agent orchestration works properly
- Testing validates workflow integrity

#### Specifications Management View
- Build specifications browser
- Create task cards with complete information
- Implement Kanban board layout
- Add interactive task editing

**Success Criteria**:
- All task fields display correctly
- Kanban drag-and-drop works smoothly
- Task edits save properly

#### Project Health Dashboard
- Create visual health score indicators
- Add file status grid
- Implement framework metrics display
- Build actionable recommendations

**Success Criteria**:
- Health scores calculate accurately
- All metrics display correctly
- Recommendations are helpful and accurate

---

### Phase 3: AI Integration & Intelligence

**Objective**: Add intelligent assistance and AI-powered features.

#### AI System Helper Foundation
- Integrate popular LLM SDK (Vercel AI, LangChain)
- Add API key management for providers
- Implement secure credential storage
- Create basic AI chat interface

**Success Criteria**:
- Multiple LLM providers supported
- API keys stored securely
- Basic chat functionality works

#### Advanced AI Features
- Build AI-powered content suggestions
- Add intelligent workflow recommendations
- Implement code generation assistance
- Create natural language project queries

**Success Criteria**:
- AI suggestions are relevant and helpful
- Recommendations improve productivity
- Queries return accurate information

---

## Technical Implementation Requirements

### Core Architecture
- **Tauri**: Native desktop app framework
- **React + TypeScript**: Frontend framework
- **shadcn/ui**: **MANDATORY REQUIREMENT** - All UI components MUST be built using shadcn/ui components only. No custom components allowed. Leverage the full shadcn/ui component library for consistent, accessible, and themeable UI.
- **Tailwind CSS**: Utility-first styling with CSS variables
- **SQLite**: Local data storage
- **File System APIs**: Cross-platform file operations

### Theme System
- CSS variables for all color values
- Light/dark mode support
- [tweakcn.com](https://tweakcn.com/) integration for customization
- Live theme preview and application
- **shadcn/ui Integration**: Theme system designed specifically for shadcn/ui component theming requirements

### Data Management
- SQLite for user preferences and project metadata
- File system for Agent-SDD project files
- Proper data isolation between projects
- Backup and restore capabilities

### Security Considerations
- Secure API key storage for LLM providers
- Proper file system permissions
- Input validation and sanitization
- No direct execution of generated commands

---

## Success Validation Framework

### MVP Success Criteria
- [ ] Framework installation works flawlessly
- [ ] Project discovery finds all Agent-SDD projects
- [ ] File viewing and editing functions properly
- [ ] Settings and themes work seamlessly
- [ ] Basic project management operational

### Phase 2 Success Criteria
- [ ] Advanced editing capabilities functional
- [ ] Multi-project operations work correctly
- [ ] Agent and workflow creation tools operational
- [ ] Specifications management fully functional
- [ ] Project health monitoring accurate

### Phase 3 Success Criteria
- [ ] AI integration works with multiple providers
- [ ] Intelligent assistance improves workflow
- [ ] Advanced AI features enhance productivity
- [ ] Natural language interactions functional

---

## Execution Priorities

### Phase 1 (Foundation)
1. Setup Wizard - establishes framework foundation
2. Project Discovery - enables core functionality
3. File Viewer - basic file management
4. Settings - user customization
5. File Editor - content modification
6. Project Stats - basic analytics

### Phase 2 (Enhancement)
1. Enhanced Editing - improved file management
2. Multi-Project Management - scalability
3. Specifications Management - task tracking
4. Project Health Dashboard - insights
5. Agent Creation Studio - framework extension
6. Workflows Command Generator - Claude integration
7. Workflow Creation Wizard - advanced extension

### Phase 3 (Intelligence)
1. AI System Helper Foundation - basic AI integration
2. Advanced AI Features - intelligent assistance

---

## Quality Assurance Guidelines

### Code Quality
- TypeScript strict mode enabled
- Comprehensive error handling
- Input validation on all user inputs
- Proper state management
- Clean component architecture

### User Experience
- Intuitive navigation and workflows
- Clear error messages and feedback
- Responsive design for different screen sizes
- Accessibility compliance (WCAG guidelines)
- Performance optimization for large projects
- **shadcn/ui Component Compliance**: All UI elements must use shadcn/ui components exclusively for consistency and theming

### Testing Requirements
- Unit tests for all components
- Integration tests for key workflows
- E2E tests for critical user journeys
- File system operation testing
- Theme system validation

---

## Deployment and Distribution

### Build Process
- Tauri build for multiple platforms (macOS, Windows, Linux)
- Automated testing in CI/CD pipeline
- Code signing for distribution
- Update mechanism for future releases

### Distribution Strategy
- Direct download from website
- Auto-update system
- Subscription-based licensing
- Graceful feature degradation for expired licenses

---

## Final Validation Checklist

**Pre-Release Requirements:**
- [ ] All MVP features implemented and tested
- [ ] Phase 2 features complete and validated
- [ ] Phase 3 AI features integrated and functional
- [ ] Cross-platform compatibility verified
- [ ] Performance benchmarks met
- [ ] Security audit completed
- [ ] User acceptance testing passed
- [ ] Documentation complete and accurate
- [ ] **Progress tracking complete**: All deliverables checked off `[x]` in roadmap and logged in changelog.md

**Launch Readiness:**
- [ ] Installation process streamlined
- [ ] User onboarding intuitive
- [ ] Error handling robust
- [ ] Update mechanism functional
- [ ] Support channels established
- [ ] Marketing materials ready
- [ ] **Context continuity verified**: Three-file system (roadmap + instructions + changelog) provides complete development context

---

*This instruction file serves as the comprehensive guide for AI agents executing the Agent-SDD Companion App development. Follow the phase progression, validate success criteria at each step, and maintain the core philosophy of being a "sleek, useful dashboard companion" to Claude.*
