# /sdd-apply-theme
Apply a custom theme to Agent-SDD with optional color customization:

Prompt user:
"Enter theme name (e.g., Syntax):"
"Enter paths to CSS file (e.g., /src/app.css), component directory (e.g., /src/components/ui/), and Markdoc config (e.g., /src/markdoc/)."
"Customize colors? [y/n]"
If yes, prompt for new colors: "Primary color (hex, RGB, or OKLCH):", "Secondary color:", "Success color:", "Error color:" (default to Syntax colors if not provided).


Create .agent-sdd/standards/theme-files/[theme-name]/ and copy specified files (e.g., app.css, components/ui/button.tsx, markdoc/search.mjs).
If colors are customized:
Parse app.css for @theme variables (e.g., --color-primary, --color-secondary).
Validate user-provided colors (e.g., hex: /^#([0-9a-f]{6})$/i, RGB: /^rgb\(\d{1,3},\s*\d{1,3},\s*\d{1,3}\)$/, OKLCH: /^oklch\([0-1]\.\d+ \d+\.\d+ \d+\.\d+\)$/).
Create .agent-sdd/standards/theme-files/[theme-name]/syntax-custom.css with updated @theme variables:@import "tailwindcss";
@theme {
  --color-primary: [user-provided-primary]; /* e.g., #2563eb */
  --color-secondary: [user-provided-secondary]; /* e.g., #6b7280 */
  --color-success: [user-provided-success]; /* e.g., #22c55e */
  --color-error: [user-provided-error]; /* e.g., #ef4444 */
  /* Retain non-color variables from original app.css */
  --font-sans: "Inter", sans-serif;
  --spacing-4: 1rem;
  --breakpoint-md: 768px;
  --animate-fade-in: fade-in 0.3s ease-out;
  @keyframes fade-in {
    0% { opacity: 0; }
    100% { opacity: 1; }
  }
}


Extract component patterns from component files (e.g., <Button className="bg-primary text-white rounded-sm">).
Extract Markdoc styling from /src/markdoc/ (e.g., code block classes like bg-gray-900 text-white p-4).
Update .agent-sdd/standards/theme-standards.md with extracted and customized standards:# Theme Standards ([theme-name])
- **Colors**:
  - Primary: `bg-primary` ([user-provided-primary, e.g., #2563eb])
  - Secondary: `bg-secondary` ([user-provided-secondary, e.g., #6b7280])
  - Success: `bg-success` ([user-provided-success, e.g., #22c55e])
  - Error: `bg-error` ([user-provided-error, e.g., #ef4444])
- **Typography**: From `@theme --font-*` (e.g., `--font-sans: Inter, sans-serif`)
- **Spacing**: From `@theme --spacing-*` (e.g., `--spacing-4: 1rem`)
- **Breakpoints**: From `@theme --breakpoint-*` (e.g., `--breakpoint-md: 768px`)
- **Components**: From component files (e.g., `<Button className="bg-primary text-white rounded-sm">`)
- **Animations**: From `@theme --animate-*` (e.g., `--animate-fade-in`)
- **Accessibility**: WCAG 2.1 AA, ARIA labels (from Headless UI components)
- **Reference Files**: See `.agent-sdd/standards/theme-files/[theme-name]/`


Log decision in .agent-sdd/product/decisions.md:- [CURRENT_DATE]: Applied [theme-name] with [customized/unchanged] colors (DEC-XXX, Accepted, Technical)
  - Rationale: Align with project branding
  - Files: `.agent-sdd/standards/theme-files/[theme-name]/`


Update .agent-sdd/agents/code-reviewer.md to prioritize .agent-sdd/standards/theme-files/[theme-name]/syntax-custom.css (if exists) for color compliance:- Check `.agent-sdd/standards/theme-files/[theme-name]/syntax-custom.css` (if exists) for `@theme` color variables before `app.css`.
- Validate components use updated colors (e.g., `bg-primary` maps to user-provided #2563eb).
- Replace non-compliant colors (e.g., `bg-blue-500`) with updated `bg-primary`.


Run /sdd-review-code on existing components (e.g., components/*.tsx) to enforce updated colors.
Notify user: “[theme-name] theme applied with [customized/unchanged] colors. Files in theme-files/[theme-name]/. Run /sdd-review-code to verify.”

Constraints

Preserve non-color @theme variables (e.g., fonts, spacing, animations) from original app.css unless explicitly overridden.
Never overwrite original theme files; use syntax-custom.css for modifications.
Validate user-provided colors for hex, RGB, or OKLCH formats.
Ensure code-reviewer prioritizes syntax-custom.css for color checks.
Use date-checker agent to get [CURRENT_DATE] in YYYY-MM-DD format.
If no color customization, copy original app.css styles unchanged.
