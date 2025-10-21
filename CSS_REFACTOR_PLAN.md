# CSS to Tailwind Refactoring Plan
**Project:** Siempreviva
**Date Created:** 2025-10-21
**Status:** Planning Phase

---

## Executive Summary

Refactor existing vanilla CSS and SCSS to use Tailwind's `@apply` directive with component classes. This will establish a clean, maintainable design system while preserving all existing functionality and aesthetics.

**Key Goals:**
- Single source of truth for colors (Tailwind config)
- Component classes using `@apply` instead of vanilla CSS selectors
- No inline Tailwind unless absolutely necessary
- Preserve all interactive components (Flowbite, JS)
- Write test suite for visual regression protection

---

## Current State Analysis

### Git Branch Status
**Current State:**
- **main branch:** Has cart and checkout views merged (PRs passed code review)
- **amanda/marketing-views branch:** In progress, working on product and marketing views
- **Plan:** Create separate `refactor/css-to-tailwind` branch for CSS refactoring work

**Files Already Used in Merged Views (Handle with Care):**
- `cart.css` - Used by merged cart views
- `checkouts.css` - Used by merged checkout views
- `forms.css` - GLOBAL file used in cart, checkout, contact, and product views (quantity selector, Add to Bag button)
- `components.scss` - GLOBAL file with button mixins used across views including product show view
- `layout.css` - GLOBAL file for header/footer/nav used everywhere

**Files to Refactor Just-in-Time:**
- `products.css` - Refactor as we style product views
- `search.css` - Refactor when we work on search

### File Structure
```
app/assets/tailwind/
├── application.css       # Main import file
├── components.scss       # SCSS variables, mixins, some @apply classes ⚠️ GLOBAL
├── layout.css           # CSS custom properties + vanilla selectors (639 lines) ⚠️ GLOBAL
├── forms.css            # Vanilla CSS with element selectors (352 lines) ⚠️ GLOBAL
├── cart.css             # Cart-specific styles ✓ MERGED (test after refactor)
├── checkouts.css        # Checkout page styles ✓ MERGED (test after refactor)
├── products.css         # Product page styles → Refactor just-in-time
└── search.css           # Search/Algolia styles → Refactor just-in-time
```

### Key Issues Identified
1. **Color duplication** - Colors defined in both SCSS variables AND CSS custom properties
2. **Mixed methodologies** - Mixins, vanilla CSS, and some `@apply` used inconsistently
3. **Specificity conflicts** - Heavy `!important` usage suggesting style conflicts
4. **No single source of truth** - Hard to maintain consistent styling
5. **Global selectors causing issues** - e.g., `form` selector applies to ALL forms (width: 75%, centering, etc.)
6. **Global files affect merged views** - forms.css, components.scss, layout.css used by cart/checkout views already in production

---

## Design Decisions

### 1. Color Naming Convention
**Decision:** Use `sv-[color]-[shade]` format with Tailwind-style numbering

**Examples:**
- `sv-purple-300` (lighter purple)
- `sv-purple-500` (medium purple)
- `sv-purple-700` (darker purple)
- `sv-green-400`
- `sv-pink-200`

**Numbering System:**
- 50 = lightest shade
- 900 = darkest shade
- Use x50 variants (150, 250, etc.) for in-between shades if needed
- Follows Tailwind's convention for consistency

### 2. Component Class Naming
**Decision:** Continue with current simple naming style

**Format:** `.component-variant` (e.g., `.btn-primary`, `.form-input-error`)

**NOT using:**
- ~~BEM-style~~ (`.btn--primary`, `.form__input--error`)
- ~~Inline Tailwind~~ (utility classes directly in views)

### 3. Timeline & Approach
**Decision:** Hybrid approach - Foundation now, incremental refactoring as we style

**Refactoring Strategy:** Conservative with backward compatibility (Option A)
- Add new component classes using `@apply`
- Keep existing element selectors as fallbacks for merged views
- Prevents breaking cart/checkout views
- Allows gradual migration to new classes
- Clean up legacy selectors in Phase 6

