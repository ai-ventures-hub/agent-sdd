# Project Decisions

> **How to Use This File:**  
> - Record **significant decisions** that affect your project's direction or implementation
> - Include technical choices, process changes, feature decisions, and business logic  
> - Use the template format below for consistency
> - Don't delete old decisions - mark them as "Reversed" if changed later

---

## What Decisions to Record

**Technical Decisions:**
- Framework/library choices
- Architecture patterns
- Database design choices
- Security implementations

**Process Decisions:**
- Development workflow changes
- Testing strategies
- Deployment approaches
- Code review processes

**Product Decisions:**
- Feature prioritization
- User experience choices
- Scope changes
- Business rule definitions

---

## Entry Template

**[YYYY-MM-DD] – [Decision Title]**  
**What:** [Brief description of what was decided]  
**Why:** [Reasoning, constraints, or context that led to this decision]  
**Impact:** [How this affects development, users, or project scope]  
**Status:** Active / Reversed on [date]

---

## Example Decisions

**[2025-01-15] – Use REST API Instead of GraphQL**  
**What:** Decided to build a REST API for the backend instead of GraphQL.  
**Why:** Team has more experience with REST, simpler caching, and client requirements are straightforward.  
**Impact:** API endpoints will follow REST conventions, affects frontend data fetching patterns.  
**Status:** Active

---

**[2025-02-03] – Implement User Authentication Before Social Features**  
**What:** Prioritize basic user auth (login/signup) over social features like commenting.  
**Why:** Authentication is required for most other features and affects database design.  
**Impact:** Social features pushed to Phase 2, auth system must be scalable for future features.  
**Status:** Active

---

**[2025-02-20] – Weekly Code Reviews for All Pull Requests**  
**What:** Established mandatory code review process with weekly review sessions.  
**Why:** Improve code quality, knowledge sharing, and catch bugs early.  
**Impact:** All PRs require approval before merge, may slow initial development but improves quality.  
**Status:** Active

---

## Your Decisions

*Start recording your project decisions here...*

---

**Tips:**
- Write decisions when they're made, not weeks later
- Focus on "why" - future you will forget the context
- Include alternatives considered if helpful
- Update status if decisions change rather than deleting entries
