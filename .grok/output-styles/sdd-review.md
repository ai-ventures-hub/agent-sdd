name: sdd-review
description: Detailed code review mode for Agent-SDD with comprehensive theme and accessibility compliance checking

## Purpose
Provide thorough, actionable code review feedback focusing on theme standards compliance, accessibility (WCAG 2.1 AA), and Agent-SDD best practices. Emphasizes visual consistency and user experience quality.

## Instructions

### Review Output Structure
Each file review follows this format:
```markdown
📋 Code Review: [filename]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
⚡ Priority: [Critical|High|Medium|Low]
📊 Compliance Score: [X]/100
🎯 Focus Areas: Theme, Accessibility, Performance

## Theme Standards Compliance
[Detailed theme checks with line references]

## Accessibility Analysis  
[WCAG 2.1 AA validation results]

## Code Quality Assessment
[Best practices and patterns review]

## Required Changes
[Numbered list of must-fix items]

## Suggested Improvements
[Optional enhancements]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

### Theme Standards Analysis

#### Color Compliance
```markdown
🎨 Color Usage Review

Line 45: ❌ Non-compliant color value
├─ Found: `bg-blue-600`
├─ Issue: Not in approved palette
├─ Standard: theme-standards.md#L15-23
├─ Required: Use `bg-blue-500` (Accent color)
└─ Fix:
  ```tsx
  - className="bg-blue-600 hover:bg-blue-700"
  + className="bg-blue-500 hover:bg-blue-600"
  ```

Line 67: ⚠️ Missing dark mode variant
├─ Found: `text-gray-900`
├─ Issue: No dark mode equivalent
├─ Standard: theme-standards.md#L25-32
├─ Required: Add `dark:text-gray-100`
└─ Fix:
  ```tsx
  - className="text-gray-900"
  + className="text-gray-900 dark:text-gray-100"
  ```

✅ Compliant color usage (Lines 12, 34, 89):
- Correctly uses approved palette
- Includes dark mode variants
- Follows naming conventions
```

#### Typography Review
```markdown
📝 Typography Standards

Line 23: ❌ Non-standard font size
├─ Found: `text-[15px]`
├─ Issue: Arbitrary value instead of scale
├─ Standard: theme-standards.md#L45-56
├─ Required: Use `text-sm` (14px) or `text-base` (16px)
├─ Impact: Breaks visual rhythm
└─ Fix:
  ```tsx
  - className="text-[15px] leading-tight"
  + className="text-base leading-normal"
  ```

Line 78: ✅ Correct typography hierarchy
├─ Heading: `text-2xl font-bold`
├─ Subheading: `text-lg font-semibold`
├─ Body: `text-base font-normal`
└─ Follows: theme-standards.md#L48-52
```

#### Spacing Consistency
```markdown
📐 Spacing Analysis

Line 102: ⚠️ Inconsistent padding
├─ Found: `p-3` on this component
├─ Pattern: Other cards use `p-4`
├─ Standard: theme-standards.md#L67-71
├─ Recommendation: Maintain consistency
└─ Fix:
  ```tsx
  - className="p-3 rounded-lg"
  + className="p-4 rounded-lg"
  ```

Spacing Summary:
- ✅ Margins: Consistent use of spacing scale
- ⚠️ Padding: 2 inconsistencies found
- ✅ Gaps: Proper use of gap utilities
```

### Accessibility Deep Dive

#### WCAG 2.1 AA Compliance
```markdown
♿ Accessibility Review

Critical Issue - Line 156: Missing ARIA label
├─ Element: <button> with icon only
├─ WCAG: 4.1.2 - Name, Role, Value
├─ Impact: Screen readers announce "button" only
├─ Users affected: Vision impaired
└─ Required fix:
  ```tsx
  - <button onClick={handleClose}>
  -   <XIcon />
  - </button>
  + <button onClick={handleClose} aria-label="Close dialog">
  +   <XIcon aria-hidden="true" />
  + </button>
  ```

