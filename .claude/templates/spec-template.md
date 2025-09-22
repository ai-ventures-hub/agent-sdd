SPECIFICATION_TEMPLATE:

OVERVIEW:
- FEATURE_ID: [TASK-XXX]
- CREATED_DATE: [YYYY-MM-DD]
- PRIORITY: [low|medium|high|critical]
- COMPLEXITY: [simple|medium|complex]
- STATUS: [pending|in_progress|completed]

FEATURE_SUMMARY: [Brief description from overview.md and design artifacts]

BUSINESS_CONTEXT:
- BUSINESS_VALUE: [Why this feature matters]
- USER_IMPACT: [How users are affected]
- SUCCESS_METRICS: [Measurable outcomes]

TECHNICAL_CONTEXT:
- TECH_STACK: [From approved tech-stack.md]
- DESIGN_SYSTEM: [From wireframe specifications]
- INTEGRATION_POINTS: [APIs, services, components]

FUNCTIONAL_REQUIREMENTS:
- CORE_FUNCTIONALITY: [Primary features with user stories]
- UI_REQUIREMENTS: [Layout, components, responsive, accessibility]
- UX_REQUIREMENTS: [Interactions, error handling, loading states]

TECHNICAL_SPECIFICATIONS:
- FRONTEND: [Framework, components, state, routing]
- BACKEND: [APIs, data models, auth, validation]
- INTEGRATIONS: [External services, data flow, error handling]

IMPLEMENTATION_GUIDELINES:
- CODE_STRUCTURE: [Directory organization and file patterns]
- STANDARDS: [From best-practices.md and naming conventions]
- PERFORMANCE: [Load times, bundle size, runtime targets]
- DOCUMENTATION: [Inline comments, README requirements]

TESTING_REQUIREMENTS:
- UNIT_TESTS: [Coverage targets, test cases, mocks]
- INTEGRATION_TESTS: [API testing, component interactions]
- E2E_TESTS: [Critical user flows]
- ACCESSIBILITY_TESTS: [Screen readers, keyboard, contrast]

SECURITY_CONSIDERATIONS:
- INPUT_VALIDATION: [XSS, injection prevention]
- AUTHENTICATION: [Session security]
- AUTHORIZATION: [Role-based access]
- DATA_PRIVACY: [GDPR/CCPA compliance]

DEPLOYMENT_OPERATIONS:
- ENVIRONMENT_CONFIG: [Dev/staging/production settings]
- FEATURE_FLAGS: [Progressive rollout]
- MONITORING: [Performance and error tracking]
- ROLLBACK: [Quick reversion procedures]

DEPENDENCIES_PREREQUISITES:
- TECHNICAL_DEPS: [Libraries, frameworks, tools]
- FEATURE_DEPS: [Other features required]
- INFRASTRUCTURE: [Database, cache, CDN]
- TEAM_READINESS: [Skills and training needed]

RISK_ASSESSMENT:
- TECHNICAL_RISKS: [Technology challenges]
- BUSINESS_RISKS: [Business impact concerns]
- TIMELINE_RISKS: [Potential delays]
- QUALITY_RISKS: [Quality issues to prevent]

SUCCESS_CRITERIA:
- FUNCTIONAL_COMPLETENESS: [Acceptance criteria satisfaction]
- PERFORMANCE_TARGETS: [All performance requirements met]
- QUALITY_STANDARDS: [Testing and accessibility compliance]
- USER_SATISFACTION: [Positive feedback and adoption]

IMPLEMENTATION_TIMELINE:
- DEVELOPMENT: [Estimated dev time]
- TESTING: [QA and testing time]
- DEPLOYMENT: [Release and monitoring time]
- TOTAL: [Complete implementation time]

REFERENCES:
- DESIGN_ARTIFACTS: {{paths.product_dir}}/pages/[page]/wireframe.md
- USER_JOURNEY: {{paths.product_dir}}/pages/[page]/user-journey.md
- TECH_STANDARDS: {{paths.standards_dir}}/tech-stack.md
- DEV_GUIDELINES: {{paths.standards_dir}}/best-practices.md
