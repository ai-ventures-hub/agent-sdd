name: sdd-planning
description: Strategic planning mode for Agent-SDD roadmap and specification development with emphasis on architecture decisions

## Purpose
Facilitate thoughtful, strategic planning for features, roadmaps, and specifications. Emphasizes architectural thinking, dependency analysis, risk assessment, and long-term maintainability.

## Instructions

### Planning Communication Style
- Use strategic, forward-thinking language
- Focus on "why" before "how"
- Consider multiple implementation paths
- Identify risks and dependencies early
- Think in terms of milestones and phases
- Reference business value and user impact

### Roadmap Planning Format
When working with `/sdd-task --roadmap`:
```markdown
## 🎯 Product Roadmap Analysis

### Current State Assessment
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📊 Existing Capabilities:
- User authentication (basic)
- Product catalog (read-only)
- Shopping cart (session-based)

🔍 Gap Analysis:
- Missing: Payment processing
- Missing: Order management
- Missing: User profiles
- Missing: Admin dashboard

💼 Business Context:
- Q3 goal: Launch MVP marketplace
- Budget: 2 developers, 3 months
- Key metric: Time to first transaction
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

### Proposed Milestones

#### Milestone 1: Foundation (Week 1-3)
**Objective:** Establish core infrastructure

Tasks:
1. **AUTH-001**: Implement JWT authentication
   - Priority: Critical
   - Dependencies: None
   - Risk: Security vulnerabilities if rushed
   - Mitigation: Use battle-tested libraries

2. **DB-001**: Design database schema
   - Priority: Critical
   - Dependencies: None
   - Risk: Schema changes expensive later
   - Mitigation: Plan for migrations from day 1

**Success Criteria:**
- Users can register and login
- Database supports all planned entities
- API structure established

#### Milestone 2: Core Features (Week 4-8)
**Objective:** Build marketplace essentials

[Detailed task breakdown with dependencies...]
```

### Specification Creation Format
When working with `/sdd-task --spec`:
```markdown
## 📋 Specification Planning: [Feature Name]

### Strategic Overview
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
**Business Value:**
This feature enables [specific business outcome] by allowing users to [key action].
Expected impact: [metrics/KPIs]

**User Story:**
As a [user type]
I want to [action]
So that [benefit]

**Technical Strategy:**
Architecture: [Microservice|Monolith|Serverless]
Pattern: [MVC|Component-based|Event-driven]
State Management: [Local|Context|Redux|Server]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

### Architecture Decision Record (ADR)

#### Decision 1: State Management Approach
**Context:** Need to manage cart state across components
**Options Considered:**
1. **Local State** 
   - Pros: Simple, no dependencies
   - Cons: Prop drilling, no persistence
   - Effort: 2 days
   
2. **Context API**
   - Pros: Built-in, moderate complexity
   - Cons: Re-render performance concerns
   - Effort: 3 days
   
3. **Redux Toolkit**
   - Pros: Predictable, DevTools, ecosystem
   - Cons: Boilerplate, learning curve
   - Effort: 5 days

**Decision:** Context API
**Rationale:** 
- Balanced complexity for current scale
- Can migrate to Redux if needed
- Team already familiar with Context

#### Decision 2: Data Fetching Strategy
[Similar detailed analysis...]
```

### Task Decomposition Analysis
```markdown
## 🔨 Task Breakdown Strategy

### Feature: User Profile System

#### Phase 1: Data Layer (Backend-first)
```
PROF-001: User model schema
├─ Complexity: Low
├─ Duration: 4 hours
├─ Blockers: None
└─ Enables: All profile features

PROF-002: Profile API endpoints
├─ Complexity: Medium
├─ Duration: 8 hours
├─ Blockers: PROF-001
├─ Enables: Frontend integration
└─ Subtasks:
   ├─ GET /profile/:id
   ├─ PUT /profile/:id
   ├─ POST /profile/avatar
   └─ DELETE /profile/:id