**Reasoning:**
- Prevents touching components twice
- Avoids accumulated technical debt
- Establishes clean foundation immediately
- Refactor just-in-time as we work on each feature
- Zero risk of breaking existing merged views

### 4. Risk Management
**Decision:** Conservative but multi-phase implementation

**Strategy:**
- Complete one phase at a time
- Test thoroughly between phases
- Commit after each phase
- File-by-file approach within phases

### 5. Testing Strategy
**Decision:** Write view/system tests during refactoring

**Test Coverage:**
- Visual components render correctly
- Responsive behavior (mobile/desktop)
- Interactive elements (dropdowns, forms, buttons)
- Flowbite components still work
- Regression protection for future changes

---

## Refactoring Phases

### Phase 1: Color Centralization 🎯 **DOING NEXT**
**Goal:** Single source of truth for colors

**Tasks:**
1. Analyze all color shades currently in use
2. Create Tailwind-style numbering system (sv-purple-300, sv-purple-500, etc.)
3. Add colors to `tailwind.config.js` theme extension
4. Remove CSS custom properties from `layout.css` (:root block)
5. Update `components.scss` to reference Tailwind colors
6. Search codebase for `var(--` usage and update references

**Output:**
- `sv-purple-300`, `sv-green-500`, etc. available everywhere
- No more color duplication

**Risks:** Breaking references to CSS custom properties
**Mitigation:** Systematic search and replace for `var(--` usage

---

### Phase 2: Components CSS Refactoring (UPDATED STRATEGY)
**Goal:** Convert components.scss to components.css with `@apply`-based component classes

**STRATEGIC CHANGE (2025-10-21):**
- **Original plan:** Keep SCSS, add @apply classes alongside mixins
- **Problem:** `@apply` with custom Tailwind colors doesn't work in SCSS files
- **New approach:** Convert components.scss → components.css entirely
- **Why:** Single source of truth, cleaner code, better DX, modern best practice

**Strategy (Revised):**
- Convert SCSS file to regular CSS
- Remove all SCSS syntax (mixins, variables, &:hover, etc.)
- Use `@apply` with sv-colors (works perfectly in .css files)
- Keep backward-compatible classes (cart/checkout continue working)
- Add new component classes for future use

**What's in components.scss → components.css:**
- Button classes using @apply (btn-primary, btn-green, btn-danger, etc.)
- Form classes (form-input, form-label, form-input-error, etc.)
- Card classes (card, card-bordered)
- Utility classes (flex-center, text-truncate, etc.)
- Flash notification styles

**Example Transformation (Pure CSS with Backward Compatibility):**
```css
/* KEEP existing classes that cart/checkout use */
.checkout-btn {
  padding: 0.75rem 1.5rem;
  border-radius: 9999px;
  background: #698b3f; /* sv-green-600 */
  color: #ffffff;
  border: 2px solid #698b3f;
  /* ... existing styles */
}

.checkout-btn:hover {
  background: #4f5e3c; /* sv-green-700 */
  border-color: #4f5e3c;
}

/* ADD new component class using @apply with sv-colors */
.btn-primary {
  @apply px-6 py-3 rounded-full bg-sv-purple-400 text-white
         border-2 border-sv-purple-400 hover:bg-sv-purple-700 hover:border-sv-purple-700
         transition-all duration-200 font-medium cursor-pointer inline-block;
  font-family: 'Raleway', sans-serif;
}

/* New usage (product/marketing views) - USE CLASS */
/* <%= link_to "Shop Now", products_path, class: "btn-primary" %> */
```

**Key Differences from SCSS:**
- No `@mixin` or `@include`
- No SCSS variables (`$primary-purple` → use sv-colors directly)
- No `&:hover` (use regular `:hover`)
- No `darken()/lighten()` (add shades to Tailwind config or use opacity)
- `@apply` with sv-colors WORKS in .css files!

**Preserve:**
- All existing classes cart/checkout use (backward compatible)
- Flash notification styles
- Flowbite-integrated components (quantity selector)

