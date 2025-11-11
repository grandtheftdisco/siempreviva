# Session 4B: cart.css Refactoring

**Status:** ⏳ UPCOMING
**When:** After Session 4A submitted for review
**Estimated Time:** 2-3 hours
**Branch:** `css-refactor/session-4b-cart-css` (will branch from `main`, NOT 4A)

---

## Overview

Refactor cart.css (~1000+ lines) to use Tailwind's `@apply` directive with sv-colors. This is an independent session that can be worked on while 4A is in review.

**Why it's separate from 4A:**
- cart.css is massive (>1000 lines) and deserves focused attention
- Can be reviewed independently
- Can be done in parallel with 4C and 4D
- Doesn't depend on 4A's view changes

---

## Scope

### File to Refactor
- `app/assets/tailwind/cart.css` - Complete refactor to @apply with sv-colors

### What Stays the Same
- Cart dropdown functionality
- Cart page layout
- Item display and interactions
- All visual appearance

### What Changes
- Replace all hex color values with sv-color variables
- Convert vanilla CSS to @apply where appropriate
- Organize with clear section headers and adjacent media queries
- Preserve !important declarations for Session 5

---

## Tasks Breakdown

### Task 1: Analyze Current cart.css Structure

**Steps:**
- [ ] Read through cart.css to understand current structure
- [ ] Identify all sections (dropdown, cart page, item cards, buttons, etc.)
- [ ] Catalog all hardcoded hex values
- [ ] Note any repeated patterns that could be extracted

**Expected sections:**
- Cart-specific button styles
- Cart dropdown positioning and layout
- Cart page layout
- Cart item cards
- Quantity controls
- Remove item buttons
- Empty cart state
- Cart totals

---

### Task 2: Replace Hex Colors with sv-colors

**Common replacements:**
```css
/* BEFORE */
background: #c5aace;  /* sv-purple-400 */
color: #674174;       /* sv-purple-700 */
background: #4f5e3c;  /* sv-green-700 */
border-color: #698b3f; /* sv-green-600 */
```

**AFTER:**
```css
@apply bg-sv-purple-400;
@apply text-sv-purple-700;
@apply bg-sv-green-700;
@apply border-sv-green-600;
```

**Steps:**
- [ ] Replace all purple hex values with sv-purple-*
- [ ] Replace all green hex values with sv-green-*
- [ ] Replace all gray hex values with sv-gray-*
- [ ] Test after each major color replacement

---

### Task 3: Convert Utilities and Patterns to @apply

**Target conversions:**
- Spacing (padding, margin, gap)
- Flexbox/grid patterns
- Typography (font-family, font-size, font-weight)
- Borders and border-radius
- Transitions and animations
- Positioning (where it makes sense)

**Keep as vanilla CSS:**
- Properties Tailwind doesn't support well (filter, custom box-shadows)
- Anything with !important (Session 5 will address)
- Complex calc() expressions
- Custom rgba values

**Steps:**
- [ ] Convert spacing utilities
- [ ] Convert layout patterns (flex, grid)
- [ ] Convert typography
- [ ] Convert borders and radius
- [ ] Convert transitions
- [ ] Test thoroughly after each section

---

### Task 4: Organize and Structure with Semantic Grouping

**Apply Session 3 organizational pattern:**
- Clear `/* ===== ALL CAPS SECTION ===== */` headers
- Group related components together
- Place media queries adjacent to base classes
- Logical top-to-bottom flow

**Apply semantic grouping pattern (established in Sessions 3 & 4A):**
- Group `@apply` directives by semantic category with explanatory comments
- Standard categories: Sizing & spacing, Colors, Layout & positioning, Interactive & animation, Typography, Visual effects
- **IMPORTANT:** Apply semantic grouping AS YOU REFACTOR, not later in Session 4E
- Session 4E is only for applying grouping to files already refactored in 4B/4C/4D that might need retroactive grouping

