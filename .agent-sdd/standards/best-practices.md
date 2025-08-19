# Development Best Practices

> **How to Use This File:**  
> - Customize each section based on your project's technology stack and requirements
> - Remove sections that don't apply to your project type
> - Replace bracketed placeholders with your specific tools and conventions
> - Add project-specific practices as you establish them

---

## Code Quality

### Keep It Simple
- Implement solutions clearly without over-engineering
- Use straightforward, maintainable patterns
- Prefer built-in language features before adding external dependencies
- [Add your specific simplicity guidelines here]

### Code Organization
- Keep files focused on a single responsibility
- Group related functionality together
- Use consistent folder structure: [document your project structure]
- [Add your file organization principles]

---

## Code Style

### Naming Conventions
- Variables/functions: [specify your convention, e.g., camelCase, snake_case]
- Classes/components: [specify your convention, e.g., PascalCase]
- Constants: [specify your convention, e.g., UPPER_SNAKE_CASE]
- Files: [specify your convention, e.g., kebab-case, camelCase]
- Choose descriptive names that explain purpose
- Avoid abbreviations unless widely understood in your domain

### Formatting Standards
- Indentation: [specify spaces or tabs, e.g., 2 spaces, 4 spaces]
- Line length: [specify max characters, e.g., 80, 100, 120]
- Semicolons: [required/optional based on your language]
- Quotes: [single/double quotes preference]
- [Add other formatting rules specific to your language]

### Code Organization
- Import order: [specify your import grouping/ordering rules]
- Function/method order: [specify your organization pattern]
- Comment style: [specify when and how to comment]
- [Add language-specific organization rules]

### Linting & Formatting Tools
- Primary linter: [your linter, e.g., ESLint, Pylint, RuboCop]
- Code formatter: [your formatter, e.g., Prettier, Black, rustfmt]
- Configuration files: [list your config files, e.g., .eslintrc, .prettierrc]
- Pre-commit hooks: [specify if you use automated formatting]

---

## Project Structure

### File Organization
```
[Replace with your project's folder structure]
/src
  /components  [or your equivalent]
  /utils       [or your equivalent]  
  /tests       [or your equivalent]
```

### Naming Patterns
- Files: [your file naming convention]
- Directories: [your directory naming convention]
- [Add other naming patterns specific to your project]

---

## Dependencies & Libraries

### Dependency Selection
- Research alternatives before adding new dependencies
- Consider maintenance status and community support
- Document why each major dependency was chosen
- [List your approved/preferred libraries here]

### Version Management
- [Specify your dependency update strategy]
- [Document any version pinning policies]
- [Add dependency security scanning practices]

---

## Testing Strategy

### Testing Framework
- Primary testing tool: [your testing framework]
- Test file naming: [your convention, e.g., .test.js, .spec.js]
- Test organization: [co-located, separate folder, etc.]

### Testing Guidelines
- Test critical business logic and user flows
- [Specify minimum coverage requirements if any]
- [Document mocking strategies for external services]
- [Add performance testing approach if applicable]

---

## Error Handling & Logging

### Error Management
- [Document your error handling patterns]
- [Specify logging tools and practices]
- [Add error reporting/monitoring setup]

### Security Practices
- Never commit secrets or API keys
- Use environment variables for configuration
- [Document your secret management approach]
- [Add authentication/authorization patterns]

---

## Version Control

### Commit Messages
Format: [your commit message format]
Example: `feat: add user authentication`

### Branch Strategy
- Main branch: [your main branch name]
- Feature branches: [your naming convention]
- [Document your branching workflow]

### Code Reviews
- [Specify review requirements]
- [Document review checklist if you have one]
- [Add merge/rebase preferences]

---

## Performance & Optimization

### Performance Guidelines
- Measure before optimizing
- [Document performance testing tools]
- [Add specific performance targets if applicable]
- [List optimization strategies for your tech stack]

---

## Your Custom Practices

*Add project-specific practices here as your team establishes them...*

### [Custom Section 1]
- [Your practice]
- [Your guideline]

### [Custom Section 2] 
- [Your practice]
- [Your guideline]

---

**Tips for Maintaining This File:**
- Update practices as your project evolves
- Remove sections that don't apply to your project
- Add examples specific to your codebase
- Review and refine these practices regularly with your team
