# Theme Standards

> **Instructions:**  
> - This file defines the **visual design system** for the project.  
> - Update it whenever you change colors, typography, spacing, or component styles.  
> - Keep it accurate so developers can copy settings directly into code without guessing.  
> - All examples use **Tailwind CSS** utilities.  
> - Include **both light and dark mode** values when applicable.

---

## 1. Colors

### Light Mode
- **Primary:** `#4B5563` (`bg-gray-600`)
- **Secondary:** `#E5E7EB` (`bg-gray-200`)
- **Accent:** `#3B82F6` (`bg-blue-500`)
- **Success:** `#10B981` (`bg-green-500`)
- **Warning:** `#F59E0B` (`bg-yellow-500`)
- **Error:** `#EF4444` (`bg-red-500`)
- **Background:** `#FFFFFF`
- **Text:** `#111827`

### Dark Mode
- **Primary:** `#9CA3AF` (`text-gray-400`)
- **Secondary:** `#374151` (`bg-gray-700`)
- **Accent:** `#60A5FA` (`bg-blue-400`)
- **Success:** `#34D399` (`bg-green-400`)
- **Warning:** `#FBBF24` (`bg-yellow-400`)
- **Error:** `#F87171` (`bg-red-400`)
- **Background:** `#1F2937`
- **Text:** `#F9FAFB`

**Rule:** Always use Tailwind color utilities — no hardcoded hex unless unavailable in the theme.

---

## 2. Typography

- **Font Family:** `Roboto`, sans-serif  
- **Base Size:** `14px` (`text-sm`)  
- **Line Height:** `1.5` (`leading-relaxed`)  
- **Headings:**  
  - H1: `text-3xl font-bold`  
  - H2: `text-2xl font-semibold`  
  - H3: `text-xl font-medium`  
- **Dark Mode Text:** `dark:text-gray-100`

---

## 3. Spacing & Layout

- **Spacing Unit:** 4px grid (Tailwind scale: `1` = 4px)  
  - Margin: `m-1` = 4px, `m-2` = 8px, `m-3` = 12px, etc.  
  - Padding: `p-1` = 4px, `p-2` = 8px, `p-3` = 12px, etc.  
  - Gap: `gap-1` = 4px, `gap-2` = 8px, etc.  
- **Container Widths:**  
  - Small: `max-w-sm`  
  - Medium: `max-w-md`  
  - Large: `max-w-lg`  
  - Full: `w-full`

---

## 4. Mobile-First & Breakpoints

- **Approach:** Design for mobile first, then enhance for larger screens.  
- **Tailwind Breakpoints:**
```js
theme: {
  screens: {
    sm: '640px',
    md: '768px',
    lg: '1024px',
    xl: '1280px',
    '2xl': '1536px'
  }
}
```
Rule: Default classes = mobile, use sm:, md:, lg: for overrides.

## 5. Components

Buttons

```
<Button
  variant="outline"
  className="bg-gray-600 text-white rounded-sm px-4 py-2 hover:bg-gray-700 dark:bg-gray-400 dark:text-black dark:hover:bg-gray-300"
>
  Click Me
</Button>

```

Cards

```
<Card className="p-4 bg-white shadow-md dark:bg-gray-800 dark:text-gray-100">
  <CardContent>
    Your content here
  </CardContent>
</Card>
```

## 6. State Styles

Always define:
- hover:
- focus:
- active:
- disabled:
- Ensure focus styles are visible and meet accessibility contrast.

Apply state styles for both light and dark modes.

## 7. Shadow & Elevation

- shadow-sm → subtle
- shadow-md → hover states
- shadow-lg → modals/dialogs
- No inline box-shadow unless documented.

## 8. Border Radius

- Standard: rounded-md
- Pills/tags: rounded-full
- Avoid mixing radii in the same component group.

## 9. Iconography

- Library: lucide-react (or as defined in project)
- Stroke width consistent across all icons
- Sizes: w-4 h-4 inline, w-6 h-6 standalone

## 10. Animation & Motion

- Default: transition-colors duration-200 ease-in-out
- No excessive motion — must serve a functional purpose.

## 11. Image & Media

- Use responsive images (<Image> in Next.js) with defined dimensions.
- Maintain consistent aspect ratios.
- Enable lazy loading for mobile optimization.

## 12. Accessibility

- WCAG 2.1 AA compliance
- ARIA attributes for all interactive elements
- Min touch target: 40px x 40px
- Always keep focus states visible

## 13. Tailwind Usage

- Utility-first classes for styling.
- Avoid custom CSS unless documented in decisions.md.
- For dark mode, use Tailwind’s dark: variant or a theme provider.
