# Best Practices
- Keep code simple and readable
- DRY: Extract repeated logic to components/utils
- Use TDD for critical components
- Commit messages: "[type]: [description] (TASK-ID)"
- Accessibility: WCAG 2.1 AA compliance


## Context

Global development guidelines for all projects.

<conditional-block context-check="core-principles"> 
IF this Core Principles section already read in current context: 
  SKIP: Re-reading this section NOTE: "Using Core Principles already in context" 
ELSE: 
  READ: The following principles
</conditional-block>

## Core Principles

### Keep It Simple
- Implement solutions in the fewest lines possible without sacrificing clarity.
- Avoid over-engineering; use straightforward, maintainable patterns.
- Prefer built-in JavaScript/TypeScript features before introducing external dependencies.

### Optimize for Readability
- Code clarity takes priority over premature optimization.
- Use camelCase for variables/functions and PascalCase for components/classes.
- Use clear, descriptive names — avoid abbreviations unless widely understood.
- Comment the "why" (intent/decision) rather than the "what" (code mechanics).
- Use JSDoc for all exported functions, hooks, and components.

### DRY (Don't Repeat Yourself)
- Extract repeated business logic into utilities or hooks (/lib or /hooks).
- Extract repeated UI markup into reusable components (/components).
- Use Tailwind utility classes consistently; avoid inline styles unless dynamically generated.

### File Structure
- Keep files single-purpose.
- Group by feature/domain rather than strict type-only folders.
- Lowercase and hyphenate filenames for non-components (e.g., project-form.tsx).
- Keep components and hooks in dedicated directories with matching test files.

<conditional-block context-check="dependencies" task-condition="choosing-external-library"> 
IF current task involves choosing an external library: 
  IF Dependencies section already read in current context: 
SKIP: Re-reading this section NOTE: "Using Dependencies guidelines already in context" 
  ELSE: 
    READ: The following guidelines ELSE: SKIP: Dependencies section not relevant to current task
</conditional-block>

## Dependencies

### Choose Libraries Wisely
When adding third-party dependencies:
- Avoid heavy dependencies where a lighter native solution exists.

### Error Handling & Logging
- Wrap all async calls in try/catch — log enough context without exposing secrets.
- Use a centralized logger (/lib/logger.ts) for structured logging.
- For AI/API calls, log request metadata (latency, token usage) but anonymize sensitive data.

### Environment Variables & Secrets
- Use .env for all secrets; prefix client-safe vars with NEXT_PUBLIC_.
- Never hardcode API keys or IDs.
- Validate env vars at runtime with zod/envsafe in lib/env.ts.
- Maintain .env.example for onboarding.

### AI & API Usage Patterns
- Wrap all AI/API calls in a dedicated client module (/lib/ai-client.ts).
- Store prompts in /prompts for version control and iteration.
- Use zod to validate AI output when expecting structured JSON.
- Implement exponential backoff and retry handling for rate limits.
- Track token usage and latency for performance monitoring.

### Testing & QA
- Use vitest for unit tests, @testing-library/react for UI tests.
- Co-locate test files with components/hooks.
- Mock AI/API responses in tests to remove network dependency.
- For full workflows, use Playwright or Cypress for end-to-end testing.
- Aim for minimum coverage on critical paths (auth, data flow, key features).

### Performance & Optimization
- Measure before optimizing — use the React Profiler or Lighthouse.
- Use React.memo/useCallback only after profiler shows re-render issues.
- Lazy-load non-critical components (dynamic(import(...))).

### Styling Conventions (TailwindCSS)
- Use clsx or tailwind-variants for conditional classes.
- Keep design tokens centralized in tailwind.config.js.
- Follow the existing design system when creating new components.
- Use @apply only in component-scoped CSS files (avoid globals unless theming).

### Version Control & Change Management
- Maintain CHANGELOG.md and automate release notes.