**Example pattern:**
```css
.cart-item-card {
  /* Sizing & spacing */
  @apply p-4 rounded-lg;

  /* Colors */
  @apply bg-white border border-sv-gray-300;

  /* Layout */
  @apply flex items-center gap-4;
}
```

**Suggested structure:**
```css
/* ===== CART-SPECIFIC REMOVE BUTTONS ===== */
/* ===== CART DROPDOWN ===== */
/* ===== CART PAGE LAYOUT ===== */
/* ===== CART ITEM CARDS ===== */
/* ===== QUANTITY CONTROLS ===== */
/* ===== CART TOTALS ===== */
/* ===== EMPTY CART STATE ===== */
```

**Steps:**
- [ ] Add section headers
- [ ] Group related styles
- [ ] Apply semantic grouping to each component class
- [ ] Move media queries adjacent to base classes
- [ ] Ensure logical flow

---

### Task 5: Consider Modularization

**Question:** Should cart.css be split into smaller files?

**Current size:** >1000 lines

**Potential split:**
- `cart_dropdown.css` - Cart dropdown styles
- `cart_page.css` - Main cart page layout
- `cart_items.css` - Cart item card styles
- `cart_controls.css` - Quantity controls, buttons

**Decision criteria:**
- If each section is >200 lines, consider splitting
- If sections are independent, splitting makes sense
- If tightly coupled, keep together

**Steps:**
- [ ] Assess section sizes after refactoring
- [ ] Decide if modularization adds value
- [ ] Split if beneficial (separate commit)

---

## Success Criteria

✅ All hex colors replaced with sv-color variables
✅ Vanilla CSS converted to @apply where appropriate
✅ Clear section organization with headers
✅ Media queries adjacent to base classes
✅ !important declarations preserved for Session 5
✅ All cart functionality working
✅ Cart dropdown displays correctly
✅ Cart page renders properly
✅ No visual regressions
✅ Mobile responsive (375px, 768px, 1280px+)

---

## Testing Checklist

### Cart Dropdown
- [ ] Dropdown opens/closes correctly
- [ ] Items display properly
- [ ] Quantities show correctly
- [ ] Prices calculated correctly
- [ ] Remove buttons work
- [ ] Checkout button styled correctly

### Cart Page
- [ ] Page layout correct
- [ ] Item cards display properly
- [ ] Quantity controls work
- [ ] Update quantity buttons function
- [ ] Remove item buttons work
- [ ] Cart totals accurate
- [ ] Continue shopping button works
- [ ] Checkout button works

### Responsive
- [ ] Mobile (375px - iPhone SE)
- [ ] Tablet (768px)
- [ ] Desktop (1280px+)
- [ ] Cart dropdown position on mobile (fixed at 7rem from Session 3)

---

## Risk Management

**Risk Level:** Medium (large file, critical functionality)

**Mitigation:**
- Test cart dropdown thoroughly (fixed positioning from Session 3)
- Test all cart operations (add, update, remove)
- Commit frequently with clear sections
- Test at each breakpoint
- Keep !important for Session 5

**Rollback Plan:**
- Can revert PR if issues arise
- Independent of 4A/4C/4D
- Original cart.css in git history

---

## Dependencies

**Branches from:** `main` (NOT from 4A)

**Why not 4A?**
- cart.css refactoring is independent of view changes
- Can be reviewed/merged in any order after 4A
- Avoids complex rebasing if 4A needs changes

**After 4A merges:**
```bash
git checkout session-4b-cart-css
git merge main  # Pull in 4A's changes
# Test, then merge this PR
```

---

## Files Modified in This Session

**CSS:**
- `app/assets/tailwind/cart.css` - Complete refactor
- `app/assets/tailwind/application.css` - Update imports if splitting into modules

**Possibly created (if modularizing):**
- `app/assets/tailwind/cart_dropdown.css`
- `app/assets/tailwind/cart_page.css`
- `app/assets/tailwind/cart_items.css`
- `app/assets/tailwind/cart_controls.css`

---

*Session 4B can be done in parallel with 4C and 4D*