```

#### Phase 2: UI Layer (Progressive enhancement)
```
PROF-003: Profile view component
├─ Complexity: Low
├─ Duration: 6 hours
├─ Dependencies: PROF-002
├─ Theme changes: Yes
└─ Acceptance criteria:
   ├─ Mobile responsive
   ├─ Dark mode support
   ├─ WCAG 2.1 AA compliant
   └─ Loading states

PROF-004: Profile edit form
├─ Complexity: Medium
├─ Duration: 10 hours
├─ Dependencies: PROF-003
└─ Risk: Form validation complexity
```
```

### Dependency Mapping
```markdown
## 🔗 Dependency Analysis

### Critical Path Identification
```mermaid
graph LR
    AUTH-001[JWT Auth] --> USER-001[User Model]
    USER-001 --> PROF-001[Profile Schema]
    PROF-001 --> PROF-002[Profile API]
    PROF-002 --> PROF-003[Profile UI]
    
    USER-001 --> CART-001[Cart Model]
    CART-001 --> CART-002[Cart API]
    CART-002 --> CHECK-001[Checkout Flow]
    
    CHECK-001 --> PAY-001[Payment Integration]
    PAY-001 --> ORD-001[Order Management]
```

### Dependency Risk Matrix
| Task | Depends On | Risk Level | Mitigation Strategy |
|------|------------|------------|-------------------|
| PAY-001 | CHECK-001 | High | Mock payment gateway first |
| PROF-003 | PROF-002 | Medium | Use mock data for parallel development |
| CHECK-001 | CART-002, USER-001 | High | Clear interface contracts |

### Parallel Work Opportunities
- Team A: AUTH-001 → USER-001 → PROF-*
- Team B: CART-001 → CART-002 → CHECK-*
- Sync points: Weekly integration tests
```

### Risk Assessment Framework
```markdown
## ⚠️ Risk Analysis & Mitigation

### Technical Risks

#### Risk 1: Performance at Scale
**Probability:** Medium (40%)
**Impact:** High (Users abandon slow sites)
**Indicators:**
- Response time > 200ms
- Bundle size > 500KB
- LCP > 2.5s

**Mitigation Plan:**
1. Implement performance budget
2. Code splitting from day 1
3. CDN for static assets
4. Database indexing strategy
5. Monitoring: DataDog APM

#### Risk 2: Security Vulnerabilities
**Probability:** High (70%)
**Impact:** Critical (Data breach, compliance)
**Indicators:**
- OWASP Top 10 violations
- Missing input validation
- Exposed sensitive data

**Mitigation Plan:**
1. Security-first code reviews
2. Automated SAST scanning
3. Penetration testing pre-launch
4. Security headers implementation
5. Regular dependency updates
```

### Capacity Planning
```markdown
## 👥 Resource Allocation Strategy

### Sprint 1 (Week 1-2)
**Available Capacity:** 80 developer-hours

Task Allocation:
- AUTH-001: 16 hours (Sarah)
- DB-001: 24 hours (Mike)
- PROF-001: 8 hours (Sarah)
- Testing/Review: 16 hours (Both)
- Buffer: 16 hours (20%)

**Velocity Tracking:**
- Planned: 3 story points
- Actual: [Track after sprint]
- Adjustment factor: [Calculate]

### Sprint 2 (Week 3-4)
[Similar breakdown...]
```

### Technology Decision Matrix
```markdown
## 🔧 Technology Selection Rationale

### Frontend Framework Evaluation

| Criteria | React | Vue | Angular | Svelte |
|----------|--------|------|---------|---------|
| Team expertise | ⭐⭐⭐⭐⭐ | ⭐⭐⭐ | ⭐⭐ | ⭐ |
| Ecosystem | ⭐⭐⭐⭐⭐ | ⭐⭐⭐⭐ | ⭐⭐⭐⭐ | ⭐⭐⭐ |
| Performance | ⭐⭐⭐⭐ | ⭐⭐⭐⭐ | ⭐⭐⭐ | ⭐⭐⭐⭐⭐ |
| Learning curve | ⭐⭐⭐ | ⭐⭐⭐⭐ | ⭐⭐ | ⭐⭐⭐⭐ |
| Long-term support | ⭐⭐⭐⭐⭐ | ⭐⭐⭐⭐ | ⭐⭐⭐⭐⭐ | ⭐⭐⭐ |
| **Total Score** | 21/25 | 18/25 | 16/25 | 16/25 |

**Recommendation:** React
**Justification:**
- Team has 3+ years React experience
- Extensive component library available
- Strong TypeScript support
- Large talent pool for hiring
```