**Output:**
- Clean component classes using @apply (`.btn-primary`, `.btn-green`, etc.)
- Existing classes still work (`.checkout-btn`, `.continue-shopping-btn`, etc.)
- No SCSS dependency

**Cleanup in Phase 6:** Can migrate old views to use new component classes

---

### Phase 3: Forms.css Refactoring 🎯 **DOING NEXT**
**Goal:** Convert element selectors to component classes

**Current Problem:**
Global `form` selector applies to ALL forms:
- `width: 75%`
- `max-width: 600px`
- `padding: 1rem 0rem`
- Causes centering and margin issues

**Strategy (Option A - Conservative):**
1. **KEEP existing element selectors** for backward compatibility (cart/checkout forms)
2. **ADD new component classes** using `@apply` for new forms
3. New product/marketing views use component classes
4. Old cart/checkout views continue working with element selectors

**Component classes to create:**
- `.form-standard` - Default form styling
- `.form-inline` - Already exists, keep it
- `.form-compact` - For tight spaces (like floating cart button)
- `.btn-submit` - Submit button styling
- `.form-input` - Text input styling

**Example Transformation (Backward Compatible):**
```css
/* KEEP existing element selector for backward compatibility */
form input[type="submit"],
form button[type="submit"] {
  background-color: #c5aace;
  padding: 16px 32px;
  margin-bottom: 10px;
  border-radius: 9999px;
  /* ... existing styles ... */
}

/* ADD new component class using @apply */
.btn-submit {
  @apply bg-sv-purple-300 text-white px-8 py-4
         rounded-full font-bold hover:bg-sv-purple-500
         transition-colors duration-300;
  font-family: 'Raleway', sans-serif;
}

/* Cart/checkout forms continue using element selectors - NO CHANGES NEEDED */
/* New product/marketing forms use .btn-submit class */
```

**Output:**
- Explicit form component classes for new views
- Existing forms continue working (cart, checkout)
- No risk of breaking merged views

**Risks:** Temporary duplication of styles
**Mitigation:** Clean up in Phase 6 when migrating cart/checkout views

**Cleanup in Phase 6:** Remove element selectors and migrate old views to use component classes

---

### Phase 4: Layout.css Refactoring
**Goal:** Convert vanilla selectors to component classes

**What's in layout.css:**
- Header & navigation (fixed header, mobile/desktop variants)
- Logo section
- Footer
- Body/main layout and spacing
- Remove button component (`.remove-button-small`)
- Link hover styles
- Social icons

**Component classes to create:**
- `.header-fixed` - Fixed header styles
- `.nav-desktop` / `.nav-mobile` - Navigation variants
- `.footer-standard` - Footer styling
- `.logo-standard` - Logo styling
- `.remove-btn-small` - Small remove button (keep as-is, already well-defined)

**Media queries:** Keep responsive patterns but use Tailwind breakpoint classes where possible

**When to do:** After core marketing pages are styled

---

### Phase 5: Feature-Specific CSS Files
**Goal:** File-by-file conversion to `@apply` component classes

**Files:**
- `cart.css` - Cart dropdown, cart page, cart items
- `products.css` - Product grid, product cards
- `search.css` - Search functionality, Algolia components
- `checkouts.css` - Checkout success page

**Approach:** Just-in-time refactoring
- When working on cart views → refactor cart.css
- When working on product pages → refactor products.css
- Etc.

**When to do:** As we work on each feature area

---

## Implementation Plan

### Git Workflow Strategy

**Separate Refactor Branch Approach (CHOSEN)**

```
main (has cart & checkout merged)
  ↓
refactor/css-to-tailwind ← Do Phase 1+2+3 here
  ↓ (merge after testing)
main (updated with refactored CSS)
  ↓
amanda/marketing-views (rebase on updated main)
  ↓ (continue styling with clean system)
```

**Why Separate Branch:**
- Clean separation of infrastructure changes from feature work
- Can review refactor independently
- Test impact on existing cart/checkout views in isolation
- Marketing-views builds on stable, refactored foundation
- Don't touch product/marketing styling twice

