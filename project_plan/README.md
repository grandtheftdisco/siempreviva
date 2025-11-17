# Siempreviva CSS Refactoring Project

**Status:** Sessions 1-4D Complete ✅ | Session 5A Ready to Begin 🎯
**Started:** October 21, 2025
**Current Branch:** `css-refactor/session-5-plan-update`
**Last Updated:** November 17, 2025

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

### ✅ Session 4: Legacy Views Migration & CSS Cleanup (COMPLETE - 4 Part Series)
**Completed:** November 14, 2025 (all PRs merged)
**Strategy:** Split into 4 independent PRs for manageable reviews

**Session 4A: View Migrations & Legacy Code Removal** ✅
- **Branch:** `css-refactor/session-4a-view-migrations` (merged)
- **Focus:** Audit views for inline styles, migrate cart/checkout views, remove backward-compatibility code
- **Details:** [`sessions/session_4a_view_migrations.md`](./sessions/session_4a_view_migrations.md)

**Session 4B: cart.css Refactoring** ✅
- **Branch:** `css-refactor/session-4b-cart-css` (merged)
- **Focus:** Convert cart.css to @apply with sv-colors, modularize into 4 files
- **Details:** [`sessions/session_4b_cart_css.md`](./sessions/session_4b_cart_css.md)

**Session 4C: checkouts.css Refactoring** ✅
- **Branch:** `css-refactor/session-4c-checkouts-css` (merged)
- **Focus:** Convert checkouts.css to @apply with sv-colors
- **Details:** [`sessions/session_4c_checkouts_css.md`](./sessions/session_4c_checkouts_css.md)

**Session 4D: email.css + search.css Refactoring** ✅
- **Branch:** `css-refactor/session-4d-email-search` (merged)
- **Focus:** Convert email.css and search.css to @apply with sv-colors
- **Details:** [`sessions/session_4d_email_search_css.md`](./sessions/session_4d_email_search_css.md)

---

### 🎯 Session 5A: Specificity Cleanup & Critical Foundation Fixes (NEXT)
**Status:** Ready to begin
**Estimated Time:** 12-15 hours (2-3 days)
**Branch:** TBD
**Focus:** Fix critical blocking issues before styling remaining views

**Scope:**
- Fix color palette conflicts (duplicate sv-purple-600, sv-purple-25 vs -50)
- Remove layout.css legacy :root block and duplicate selectors
- Convert generic Tailwind colors to sv-colors (11 instances)
- Convert rgba() colors to Tailwind opacity modifiers (9 instances)
- Reduce critical !important declarations (~250 in cart components)
- Convert `background: transparent` to `@apply bg-transparent` (19 instances)
- Comprehensive testing across all breakpoints

**Why this is next:**
These are blocking issues that must be fixed before styling marketing views, mailers, and admin dashboard. Provides clean foundation for remaining development.

**Details:** [`sessions/session_5a_specificity_cleanup.md`](./sessions/session_5a_specificity_cleanup.md)

---

### ⏸️ Session 5B: Semantic Grouping Retroactive Pass (DEFERRED)
**Status:** Deferred until post-MVP
**Estimated Time:** 4-5 hours
**Focus:** Apply semantic grouping pattern to remaining CSS files

**Scope:**
- layout.css (after 5A cleanup)
- header.css
- footer.css
- navigation.css
- products.css

**Why deferred:**
Semantic grouping is code organization, not functionality. Most critical files already have it applied (components, forms, cart files, checkouts, email, search). Remaining files are simpler and this work can be done post-MVP or incrementally.

**Details:** [`sessions/session_5b_semantic_grouping.md`](./sessions/session_5b_semantic_grouping.md)
*(Note: This was originally planned as Session 4E)*

---

### 🔮 Session 5C: Code Quality Audit (DEFERRED)
**Status:** Deferred until post-MVP
**Estimated Time:** 5-6 hours
**Focus:** Nice-to-have improvements and polish

**Scope:**
- Scan for unused CSS classes
- Manual line-by-line vanilla CSS audit
- Review remaining !important in search/navigation (Algolia/external overrides)
- Simplify complex selectors (11-chain :not() selector)
- Consolidate button naming (btn-submit vs submit-btn)
- Address non-critical TODOs

**Why deferred:**
These are polish items that don't block development. Can be done during maintenance phase or incrementally as we touch these files.

**Details:** [`sessions/session_5c_code_quality.md`](./sessions/session_5c_code_quality.md)

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
| `cart_dropdown.css` | ✅ Refactored | Split from cart.css in Session 4B |
| `cart_page.css` | ✅ Refactored | Split from cart.css in Session 4B |
| `cart_actions.css` | ✅ Refactored | Split from cart.css in Session 4B |
| `cart_empty.css` | ✅ Refactored | Split from cart.css in Session 4B |
| `checkouts.css` | ✅ Refactored | Completed in Session 4C |
| `email.css` | ✅ Refactored | Completed in Session 4D |
| `search.css` | ✅ Refactored | Completed in Session 4D |
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

## Next Steps

### Immediate (This Week):
- **Session 5A:** Critical foundation cleanup (12-15 hours over 2-3 days)
- Begin styling marketing views with clean CSS foundation

### Post-MVP:
- **Session 5B:** Semantic grouping retroactive pass (4-5 hours)
- **Session 5C:** Code quality audit (5-6 hours)

---

*Last Updated: November 17, 2025*
