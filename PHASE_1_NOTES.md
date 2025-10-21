# Phase 1+2+3 Refactoring Notes
**Date:** 2025-10-21 (Tuesday PM)
**Branch:** refactor/css-to-tailwind
**Status:** Starting Phase 1

---

## Pre-Refactor Documentation

### Screenshots Taken
**Date:** 2025-10-21
**Branch:** amanda/product-views (before refactor)
**Purpose:** Visual reference for how everything currently looks

Screenshots saved in folder for reference to ensure:
- Cart views render identically after refactor
- Checkout views render identically after refactor
- Button styling matches pre-refactor appearance
- Forms maintain current styling
- No visual regressions

**Use these screenshots to:**
- Compare before/after during testing
- Verify backward compatibility works
- Ensure cart/checkout views unchanged
- Catch any unintended style changes

---

## Phase 1: Color Analysis & Tailwind Config

### Tasks
- [ ] Analyze all color shades in components.scss
- [ ] Analyze all CSS custom properties in layout.css
- [ ] Create sv-color numbering system (50-900 scale)
- [ ] Add colors to tailwind.config.js
- [ ] Test color system works

### Notes

**Color System Flexibility:**
- Can request intermediate colors if needed (e.g., sv-purple-300 between 200 and 400)
- Claude can calculate and generate intermediate shades using color interpolation
- Just ask if additional granular shades are needed for hover states, etc.

---

## Phase 2: Components.scss Refactoring

### Tasks
- [x] Add @apply-based button component classes
- [x] Keep existing mixins for backward compatibility
- [ ] Convert components.scss → components.css (STRATEGIC CHANGE)
- [ ] Update to use sv-colors with @apply
- [ ] Test button components render correctly

### Notes

**STRATEGIC DECISION - Course Change #1 (2025-10-21):**

**Problem Encountered:**
- `@apply` with custom Tailwind colors (e.g., `@apply bg-sv-purple-400`) does NOT work in SCSS files
- Got errors: "Cannot apply unknown utility class `bg-sv-purple-400`"
- Could work around with hex values, but that defeats the purpose of Tailwind config

**Decision Made:**
- Convert `components.scss` → `components.css` (remove SCSS entirely)
- Use pure CSS + Tailwind `@apply` directive
- Single source of truth for colors

**STRATEGIC DECISION - Course Change #2 (2025-10-21):**

**Problem Encountered:**
- Still getting "Cannot apply unknown utility class `bg-sv-purple-400`" error
- Discovered project uses **Tailwind CSS v4** (tailwindcss-rails ~> 4.3)
- **Tailwind v4 completely changed custom color configuration!**
- `tailwind.config.js` approach does NOT work in v4

**Decision Made:**
- Use Tailwind v4 `@theme` directive for custom colors
- Define colors in CSS file using `@theme { }` block
- Simpler than v3 - everything in CSS, no separate config file

**Tailwind v4 Approach:**
```css
@theme {
  --color-sv-purple-100: #f0e8f5;
  --color-sv-purple-400: #c5aace;
  /* etc */
}
```

**Why This is Better:**
- ✅ `@apply` with sv-colors works perfectly in .css files
- ✅ No dual system (SCSS variables + Tailwind config)
- ✅ Simpler mental model for future developers
- ✅ Modern Tailwind best practice
- ✅ Easier to maintain and build upon

**What We're Losing from SCSS:**
- `darken()`/`lighten()` functions
- **Solution:** Add more shades to Tailwind config as needed (sv-purple-300, sv-purple-500, etc.)
- **Or:** Use opacity modifiers (`bg-sv-purple-400/90` = slightly darker)

**What We're Gaining:**
- Single source of truth for colors
- Cleaner, more maintainable code
- Better DX for future development
- No more SCSS compilation quirks

**Migration Path:**
1. Rename components.scss → components.css
2. Remove SCSS syntax (@mixin, $variables, &:hover → :hover, etc.)
3. Use @apply with sv-colors (will work!)
4. Add intermediate color shades to Tailwind config if needed

---

## Phase 3: Forms.css Refactoring

### Tasks
- [x] Add component classes (.btn-submit, .form-input, etc.)
- [x] Keep existing element selectors for backward compatibility
- [x] Update to use sv-colors
- [ ] Test forms still work (cart, checkout, product)

### Notes

**Component Classes Added:**
- `.btn-submit` - Submit button using sv-purple-400/700
- `.input-text` - Text input using sv-purple-100 background
- `.input-textarea` - Textarea with sv-purple styling
- `.label-text` - Form labels using sv-purple-700
- `.input-error` - Error state with sv-danger
- `.input-success` - Success state with sv-success
- `.form-container` - Form wrapper class

**Color Annotations:**
- All hex values annotated with sv-color equivalents
- Bootstrap colors (#dc3545, #28a745) noted as candidates for replacement with sv-danger/sv-success
- Tailwind grays (#d1d5db) noted for reference
- All legacy element selectors preserved for backward compatibility

**Status:**
- ✅ forms.css refactoring complete
- ⏳ Testing pending

---

## Testing Log

### Cart Views
- [ ] Cart dropdown renders correctly
- [ ] Cart page renders correctly
- [ ] Add to cart buttons work
- [ ] Update cart button works
- [ ] Remove item buttons work
- [ ] Checkout button works
- [ ] Quantity selectors work

### Checkout Views
- [ ] Checkout form renders correctly
- [ ] Form submission works
- [ ] Button styling correct
- [ ] Payment flow works

### General
- [ ] Header/navigation unchanged
- [ ] Footer unchanged
- [ ] No console errors
- [ ] All existing tests pass

---

## Issues Encountered
(Document any issues and resolutions...)

---

## Decisions Made

**1. Convert components.scss → components.css (2025-10-21)**
- **Reason:** `@apply` with custom Tailwind colors doesn't work in SCSS files
- **Impact:** Removes SCSS dependency, single source of truth for colors
- **Trade-off:** Lose SCSS darken()/lighten(), gain simplicity and maintainability
- **Solution for darkening:** Add more shades to Tailwind config or use opacity modifiers

---

*Last Updated: 2025-10-21*