---

### Immediate Next Steps (This Session 10/21/25 Tuesday PM)

**Phase 1 + Phase 2 + Phase 3** (Full Foundation)

**Estimated Time:** 3-4 hours

**Why All Three Phases:**
- **Phase 1 (Colors):** Foundation for everything
- **Phase 2 (Components.scss):** Button mixins used in product show view
- **Phase 3 (Forms.css):** Global file affecting product forms, cart forms, checkout forms

**Workflow:**
1. ✅ Create refactor branch from main
2. ✅ Phase 1: Analyze colors, create Tailwind config
3. ✅ Phase 2: Refactor components.scss
4. ✅ Phase 3: Refactor forms.css
5. ✅ Test cart & checkout views thoroughly (they use these global files!)
6. ✅ Write test suite for components
7. ✅ Create PR for refactor branch

**Deliverables:**
1. Tailwind config with sv-color system
2. Refactored components.scss with @apply classes
3. Refactored forms.css with component classes
4. Test suite for components and forms
5. Documentation of new patterns

**Don't Touch (Yet):**
- cart.css - Leave as-is, already working in merged views
- checkouts.css - Leave as-is, already working in merged views
- products.css - Refactor just-in-time as we style product views
- search.css - Refactor when we work on search

---

### Next Session Steps (after Tuesday 10/21 changes)

**After Refactor PR Merged:**
1. ✅ Review/merge refactor PR to main
2. ✅ Rebase amanda/marketing-views on updated main
3. ✅ Continue styling product/marketing views with clean system
4. ✅ Refactor products.css just-in-time as needed

---

### Phase 6: Legacy Views Cleanup & CSS Finalization (Future Branch)

**When:** After amanda/marketing-views is complete and merged

**Scope:** Migrate cart/checkout views to new component classes and clean up legacy CSS

**Why Separate:**
- Cart and checkout views currently working with backward-compatible global files
- Prevents scope creep on current refactor
- Can be done when/if we need to make changes to those features
- Allows thorough testing in isolation

**Branch Strategy:**
```
main (has refactored global CSS + marketing views)
  ↓
refactor/legacy-views-cleanup ← Migrate cart/checkout views, remove legacy CSS
  ↓ (merge after testing)
main (fully refactored CSS system)
```

---

**Phase 6 Detailed Tasks:**

**6.1: Migrate Cart Views to Component Classes**
- [ ] Update cart dropdown form to use `.btn-submit` instead of element selector
- [ ] Update cart page forms to use component classes
- [ ] Update quantity selectors to use component classes (if not already)
- [ ] Test cart dropdown functionality
- [ ] Test cart page functionality
- [ ] Test "Update Cart" and "Checkout" buttons

**6.2: Migrate Checkout Views to Component Classes**
- [ ] Update checkout forms to use `.btn-submit` class
- [ ] Update any custom form styling to use component classes
- [ ] Test checkout flow end-to-end
- [ ] Test form submissions
- [ ] Test payment processing UI

**6.3: Remove Backward-Compatibility Code from forms.css**
- [ ] Remove `form input[type="submit"]` element selector
- [ ] Remove `form input[type="text"]` element selector
- [ ] Remove global `form` width/padding rules
- [ ] Keep only component classes (`.btn-submit`, `.form-input`, etc.)
- [ ] Verify no views are using removed selectors

**6.4: Remove Backward-Compatibility Code from components.scss**
- [ ] Remove SCSS mixins: `@mixin btn-primary`, `@mixin btn-green`, etc.
- [ ] Remove classes that use mixins: `.checkout-btn`, `.continue-shopping-btn`, etc.
- [ ] Keep only `@apply`-based component classes
- [ ] Update any remaining views using mixin-based classes

**6.5: Refactor Feature-Specific CSS Files**
- [ ] Refactor cart.css to use `@apply` with component classes
- [ ] Refactor checkouts.css to use `@apply` with component classes
- [ ] Remove any hardcoded colors (use sv-color variables)
- [ ] Remove duplicated styles (rely on global component classes)

