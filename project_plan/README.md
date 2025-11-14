# Siempreviva CSS Refactoring Project

**Status:** Sessions 1, 2a, 3 Complete ✅ | Session 4A In Progress 🎯
**Started:** October 21, 2025
**Current Branch:** `css-refactor/session-4a-view-migrations`

---

## Quick Overview

Refactoring CSS architecture to use Tailwind v4 `@theme` directive with component classes, establishing a clean, maintainable design system while preserving all existing functionality.

**Key Achievement:** Single source of truth for colors + modern component classes with full backward compatibility.

---

## Sessions Overview

### ✅ Session 1: CSS Architecture Foundation (COMPLETE)
**Completed:** October 22, 2025
**PR:** Merged to main
**What we did:**
- Created sv-color system (Tailwind v4 @theme)
- Converted components.scss → components.css
- Refactored forms.css with component classes
- Maintained full backward compatibility
- Tested cart & checkout views

**Details:** [`sessions/session_1_foundation.md`](./sessions/session_1_foundation.md)

---

### ✅ Session 2a: Product Views Refactoring (COMPLETE)
**Completed:** November 4, 2025
**PR:** Merged to main
**What we did:**
- Refactored products.css to use @apply with sv-colors
- Added missing component classes for product cards and sections
- Replaced inline Tailwind utilities in product partials
- Organized products.css with clear section structure

---

### ⏳ Session 2b: Marketing Views CSS Refactoring (NEXT)
**Status:** Ready to start (branching off Session 2a)
**Branch:** `amanda/css-refactor-session-2b` (based on `amanda/css-refactor-session-2a`)
**Focus:** Refactor marketing page styling to use component classes from Session 1

**Approach:**
- Start by branching off Session 2a (russian doll branching)
- When Session 2a merges to main, rebase Session 2b onto main
- Focus on marketing views: home, contact, gallery, learn, our_farms

**Details:** [`sessions/session_2b_marketing_views.md`](./sessions/session_2b_marketing_views.md)

---

### ✅ Session 3: Layout.css Refactoring & Modularization (COMPLETE)
**Completed:** November 5, 2025
**PR:** Merged to main
**What we did:**
- Refactored layout.css to use @apply with sv-colors
- Fixed mobile cart dropdown, sticky footer, and mobile menu button bugs
- Reorganized layout.css with clear section headers
- Split monolithic layout.css into modular files:
  - `layout.css` - Global layout and link styles
  - `header.css` - Header structure and logo
  - `navigation.css` - Mobile menu button and navigation
  - `footer.css` - Site footer and social links
- Documented inline utilities that must remain (responsive utilities)

**Details:** [`sessions/session_3_layout.md`](./sessions/session_3_layout.md)

---

### 🎯 Session 4: Legacy Views Migration & CSS Cleanup (IN PROGRESS - 4 Part Series)
**Started:** November 6, 2025
**Strategy:** Split into 4 independent PRs for manageable reviews

**Session 4A: View Migrations & Legacy Code Removal** (IN PROGRESS)
- **Branch:** `css-refactor/session-4a-view-migrations`
- **Status:** In progress
- **Focus:** Audit views for inline styles, migrate cart/checkout views, remove backward-compatibility code
- **Details:** [`sessions/session_4a_view_migrations.md`](./sessions/session_4a_view_migrations.md)

**Session 4B: cart.css Refactoring** (Upcoming)
- **Branch:** `css-refactor/session-4b-cart-css`
- **Focus:** Convert cart.css to @apply with sv-colors
- **Details:** [`sessions/session_4b_cart_css.md`](./sessions/session_4b_cart_css.md)

**Session 4C: checkouts.css Refactoring** (Upcoming)
- **Branch:** `css-refactor/session-4c-checkouts-css`
- **Focus:** Convert checkouts.css to @apply with sv-colors
- **Details:** [`sessions/session_4c_checkouts_css.md`](./sessions/session_4c_checkouts_css.md)

**Session 4D: email.css + search.css Refactoring** (Upcoming)
- **Branch:** `css-refactor/session-4d-email-search`
- **Focus:** Convert email.css and search.css to @apply with sv-colors
- **Details:** [`sessions/session_4d_email_search_css.md`](./sessions/session_4d_email_search_css.md)

---

