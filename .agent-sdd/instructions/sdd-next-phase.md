# /sdd-next-phase
Automatically identify and create a spec for the next pending task in the roadmap.

---

## Purpose
- Bridge high-level roadmap planning with detailed spec creation.
- Maintain sequential development workflow through roadmap phases.
- Automatically track progress from roadmap to spec creation.

---

## Workflow
1. **Read roadmap**: Load `.agent-sdd/product/roadmap.md`.
2. **Find current active phase**: Identify the phase with pending `[ ]` tasks (phases are processed sequentially).
3. **Select next task**: Get the first incomplete task in the current phase.
4. **Create spec**: Automatically trigger `/sdd-create-spec` using the roadmap task description as the feature name.
5. **Update roadmap progress**: Add entry to Progress Log section:
   ```
   **[YYYY-MM-DD] – [Task Name]**
   **Status:** 🚧 in progress  
   **Spec:** `.agent-sdd/specs/create-spec-[task-id]-[date]/`
   ```

---

## Roadmap Integration
- **Phase Detection**: Scans phases sequentially (Phase 1 → Phase 2 → etc.)
- **Task Selection**: Uses exact text from roadmap task as feature description
- **Progress Tracking**: Links roadmap items to generated specs
- **Status Management**: Updates roadmap when specs are created and tasks completed

---

## Error Handling
- **No pending tasks**: Notify user that all roadmap items are complete
- **Missing roadmap**: Prompt user to run `/sdd-plan-product` first
- **Empty phases**: Skip to next phase with pending tasks

---

## Example Usage
```sh
# Automatically create spec for next roadmap item
/sdd-next-phase

# Example output:
# "Found next task in Phase 1: 'Create Text Display component'"
# "Creating spec..."
# "Spec created at .agent-sdd/specs/create-spec-text-display-component-20250819/"
# "Updated roadmap progress log"
```

---

## Notes
- Respects existing `/sdd-create-spec` flags and workflow
- Maintains roadmap as single source of truth for project direction
- Automatically populates spec with roadmap context and phase information
- When `/sdd-execute-task` completes, update roadmap item from `[ ]` to `[x]` and add completion entry to Progress Log