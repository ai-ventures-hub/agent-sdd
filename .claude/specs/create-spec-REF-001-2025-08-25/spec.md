# Software Design Document: Centralized Reference System

Created: 2025-08-25
Status: Draft

## Overview

This specification outlines the implementation of a centralized reference system to make the Agent-SDD workflow more modular by detecting common references across Agent-SDD files, centralizing these references in a single file, and allowing other files to reference the centralized file instead of duplicating content.

## Current State Analysis

Based on comprehensive analysis of the `.claude/` directory structure, the following duplicated references have been identified:

### High-Frequency Duplicated References (50+ occurrences):

1. **Agent References** (100+ occurrences):
   - `.claude/agents/task-schema-validator.md` - Referenced in 16 files
   - `.claude/agents/date-checker.md` - Referenced in 11 files
   - `.claude/agents/file-creator.md` - Referenced in 10 files
   - `.claude/agents/code-reviewer.md` - Referenced in 8 files
   - `.claude/agents/context-fetcher.md` - Referenced in 7 files
   - `.claude/agents/test-runner.md` - Referenced in 6 files
   - `.claude/agents/logger.md` - Referenced in 8 files

2. **Standards References** (50+ occurrences):
   - `.claude/standards/theme-standards.md` - Referenced in 16 files
   - `.claude/standards/best-practices.md` - Referenced in 6 files
   - `.claude/standards/tech-stack.md` - Referenced in 4 files

3. **Directory Structure References** (74+ occurrences):
   - `.claude/specs/[pattern]` - Referenced in 16 files with multiple variations
   - Error codes and patterns - Repeated across 12+ workflow files
   - Schema definitions - 12-field vs 14-field inconsistencies

4. **Common Patterns**:
   - Task schema field definitions (repeated 8+ times)
   - Error handling patterns (ERR_001-ERR_007 codes)
   - Directory naming conventions
   - Dashboard integration patterns
   - Workflow step patterns

## Proposed Centralized Reference System

### Architecture

Create a new centralized reference system with the following structure:

```
.claude/
├── references/
│   ├── agents.md           # Central agent definitions
│   ├── standards.md        # Central standards definitions  
│   ├── schemas.md          # Central schema definitions
│   ├── patterns.md         # Common workflow patterns
│   ├── errors.md           # Standardized error codes
│   └── directories.md      # Directory structure conventions
└── templates/
    ├── agent-template.md   # Template for new agents
    ├── workflow-template.md # Template for new workflows
    └── spec-template.md    # Template for new specs
```

### Reference File Specifications

#### 1. `.claude/references/agents.md`
- **Purpose**: Central registry of all agents with descriptions, inputs, outputs, and usage
- **Format**: YAML frontmatter + structured markdown
- **Content**: Agent metadata, inter-agent dependencies, common invocation patterns

#### 2. `.claude/references/standards.md`
- **Purpose**: Central registry of all standards files with descriptions and usage contexts
- **Format**: YAML frontmatter + structured markdown  
- **Content**: Standard file metadata, application contexts, validation rules

#### 3. `.claude/references/schemas.md`
- **Purpose**: Canonical schema definitions (resolve 12-field vs 14-field inconsistency)
- **Format**: JSON Schema + documentation
- **Content**: Task schema, validation rules, field definitions, examples

#### 4. `.claude/references/patterns.md`
- **Purpose**: Reusable workflow patterns and step sequences
- **Format**: Structured markdown with templates
- **Content**: Common workflow steps, dashboard integration patterns, validation patterns

#### 5. `.claude/references/errors.md`
- **Purpose**: Standardized error codes, messages, and handling patterns
- **Format**: Structured markdown with error registry
- **Content**: Error code definitions, standard messages, resolution steps

#### 6. `.claude/references/directories.md`
- **Purpose**: Directory structure conventions and naming patterns
- **Format**: Structured markdown with examples
- **Content**: Path patterns, naming conventions, directory purposes

### Reference Integration Mechanism

#### Syntax for References
Use a standardized reference syntax in all Agent-SDD files:

```markdown
<!-- REF:agents:task-schema-validator -->
<!-- REF:standards:theme-standards -->
<!-- REF:schema:task-12-field -->
<!-- REF:pattern:dashboard-integration -->
<!-- REF:error:ERR_003 -->
<!-- REF:directory:spec-naming -->
```

#### Reference Resolution
- References are resolved at build/validation time
- Content is injected or validated against central definitions
- Circular references are detected and prevented
- Version tracking for reference updates

## Implementation Plan

### Phase 1: Central Reference Creation
1. **Audit and Extract**: Systematically extract all duplicated content
2. **Create Reference Files**: Establish the central reference system
3. **Standardize Schemas**: Resolve inconsistencies (12-field vs 14-field)
4. **Validate Structure**: Ensure all references are complete and consistent

### Phase 2: File Migration
1. **Update Agent Files**: Replace duplicated content with references
2. **Update Workflow Files**: Standardize patterns and references
3. **Update Documentation**: Ensure consistency across all docs
4. **Add Templates**: Create standardized templates for new files

### Phase 3: Validation and Testing
1. **Reference Validation**: Ensure all references resolve correctly
2. **Workflow Testing**: Verify all workflows function with new system
3. **Documentation Review**: Comprehensive review of all updated files
4. **Performance Testing**: Ensure no performance degradation

### Phase 4: Maintenance System
1. **Reference Linting**: Automated validation of references
2. **Update Propagation**: System for updating references across files
3. **Version Control**: Track reference changes and impacts
4. **Documentation**: Maintain reference system documentation

## Benefits of the New System

### 1. Maintenance Efficiency
- **Single Source of Truth**: Update agent definitions in one place
- **Consistency**: Eliminate discrepancies between files
- **Reduced Redundancy**: 70%+ reduction in duplicated content
- **Easier Updates**: Change propagates automatically

### 2. Developer Experience
- **Clear Dependencies**: Explicit agent and standard relationships
- **Template System**: Standardized approach for new files
- **Error Consistency**: Unified error handling across all workflows
- **Documentation Quality**: Always up-to-date references

### 3. System Reliability
- **Schema Validation**: Consistent task schema across all workflows
- **Reference Validation**: Automated checking of reference integrity  
- **Circular Dependency Detection**: Prevent reference loops
- **Version Control**: Track changes to critical definitions

### 4. Scalability
- **Modular Growth**: Easy addition of new agents and workflows
- **Pattern Reuse**: Standardized patterns for common operations
- **Maintenance Reduction**: Less manual synchronization needed
- **Quality Assurance**: Automated consistency checking

## Migration Strategy

### 1. Backward Compatibility
- Maintain existing file structure during transition
- Gradual migration of files to new reference system
- Legacy reference support during migration period
- Clear migration timeline and checkpoints

### 2. Validation Strategy
- Automated reference checking during file updates
- Pre-commit hooks to validate reference integrity
- Continuous integration testing of reference resolution
- Manual review checkpoints for critical changes

### 3. Rollback Plan
- Version control for all reference changes
- Automated rollback capability for failed updates
- Testing environment for reference system changes
- Clear rollback procedures for emergency situations

## Success Metrics

### Quantitative Metrics
- **Reference Reduction**: Target 70% reduction in duplicated references
- **File Consistency**: 100% schema compliance across all task files
- **Update Efficiency**: 90% reduction in time for system-wide updates
- **Error Standardization**: 100% coverage of error codes in central registry

### Qualitative Metrics
- **Developer Onboarding**: Faster understanding of system structure
- **Maintenance Burden**: Reduced effort for keeping documentation current
- **System Reliability**: Fewer inconsistencies between components
- **Feature Velocity**: Faster implementation of new workflows and agents

## Tasks

See tasks.json in this directory for detailed implementation tasks.

## Implementation

- Tasks: Validated by task-schema-validator
- Standards: Follow .claude/standards/theme-standards.md
- Schema: Implement 12-field task schema consistently
- References: Establish centralized reference system
- Templates: Create standardized file templates
- Validation: Implement automated reference checking
- Migration: Gradual transition with backward compatibility
- Testing: Comprehensive validation of new reference system