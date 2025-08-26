# /sdd-task --edit [<description>] Workflow

A lightweight workflow for simple edits that don't require a full specification directory setup. When `/sdd-task --edit [<description>]` is invoked, it performs minimal overhead operations for quick code modifications.

## Purpose
- Handle simple, straightforward code edits that don't warrant the overhead of `--fix` or `--update`
- Provide quick modifications without creating spec directories or extensive validation
- Maintain workflow continuity through logger integration while minimizing token usage
- Execute immediate changes for minor adjustments, typo corrections, or small improvements

## --edit vs Other Commands
- **--edit**: Use for simple, low-impact changes that don't need tracking or extensive validation
- **--fix**: Use for bugs, errors, or broken functionality requiring investigation and testing
- **--update**: Use for enhancements, feature additions, or improvements requiring specification

### When to Use --edit
- ✅ **Typo corrections**: Fixing spelling errors in code comments or strings
- ✅ **Minor formatting**: Adjusting indentation, spacing, or code style
- ✅ **Simple variable renames**: Renaming variables for clarity
- ✅ **Comment updates**: Adding or updating code documentation
- ✅ **Configuration tweaks**: Small adjustments to config files
- ✅ **Import/export corrections**: Fixing simple import statements

### When to Use --fix or --update Instead
- ❌ **Bug fixes**: Use `--fix` for broken functionality
- ❌ **Feature additions**: Use `--update` for new capabilities
- ❌ **Complex changes**: Use appropriate command for multi-file modifications
- ❌ **Testing required**: Use `--fix` or `--update` when validation is needed

## Command Syntax
```
/sdd-task --edit [description]
```
- **Arguments**: Optional description parameter
  - If provided: Description of the edit to perform
  - If omitted: Will prompt for edit description

## Workflow
1. **Initialize Logger Context**:
   - **MUST INVOKE**: Use `.claude/agents/logger.md` in read mode to gather recent project changes and establish context awareness.
   - This step ensures continuity with recent changes and prevents conflicts.

2. **Parse Input**:
   - Read optional description parameter from `/sdd-task --edit [description]`
   - If no description provided, prompt user for edit details

3. **Execute Edit**:
   - Perform the requested modification directly
   - Apply changes using appropriate tools (Edit, MultiEdit, Write, etc.)
   - Focus on the specific change requested without extensive validation

4. **User Verification**:
   - **REQUIRED**: Prompt user to verify the edit is correct and working as expected
   - Ask: "Please review the changes. Are they correct and working as intended?"
   - **If "Correct" or confirmed working**: Proceed to step 5
   - **If issues found**: 
     - Gather additional details about problems
     - Return to step 3 (Execute Edit) with corrections
     - Do not proceed to logger completion until edit is verified

5. **Complete Logger Cycle**:
   - **MUST INVOKE**: Use `.claude/agents/logger.md` in write mode to record the edit in `.claude/changelog.md`
   - Include brief description of changes made
   - This step maintains workflow continuity for future operations

## Error Handling
- **Missing Description**: Prompt user for edit details if not provided
- **File Access Issues**: Report if target files cannot be accessed or modified
- **Syntax Errors**: Notify if edit would introduce obvious syntax problems

## Example Usage
```
# Edit with description provided
/sdd-task --edit "Fix typo in welcome message"

# Edit without description (will prompt)
/sdd-task --edit
```

## Output Examples
### During Edit Process:
```
Edit Report
=============
Description: Fix typo in welcome message
Files Modified: src/components/Welcome.tsx
Status: AWAITING USER VERIFICATION

Please review the changes. Are they correct and working as intended?
```

### After User Confirmation:
```
Edit Complete
=============
User Verification: CONFIRMED - Changes are correct
Status: COMPLETED and logged to changelog
```

## Integration Notes
- **Minimal Overhead**: No spec directory creation or extensive validation
- **Quick Execution**: Streamlined workflow for immediate results
- **Logger Integration**: Maintains continuity with other Agent-SDD workflows
- **Token Efficient**: Designed to minimize unnecessary agent invocations