### 🔮 Session 5: Specificity Cleanup & !important Removal (FUTURE)
**When:** After Session 4 complete
**Estimated Time:** 2-3 hours
**Focus:** Remove all `!important` declarations by fixing underlying CSS specificity issues

**Scope:**
- Audit all `!important` declarations across codebase
- Analyze root causes of specificity conflicts
- Fix specificity issues systematically
- Convert vanilla CSS to @apply where appropriate
- Thorough testing across all breakpoints and browsers

**Why it's last:**
Throughout Sessions 2-4, we intentionally left `!important` declarations in place to avoid scope creep. Session 5 addresses this technical debt systematically once all CSS files are refactored.

**Details:** [`sessions/session_5_specificity_cleanup.md`](./sessions/session_5_specificity_cleanup.md)

---

### 🔧 Session 5: CSS Specificity & !important Cleanup (FUTURE)
**When:** After Sessions 2a/2b complete
**Focus:** Remove !important hacks, fix CSS specificity issues, establish proper architecture

**Details:** [`sessions/session_5_specificity_cleanup.md`](./sessions/session_5_specificity_cleanup.md)

---

## Key Resources

### Technical Documentation
- **[Color System](./technical/color_inventory.md)** - sv-color palette and usage
- **[Design Decisions](./technical/design_decisions.md)** - Why we made key choices
- **[Testing Checklist](./technical/testing_checklist.md)** - Testing requirements

### Implementation Notes
- **[PHASE_1_NOTES.md](../PHASE_1_NOTES.md)** - Detailed Session 1 implementation notes
- **[Component Classes Reference](./technical/component_classes.md)** - Available classes and examples

---

## Quick Start: Using the New System

### New Component Classes Available:

**Buttons:**
```html
<a href="/products" class="btn-primary">Shop Now</a>
<a href="/contact" class="btn-secondary">Contact Us</a>
<button class="btn-green">Add to Cart</button>
```

**Forms:**
```html
<form class="form-container">
  <label class="label-text">Email</label>
  <input type="email" class="input-text">
  <button type="submit" class="btn-submit">Submit</button>
</form>
```

**Colors:**
```css
.my-component {
  @apply bg-sv-purple-400 text-white border-sv-green-600;
}
```

---

## Current File Status

| File | Status | Notes |
|------|--------|-------|
| `application.css` | ✅ Refactored | Has @theme block with sv-colors |
| `components.css` | ✅ Refactored | New component classes with @apply |
| `forms.css` | ✅ Refactored | Component classes + backward compatibility |
| `layout.css` | ✅ Refactored | Global layout structure (71 lines) |
| `header.css` | ✅ Created | Header structure and logo (90 lines) |
| `navigation.css` | ✅ Created | Mobile menu and navigation (157 lines) |
| `footer.css` | ✅ Created | Site footer and social links (96 lines) |
| `products.css` | ✅ Refactored | Product cards and sections with @apply |
| `cart.css` | 🎯 Session 4B | Refactoring in progress |
| `checkouts.css` | 🎯 Session 4C | Refactoring in progress |
| `email.css` | 🎯 Session 4D | Refactoring in progress |
| `search.css` | 🎯 Session 4D | Refactoring in progress |
| `components.scss` | ⚠️ Deprecated | No longer imported |

---

## Project Goals (Recap)

✅ Single source of truth for colors
✅ Component classes using @apply
✅ No inline Tailwind utilities
✅ Preserve all existing functionality
✅ Maintain backward compatibility
🎯 Clean, maintainable design system

---

---

## Session 4 Branching Strategy

Session 4 uses a **mixed strategy** to allow parallel work while maintaining clean git history:

```
main
  ├─ css-refactor/session-4a-view-migrations (DO FIRST)
  ├─ css-refactor/session-4b-cart-css (independent)
  ├─ css-refactor/session-4c-checkouts-css (independent)
  └─ css-refactor/session-4d-email-search (independent)
```

**Key Points:**
- 4A must be done first (changes views)
- 4B, 4C, 4D branch from `main`, NOT from 4A
- 4B, 4C, 4D can be worked on in parallel or any order
- All can be reviewed/merged independently after 4A

**See:** `SESSION_4_BRANCHING_STRATEGY.md` in root for detailed workflow

---

*Last Updated: November 6, 2025*