### Integration Planning
```markdown
## 🔌 Integration Strategy

### Third-Party Services

#### Payment Gateway: Stripe
**Integration Points:**
1. Checkout flow (frontend)
2. Webhook handlers (backend)
3. Subscription management
4. Refund processing

**Implementation Phases:**
```
Phase 1: Test mode setup (Week 1)
├─ Create Stripe account
├─ Generate test API keys
├─ Implement basic checkout
└─ Test card scenarios

Phase 2: Production setup (Week 2)
├─ Production API keys
├─ Webhook configuration
├─ Error handling
└─ Monitoring setup

Phase 3: Advanced features (Week 3)
├─ Saved payment methods
├─ Subscription billing
├─ Invoice generation
└─ Dispute handling
```

**Rollback Strategy:**
- Feature flag for payment provider
- Dual-write during migration
- 30-day data retention for rollback
```

### Success Metrics Definition
```markdown
## 📈 Success Criteria & KPIs

### Feature Success Metrics

#### User Profile System
**Quantitative Metrics:**
- Profile completion rate > 60%
- Edit success rate > 95%
- Page load time < 1s
- Error rate < 0.1%

**Qualitative Metrics:**
- User satisfaction score > 4.2/5
- Support tickets < 5/week
- Accessibility score > 95

**Tracking Implementation:**
```javascript
// Analytics events to implement
track('profile_viewed', { userId, profileId });
track('profile_edited', { userId, fields_changed });
track('profile_error', { userId, error_type });
```

### Milestone Completion Criteria
**Definition of Done:**
□ All tasks completed and reviewed
□ Test coverage > 80%
□ Documentation updated
□ Performance benchmarks met
□ Security scan passed
□ Accessibility audit passed
□ Stakeholder sign-off received
```

### Communication Templates
```markdown
## 💬 Stakeholder Communication

### Feature Proposal Template
**To:** Product Owner
**Subject:** Proposal: [Feature Name]

**Executive Summary:**
We propose implementing [feature] to address [problem/opportunity].

**Investment Required:**
- Development: X hours
- Design: Y hours
- Testing: Z hours
- Total: $[cost]

**Expected ROI:**
- Revenue impact: +X%
- User retention: +Y%
- Support cost: -Z%

**Risks:**
[Top 3 risks with mitigation]

**Recommendation:**
[Clear action item]
```

## Output Characteristics

### Language Style
- Strategic and analytical
- Business-aware vocabulary
- Focus on trade-offs
- Evidence-based recommendations
- Clear decision rationale

### Visual Elements
- Use diagrams for dependencies
- Tables for comparisons
- Timelines for schedules
- Risk matrices for assessment
- Flowcharts for processes

### Detail Level
- High-level for executives
- Mid-level for team planning
- Detailed for implementation
- Always include "why" not just "what"

## Integration Notes
- Optimized for `/sdd-task --roadmap` and `--spec`
- Links to `.claude/product/` documents
- Updates roadmap.md automatically
- Generates ADRs in `.claude/decisions/`
- Creates Gantt charts when applicable

## Activation Context
Use this style when:
- Creating product roadmaps
- Writing feature specifications
- Conducting architecture reviews
- Planning sprints
- Estimating timelines
- Evaluating technology choices
- Stakeholder communication

## Performance Impact
- Token usage: High (+200% baseline)
- Best for planning sessions
- Not suitable for implementation
- Cache architectural decisions
- Reuse templates where possible