**6.6: Final Testing & Documentation**
- [ ] Test all cart functionality (add to cart, update, remove, checkout)
- [ ] Test all checkout functionality (form submission, payment, success page)
- [ ] Run full test suite
- [ ] Visual regression testing (cart dropdown, cart page, checkout pages)
- [ ] Update documentation with finalized component class list
- [ ] Create PR with thorough description of changes

---

**Decision Point:** Will likely do this just-in-time when we need to modify cart/checkout features, rather than as a standalone refactor. For now, leaving these files as-is since they work fine with the refactored global styles.

**Estimated Time:** 2-3 hours

**Risk:** Medium (touching working features)

**Mitigation:** Thorough testing, separate branch, code review before merge

---

## Color Inventory (To Be Completed in Phase 1)

### Purple Shades Currently in Use
- `#674174` - Primary purple (SCSS: $button-hover-purple, CSS: --primary-purple)
- `#c5aace` - Light purple (SCSS: $primary-purple, CSS: --light-purple)
- `#e6d3ec` - Button purple (SCSS: $button-purple, CSS: --button-purple)
- `#f0e8f5` - Background purple (SCSS: $background-purple)
- Additional shades to be identified and numbered

### Green Shades Currently in Use
- `#8ba170` - Primary green (SCSS: $primary-green)
- `#bdcea9` - Light green (SCSS: $light-green)
- `#698b3f` - Button green (SCSS: $button-green)
- `#4f5e3c` - Button hover green (SCSS: $button-hover-green)
- `#5a8664` - Success green (SCSS: $success-green)

### Pink Shades Currently in Use
- `#f7c8d8` - Light pink (SCSS: $light-pink, CSS: --light-pink)
- `#f4a5c2` - Medium pink (SCSS: $medium-pink, CSS: --medium-pink)

### Neutral Shades Currently in Use
- `#f8f9fa` - Light background (SCSS: $light-bg, CSS: --light-bg)
- `#ffffff` - White background (SCSS: $white-bg, CSS: --white-bg)
- `#2c3e50` - Dark text (SCSS: $dark-text, CSS: --dark-text)
- `#6c757d` - Medium text (SCSS: $medium-text, CSS: --medium-text)
- `#adb5bd` - Light text (SCSS: $light-text, CSS: --light-text)

### Action Colors Currently in Use
- `#c19550` - Warning orange (SCSS: $warning-orange)
- `#b9626b` - Danger red (SCSS: $danger-red)
- `#6b9fa8` - Info blue (SCSS: $info-blue)

**TODO in Phase 1:** Analyze these colors and assign Tailwind-style shade numbers

---

## Testing Checklist (Per Phase)

### Visual Regression
- [ ] Home page (mobile + desktop)
- [ ] Products index (mobile + desktop)
- [ ] Product show page (mobile + desktop)
- [ ] Cart dropdown (mobile + desktop)
- [ ] Cart page (mobile + desktop)
- [ ] Checkout flow (mobile + desktop)
- [ ] Contact page (mobile + desktop)

### Interactive Components
- [ ] Navigation dropdown (mobile)
- [ ] Cart dropdown
- [ ] Search functionality
- [ ] Form submissions
- [ ] Quantity selectors (Flowbite)
- [ ] Remove buttons
- [ ] Flash messages

### Responsive Behavior
- [ ] Header navigation (mobile collapse)
- [ ] Logo sizing
- [ ] Form layouts
- [ ] Footer layout
- [ ] Product grid
- [ ] Cart layout

### Hover States
- [ ] Links
- [ ] Buttons
- [ ] Navigation items
- [ ] Product cards
- [ ] Cart items

---

## Branch Strategy

**Refactor Branch:** `refactor/css-to-tailwind` (created from `main`)

**Commit Pattern:**
- After each phase with descriptive messages
- Include test results in commit messages
- Example: "Phase 1: Add sv-color system to Tailwind config"
- Example: "Phase 2: Refactor components.scss to use @apply"
- Example: "Phase 3: Refactor forms.css with component classes"
- Tag major milestones

