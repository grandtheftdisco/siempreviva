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

**Session 4B: cart.css Refactoring** (Upcoming)
- **Branch:** `css-refactor/session-4b-cart-css`
- **Focus:** Convert cart.css to @apply with sv-colors

**Session 4C: checkouts.css Refactoring** (Upcoming)
- **Branch:** `css-refactor/session-4c-checkouts-css`
- **Focus:** Convert checkouts.css to @apply with sv-colors

**Session 4D: email.css + search.css Refactoring** (Upcoming)
- **Branch:** `css-refactor/session-4d-email-search`
- **Focus:** Convert email.css and search.css to @apply with sv-colors

**Session 4E: semantic grouping of @apply directives** (Upcoming)
- **Branch:** `css-refactor/session-4e-semantic-grouping`
- **Focus:** Apply the semantic grouping pattern (established in 4A) consistently across all CSS files in the codebase

**Details:** [`sessions/session_4_legacy_cleanup.md`](./sessions/session_4_legacy_cleanup.md)

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
| `layout.css` | ⏳ Future | Works as-is, refactor when needed |
| `cart.css` | ⏳ Future | Works as-is, refactor when needed |
| `checkouts.css` | ⏳ Future | Works as-is, refactor when needed |
| `products.css` | ✅ Refactored | Component classes with @apply (Session 2a) |
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

*Last Updated: November 4, 2025*
