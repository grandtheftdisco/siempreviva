# Session 4C: checkouts.css Refactoring

**Status:** ⏳ UPCOMING
**When:** After Session 4A submitted for review
**Estimated Time:** 1.5-2 hours
**Branch:** `css-refactor/session-4c-checkouts-css` (will branch from `main`, NOT 4A)

---

## Overview

Refactor checkouts.css to use Tailwind's `@apply` directive with sv-colors. This is an independent session that can be worked on while 4A is in review.

**Why it's separate:**
- Checkout is critical payment flow that deserves focused attention
- Can be reviewed independently
- Can be done in parallel with 4B and 4D
- Doesn't depend on 4A's view changes

---

## Scope

### File to Refactor
- `app/assets/tailwind/checkouts.css` - Complete refactor to @apply with sv-colors

### What Stays the Same
- Checkout form layout and functionality
- Success page appearance
- Stripe integration (no JS changes)
- All visual appearance

### What Changes
- Replace all hex color values with sv-color variables
- Convert vanilla CSS to @apply where appropriate
- Organize with clear section headers and adjacent media queries
- Preserve !important declarations for Session 5

---

## Tasks Breakdown

### Task 1: Analyze Current checkouts.css Structure

**Steps:**
- [ ] Read through checkouts.css to understand current structure
- [ ] Identify all sections (checkout form, success page, payment elements, etc.)
- [ ] Catalog all hardcoded hex values
- [ ] Note Stripe-specific styling that must be preserved

**Expected sections:**
- Checkout form layout
- Form field styling
- Payment element containers
- Submit buttons
- Success page layout
- Error states
- Loading states

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
- [ ] Test payment flow after each section

---

### Task 3: Convert Utilities and Patterns to @apply

**Target conversions:**
- Form layout (flex, grid, spacing)
- Typography
- Borders and border-radius
- Button styling
- Success page layout
- Transitions

**Keep as vanilla CSS:**
- Properties Tailwind doesn't support
- Anything with !important (Session 5)
- Stripe-specific overrides
- Custom box-shadows

**Steps:**
- [ ] Convert form layout patterns
- [ ] Convert typography
- [ ] Convert button styles
- [ ] Convert success page layout
- [ ] Test payment flow after each change

---

### Task 4: Organize and Structure

**Apply Session 3 organizational pattern:**
- Clear `/* ===== ALL CAPS SECTION ===== */` headers
- Group related components together
- Place media queries adjacent to base classes
- Logical top-to-bottom flow

**Suggested structure:**
```css
/* ===== CHECKOUT FORM LAYOUT ===== */
/* ===== FORM FIELDS ===== */
/* ===== PAYMENT ELEMENTS ===== */
/* ===== SUBMIT BUTTON ===== */
/* ===== SUCCESS PAGE ===== */
/* ===== ERROR STATES ===== */
/* ===== LOADING STATES ===== */
```

**Steps:**
- [ ] Add section headers
- [ ] Group related styles
- [ ] Move media queries adjacent to base classes
- [ ] Ensure logical flow

---

## Success Criteria

✅ All hex colors replaced with sv-color variables
✅ Vanilla CSS converted to @apply where appropriate
✅ Clear section organization with headers
✅ Media queries adjacent to base classes
✅ !important declarations preserved for Session 5
✅ **Checkout form works perfectly**
✅ **Payment processing works (test mode)**
✅ **Success page displays correctly**
✅ No visual regressions
✅ Mobile responsive (375px, 768px, 1280px+)

---

## Testing Checklist (CRITICAL - Payment Flow)

### Checkout Form
- [ ] Form displays correctly
- [ ] All fields render properly
- [ ] Field validation works
- [ ] Error messages display correctly
- [ ] Stripe payment element loads
- [ ] Card input styling correct

### Payment Processing
- [ ] Can enter test card (4242 4242 4242 4242)
- [ ] Can submit payment
- [ ] Loading state displays during processing
- [ ] No JavaScript errors in console
- [ ] Stripe integration working

### Success Page
- [ ] Success page displays after payment
- [ ] Order details show correctly
- [ ] Return button works
- [ ] Styling matches design

### Responsive
- [ ] Mobile (375px - iPhone SE)
- [ ] Tablet (768px)
- [ ] Desktop (1280px+)
- [ ] Form layout on mobile
- [ ] Payment element on mobile

---

## Risk Management

**Risk Level:** HIGH (payment flow is critical)

**Mitigation:**
- Test payment flow extensively
- Use Stripe test mode
- Test multiple test cards
- Verify Stripe integration unchanged
- Check browser console for errors
- Test on multiple browsers (Chrome, Firefox, Safari)
- Have rollback plan ready

**Rollback Plan:**
- Can revert PR immediately if payment issues
- Independent of 4A/4B/4D
- Original checkouts.css in git history
- Payment flow can't be broken in production

---

## Stripe Integration Notes

**Important:** Do not change any Stripe-specific selectors or styling that affects Stripe Elements.

**Stripe Elements to preserve:**
- `.StripeElement` containers
- Payment element styling overrides
- Card input styling
- Error message containers

**Test cards:**
```
Success: 4242 4242 4242 4242
Decline: 4000 0000 0000 0002
Auth required: 4000 0025 0000 3155
```

---

## Dependencies

**Branches from:** `main` (NOT from 4A)

**Why not 4A?**
- checkouts.css refactoring is independent of view changes
- Can be reviewed/merged in any order after 4A
- Avoids complex rebasing if 4A needs changes

**After 4A merges:**
```bash
git checkout session-4c-checkouts-css
git merge main  # Pull in 4A's changes
# Test payment flow, then merge this PR
```

---

## Files Modified in This Session

**CSS:**
- `app/assets/tailwind/checkouts.css` - Complete refactor

**No view changes** (views handled in 4A)
**No JS changes** (Stripe integration stays the same)

---

*Session 4C can be done in parallel with 4B and 4D - but test payment flow THOROUGHLY*