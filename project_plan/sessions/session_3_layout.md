# Session 3: Layout & Navigation

**Status:** 📋 OPTIONAL - Future
**When:** If/when we need to modify header, navigation, or footer
**Estimated Time:** 2-3 hours

---

## Overview

Refactor layout.css to use component classes with @apply, improving maintainability of header, navigation, and footer components.

---

## Scope

### Files to Refactor
- `app/assets/tailwind/layout.css` (639 lines)

### Components to Address
- Header & navigation (fixed header, mobile/desktop variants)
- Logo section
- Footer
- Body/main layout and spacing
- Link hover styles
- Social icons

---

## Approach

### Create Component Classes
- `.header-fixed` - Fixed header styles
- `.nav-desktop` / `.nav-mobile` - Navigation variants
- `.footer-standard` - Footer styling
- `.logo-standard` - Logo styling

### Preserve Responsive Patterns
- Keep media queries but use @apply where possible
- Consider Tailwind responsive prefixes (md:, lg:, etc.)

---

## Why Optional

**Current State:** Header, nav, and footer work perfectly as-is
**Backward Compatibility:** No changes needed for existing views
**Risk:** Low, but touches site-wide components

**Do this when:**
- We need to modify header/nav/footer design
- We're adding new navigation features
- We want to improve mobile menu functionality

---

## Success Criteria

✅ Header/nav/footer use component classes
✅ Responsive behavior maintained
✅ Mobile menu works correctly
✅ All pages render unchanged
✅ No visual regressions

---

*Can be done anytime after Session 2, or skipped entirely*
