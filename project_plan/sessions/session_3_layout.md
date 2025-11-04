# Session 3: Layout & Navigation

**Status:** 🎯 IN PROGRESS
**Branch:** `amanda/css-refactor-session-3` (based on main)
**Base Branch:** `main`

---

## Overview

Refactor layout.css to use component classes with @apply, improving maintainability of header, navigation, and footer components. Header/nav/footer are already built and in main, so this is a refactoring session similar to Session 2a.

---

## Scope

### Files to Refactor
- `app/assets/tailwind/layout.css` (639 lines)
- Header/nav/footer view files (to extract inline Tailwind)

### Components to Address
- Header & navigation (fixed header, mobile/desktop variants)
- Logo section
- Footer
- Body/main layout and spacing
- Link hover styles
- Social icons
- Known bugs (to be reviewed and addressed if applicable)

---

## Task List

### Task 1: Audit layout.css ⏳ PENDING
**Objective:** Identify vanilla CSS that needs converting to @apply with sv-colors

**What to look for:**
- Hex color values → sv-color variables
- Vanilla CSS selectors → component classes with @apply
- Repeated patterns that could be extracted
- Specificity issues or !important hacks

---

### Task 2: Audit Header/Nav/Footer Views ⏳ PENDING
**Objective:** Identify inline Tailwind utilities that should be extracted to component classes

**Files to review:**
- `app/views/layouts/application.html.erb` (header/footer)
- Nav menu partials
- Related layout partials

**What to extract:**
- Repeated utility patterns
- Complex utility combinations
- Layout-specific styling

---

### Task 3: Create Component Classes ⏳ PENDING
**Objective:** Define reusable component classes for layout patterns

**Examples:**
- `.header-fixed` - Fixed header styles
- `.nav-desktop` / `.nav-mobile` - Navigation variants
- `.footer-standard` - Footer styling
- `.logo-standard` - Logo styling
- `.nav-link` - Navigation link styles
- `.mobile-menu-button` - Mobile menu toggle

---

### Task 4: Refactor layout.css ⏳ PENDING
**Objective:** Convert vanilla CSS to @apply with sv-colors

**Process:**
- Replace hex colors with sv-color variables
- Convert vanilla selectors to component classes using @apply
- Organize with clear section headers (like products.css in Session 2a)
- Move media queries adjacent to base classes

---

### Task 5: Replace Inline Tailwind in Views ⏳ PENDING
**Objective:** Update header/nav/footer views to use new component classes

**Keep in mind:**
- Layout/positioning utilities can stay inline (Tailwind best practice)
- Extract repeated patterns and styling
- Preserve responsive behavior

---

### Task 6: Test Layout Across Breakpoints ⏳ PENDING
**Test checklist:**
- [ ] Header renders correctly (mobile, tablet, desktop)
- [ ] Navigation menu works (desktop dropdown, mobile hamburger)
- [ ] Footer renders correctly (all breakpoints)
- [ ] Logo displays correctly
- [ ] Fixed header behavior correct on scroll
- [ ] Mobile menu animations work
- [ ] No console errors
- [ ] All pages render unchanged

---

### Task 7: Review Known Bugs ⏳ PENDING
**Objective:** Check known bugs against this branch and address if applicable

**Known bugs to review:**
- (To be discussed)

---

### Task 8: Code Cleanup & PR Writing ⏳ PENDING
**Code cleanup:**
- Remove TODO comments (if any)
- Remove console.log statements
- Verify formatting
- Check for trailing whitespace

**PR writing:**
- Document all changes
- Explain inline Tailwind decisions
- Include testing checklist
- Note any visual improvements or bug fixes

---

## Approach

### Preserve Responsive Patterns
- Keep media queries but use @apply where possible
- Consider Tailwind responsive prefixes (md:, lg:, etc.) where appropriate
- Media queries should be adjacent to base classes (learned from Session 2a)

### CSS Organization
- Use clear section headers: `/* ===== SECTION NAME ===== */`
- Group related styles together
- Media queries inline with base classes
- Logical flow: header → nav → footer → utilities

---

## Success Criteria

✅ layout.css refactored to use @apply with sv-colors
✅ Header/nav/footer use component classes where appropriate
✅ Responsive behavior maintained
✅ Mobile menu works correctly
✅ All pages render unchanged
✅ No visual regressions
✅ Known bugs addressed if applicable
✅ Code cleaned up and PR submitted

---

*Session started: November 4, 2025*