**Testing Requirements Before Merge:**

**Critical (Must Pass):**
- ✅ All cart views render correctly (cart dropdown, cart page)
- ✅ All checkout views render correctly
- ✅ Cart forms submit correctly (Update Cart, Checkout buttons)
- ✅ Checkout forms submit correctly
- ✅ Quantity selectors work (increment/decrement)
- ✅ Button styling matches pre-refactor appearance
- ✅ Header/footer/navigation unchanged
- ✅ No console errors

**Expected (Backward Compatibility):**
- Cart/checkout views should use OLD element selectors (expected during Phase 1-5)
- Cart/checkout views will be migrated to component classes in Phase 6
- New product/marketing views will use NEW component classes

**Test Suite:**
- ✅ All existing tests pass
- ✅ New component class tests pass

**Merge Strategy:**
1. Create PR: `refactor/css-to-tailwind` → `main`
2. Thorough code review
3. Test in local environment
4. Consider staging environment deployment if available
5. Merge to main after all tests pass

**Post-Merge Workflow:**
1. Checkout `amanda/marketing-views` branch
2. Rebase on updated `main`: `git rebase main`
3. Resolve any conflicts (likely minimal since we're not touching view files yet)
4. Continue styling product/marketing views with clean CSS system

---

## Notes & Context

### From CLAUDE.md
- Frontend development AI-assisted with supervised oversight
- Human developer leverages frontend expertise to guide and review
- Maintains quality control while accelerating development

### Current Issue Fixed
- Floating "Add to Bag" button margin issue (manually fixed)
- Root cause: Global `form` selector applying unwanted styles
- Phase 3 will prevent similar issues in future

### Flowbite Components to Preserve
- Quantity selector (decrement/increment buttons)
- Any other Flowbite interactive components
- Test these carefully during refactoring

---

## Questions & Decisions Log

**Q1: Color naming convention?**
A: Use `sv-[color]-[shade]` with Tailwind-style numbering (50-900, with x50 variants if needed)

**Q2: Component class naming?**
A: Continue with current simple style (`.btn-primary`, not BEM)

**Q3: Timeline?**
A: Hybrid - Foundation now (Phase 1 + 3), then incremental as we style features

**Q4: Risk tolerance?**
A: Conservative file-by-file, but implement multiple phases

**Q5: Fix floating button first?**
A: Fixed manually, proceeding with refactor

**Q6: Test suite?**
A: Yes! Write tests during refactoring for regression protection

---

## Session Checklist

### Starting Refactor (This Session - Tuesday 10/21/25 PM):
- [x] Review this document
- [x] Confirm Phase 1 + 2 + 3 approach ✅
- [ ] Create refactor branch from main: `git checkout main && git checkout -b refactor/css-to-tailwind`
- [ ] Begin Phase 1: Color analysis and Tailwind config
- [ ] Complete Phase 2: Components.scss refactor
- [ ] Complete Phase 3: Forms.css refactor
- [ ] Write test suite
- [ ] Test cart & checkout views thoroughly
- [ ] Create PR

### After Refactor Merged (Next Session):
- [ ] Merge refactor PR to main
- [ ] Checkout amanda/marketing-views
- [ ] Rebase on main
- [ ] Continue styling with clean system
- [ ] Refactor products.css just-in-time

### After Marketing Views Complete (Future - Phase 6):
- [ ] Create refactor/legacy-views-cleanup branch
- [ ] Migrate cart views to use new component classes
- [ ] Migrate checkout views to use new component classes
- [ ] Remove backward-compatibility code from forms.css
- [ ] Remove backward-compatibility code from components.scss
- [ ] Refactor cart.css and checkouts.css
- [ ] Test thoroughly
- [ ] Create PR for final cleanup

---

*Last Updated: 2025-10-21 (Tuesday PM)*
*Current Status: Ready to begin Phase 1+2+3 on refactor/css-to-tailwind branch*