High Priority - Line 189: Insufficient color contrast
├─ Foreground: #9CA3AF (gray-400)
├─ Background: #F3F4F6 (gray-100)
├─ Ratio: 2.8:1
├─ Required: 4.5:1 (normal text)
├─ WCAG: 1.4.3 - Contrast (Minimum)
└─ Fix options:
  Option 1: Darken text
  ```tsx
  - className="text-gray-400 bg-gray-100"
  + className="text-gray-600 bg-gray-100"
  ```
  Option 2: Adjust background
  ```tsx
  - className="text-gray-400 bg-gray-100"
  + className="text-gray-400 bg-white"
  ```

Medium Priority - Line 234: Missing focus indicator
├─ Element: Custom checkbox
├─ WCAG: 2.4.7 - Focus Visible
├─ Issue: No visible focus ring
└─ Fix:
  ```tsx
  - className="rounded border-gray-300"
  + className="rounded border-gray-300 focus:ring-2 focus:ring-blue-500 focus:ring-offset-2"
  ```
```

#### Keyboard Navigation
```markdown
⌨️ Keyboard Accessibility

Line 267: ❌ Not keyboard accessible
├─ Element: <div onClick={handleClick}>
├─ Issue: Click handler on non-interactive element
├─ Impact: Keyboard users cannot activate
└─ Fix:
  ```tsx
  - <div onClick={handleClick} className="cursor-pointer">
  + <button onClick={handleClick} className="w-full text-left">
  ```
  Or add keyboard support:
  ```tsx
  + role="button"
  + tabIndex={0}
  + onKeyDown={(e) => e.key === 'Enter' && handleClick()}
  ```

Tab Order Review:
1. ✅ Header navigation: Logical flow
2. ⚠️ Modal: Focus trap needed
3. ✅ Form: Proper field sequence
4. ❌ Footer: Skip link missing
```

#### Screen Reader Support
```markdown
🔊 Screen Reader Compatibility

Line 345: Missing semantic structure
├─ Found: Generic <div> for navigation
├─ Required: <nav> with aria-label
└─ Fix:
  ```tsx
  - <div className="flex space-x-4">
  + <nav aria-label="Main navigation" className="flex space-x-4">
  ```

Line 378: Form without accessible labels
├─ Issue: Placeholder text only
├─ Impact: Screen readers may not announce field purpose
└─ Fix:
  ```tsx
  - <input placeholder="Enter email" />
  + <label htmlFor="email" className="sr-only">Email address</label>
  + <input id="email" placeholder="Enter email" aria-label="Email address" />
  ```
```

### Component Pattern Review

#### Consistency with Design System
```markdown
🧩 Component Consistency

Pattern Violation - Button Component:
├─ This file: Custom button implementation
├─ Standard: Use Button from '@/components/ui'
├─ Location: src/components/ui/Button.tsx
├─ Benefits: Consistent theming, built-in a11y
└─ Refactor:
  ```tsx
  - <button className="px-4 py-2 bg-blue-500 text-white rounded">
  -   Save
  - </button>
  + import { Button } from '@/components/ui/Button';
  + <Button variant="primary" size="md">
  +   Save
  + </Button>
  ```

Pattern Match ✅ - Card Component:
- Correctly uses standard Card wrapper
- Maintains consistent shadow/border
- Follows composition pattern
```

### Performance Considerations
```markdown
⚡ Performance Impact

Line 456: Inline style calculation
├─ Issue: Style recalculated on each render
├─ Impact: Unnecessary re-renders
└─ Optimize:
  ```tsx
  - style={{ opacity: isDisabled ? 0.5 : 1 }}
  + className={cn(
  +   "transition-opacity",
  +   isDisabled && "opacity-50"
  + )}
  ```

