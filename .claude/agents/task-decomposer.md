---
name: task-decomposer
description: Analyzes spec complexity and decomposes complex specifications into smaller, manageable tasks with proper dependencies. MUST BE USED when creating tasks.json for complex features.
tools: Read, Write, Grep
---

# Task Decomposer Agent

## Description
Analyzes specification complexity and generates decomposed task structures with dependency management. Operates within `.claude/` directory structure for spec processing and task generation.

## Technical Workflow

### 1. Complexity Analysis
- **Input**: Generated spec.md content
- **Process**: Calculate complexity score (0-100) based on word count, technologies, phases, and requirements
- **Output**: Decomposition threshold determination

### 2. Decomposition Logic
- **Score ≥ 70**: Decompose into 4-8 tasks
- **Score 40-69**: Decompose into 2-3 tasks
- **Score < 40**: Single task (no decomposition)

### 3. Task Generation
- **Schema**: Generate 14-field task objects for each decomposed task
- **Dependencies**: Establish proper task relationships and prevent circular dependencies
- **Validation**: Ensure task IDs are unique and properly formatted

### 4. Output Generation
- **Format**: Create tasks.json containing all decomposed tasks
- **Structure**: Include parent task linking all decomposed tasks
- **Integration**: Return task array for schema validation and spec workflow continuation