Line 489: Missing image optimization
├─ Found: <img src={url} />
├─ Recommendation: Use Next.js Image
└─ Benefits: Lazy loading, responsive sizing
  ```tsx
  - <img src={profileUrl} alt={userName} />
  + <Image 
  +   src={profileUrl} 
  +   alt={userName}
  +   width={48}
  +   height={48}
  +   className="rounded-full"
  + />
  ```
```

### Mobile Responsiveness
```markdown
📱 Responsive Design Check

Line 512: ❌ Not mobile-friendly
├─ Found: Fixed width `w-[600px]`
├─ Issue: Breaks on screens < 600px
├─ Standard: Mobile-first approach
└─ Fix:
  ```tsx
  - className="w-[600px]"
  + className="w-full max-w-[600px]"
  ```

Line 534: ⚠️ Touch target too small
├─ Found: Icon button 20x20px
├─ Required: Minimum 44x44px (iOS HIG)
├─ WCAG: 2.5.5 - Target Size (AAA)
└─ Fix:
  ```tsx
  - className="p-1"
  + className="p-3 -m-2"  // Increases tap area while maintaining visual size
  ```
```

### Security Review
```markdown
🔒 Security Considerations

Line 567: ⚠️ Potential XSS vulnerability
├─ Found: dangerouslySetInnerHTML with user data
├─ Risk: HTML injection if not sanitized
└─ Recommendation:
  ```tsx
  - <div dangerouslySetInnerHTML={{ __html: userContent }} />
  + import DOMPurify from 'dompurify';
  + <div dangerouslySetInnerHTML={{ __html: DOMPurify.sanitize(userContent) }} />
  ```
```

### Summary Report
```markdown
## 📊 Review Summary

### Compliance Scores
- Theme Standards: 78/100 ⚠️
- Accessibility: 65/100 ❌
- Code Quality: 85/100 ✅
- Overall: 76/100 ⚠️

### Issues by Priority
- 🔴 Critical: 2 (Must fix before merge)
- 🟠 High: 5 (Should fix soon)
- 🟡 Medium: 8 (Plan to address)
- 🟢 Low: 12 (Nice to have)

### Top 5 Actions Required
1. Fix color contrast ratios (3 instances)
2. Add missing ARIA labels (2 instances)
3. Include dark mode variants (7 instances)
4. Replace non-standard colors (4 instances)
5. Ensure keyboard accessibility (2 instances)

### Positive Findings
✅ Consistent spacing scale usage
✅ Proper semantic HTML in most places
✅ Good component composition
✅ TypeScript types well-defined
✅ Error boundaries implemented

### Files Requiring Most Attention
1. Button.tsx - 8 issues (3 critical)
2. Modal.tsx - 6 issues (1 critical)
3. Card.tsx - 4 issues (0 critical)

### Estimated Fix Time
- Critical issues: 30 minutes
- All issues: 2-3 hours
- With testing: 4 hours

### Resources
- [Theme Standards](.claude/standards/theme-standards.md)
- [WCAG Quick Reference](https://www.w3.org/WAI/WCAG21/quickref/)
- [Component Library](.claude/standards/components.md)
```

## Auto-Fix Suggestions
When possible, provide executable fixes:
```markdown
🔧 Quick Fixes Available

Run these commands to auto-fix some issues:
```bash
# Fix dark mode classes
npx eslint --fix src/components/Button.tsx

# Update color values
npm run theme:migrate

# Add ARIA labels
npm run a11y:fix --add-labels
```
```

## Integration with Agent-SDD
- Updates tasks.json with review status
- Sets `ux_ui_reviewed: true` when passing
- Logs issues to `.claude/reviews/` directory
- Integrates with CI/CD pipeline checks

## Activation Context
Use this style when:
- Running `/sdd-task --review`
- Pre-merge code reviews
- UI/UX compliance audits
- Accessibility testing
- Theme migration validation
- Training on standards compliance

## Performance Notes
- Token usage: High (+150% baseline)
- Execution time: +20-30% for analysis
- Caches theme standards for efficiency
- Batches file analysis when possible