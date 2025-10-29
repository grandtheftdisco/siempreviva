# Session 4: Legacy Views Migration & CSS Cleanup

**Status:** 🧹 OPTIONAL - Future
**When:** If/when we modify cart or checkout features
**Estimated Time:** 2-3 hours
**Branch:** `refactor/legacy-views-cleanup` (if done)

---

## Overview

Migrate cart and checkout views to use new component classes, then remove backward-compatibility code from CSS files. This completes the CSS refactoring project.

---

## Why We Waited

**Current State:**
- Cart and checkout views work perfectly using legacy element selectors
- Backward compatibility maintained in forms.css and components.css
- No urgent need to change working code

**Benefits of Waiting:**
- Avoided scope creep during initial refactor
- Allowed confident testing of foundation (Session 1)
- Can be done strategically when modifying these features anyway

---

## Scope

### Views to Migrate
- `app/views/carts/` - Cart page, cart dropdown
- `app/views/checkouts/` - Checkout form, success page
- `app/views/layouts/application.html.erb` - Cart dropdown in header

### CSS to Clean Up
- `app/assets/tailwind/forms.css` - Remove element selectors
- `app/assets/tailwind/components.css` - Remove legacy classes
- `app/assets/tailwind/cart.css` - Refactor to @apply
- `app/assets/tailwind/checkouts.css` - Refactor to @apply

---

## Tasks Breakdown

### 1. Migrate Cart Views
- [ ] Update cart dropdown form to use `.btn-submit` class
- [ ] Update cart page forms to use component classes
- [ ] Update quantity controls to use component classes
- [ ] Test cart dropdown functionality
- [ ] Test cart page (add, update, remove items)

### 2. Migrate Checkout Views
- [ ] Update checkout forms to use `.btn-submit` class
- [ ] Update any custom styling to use component classes
- [ ] Test checkout flow end-to-end
- [ ] Test payment processing

### 3. Remove Backward-Compatibility Code

**forms.css cleanup:**
```css
/* REMOVE these element selectors */
form input[type="submit"],
form button[type="submit"] { ... }

form input[type="text"],
form input[type="email"] { ... }

form {
  max-width: 600px;
  width: 75%;
  /* ... */
}
```

**components.css cleanup:**
```css
/* REMOVE legacy classes that cart/checkout were using */
.checkout-btn { ... }
.continue-shopping-btn { ... }
.cart-checkout-btn { ... }
/* etc. */

/* KEEP new component classes */
.btn-primary { ... }
.btn-green { ... }
/* etc. */
```

### 4. Refactor Feature CSS Files

**cart.css:**
- Convert to @apply with sv-colors
- Remove hardcoded colors
- Use component classes where possible

**checkouts.css:**
- Convert to @apply with sv-colors
- Remove hardcoded colors
- Use component classes where possible

### 5. Testing
- [ ] Test all cart functionality (add, update, remove, checkout)
- [ ] Test all checkout functionality (form, payment, success)
- [ ] Run full test suite
- [ ] Visual regression testing
- [ ] Mobile responsive testing

---

## Migration Example

**Before (using element selectors):**
```erb
<%= form_for :cart_item do |f| %>
  <%= f.submit "Add to Cart" %>
<% end %>
```
Uses global `form input[type="submit"]` selector from forms.css.

**After (using component classes):**
```erb
<%= form_for :cart_item, html: { class: "form-container" } do |f| %>
  <%= f.submit "Add to Cart", class: "btn-submit" %>
<% end %>
```
Uses explicit `.form-container` and `.btn-submit` classes.

---

## Success Criteria

✅ Cart views use new component classes
✅ Checkout views use new component classes
✅ All backward-compatibility code removed
✅ cart.css and checkouts.css refactored to @apply
✅ All functionality working
✅ No visual regressions
✅ Test suite passing

---

## Risk Management

**Risk Level:** Medium (touching working features)

**Mitigation:**
- Separate branch for this work
- Thorough testing before merge
- Code review required
- Consider staging deployment first

**Rollback Plan:**
- If issues arise, can revert PR
- Backward-compatible code still in git history

---

## Decision Point

**Do this when:**
- We need to modify cart functionality
- We need to modify checkout functionality
- We want to clean up technical debt
- We have time and it's a low-priority period

**Or skip if:**
- Cart/checkout working fine and no changes needed
- Other priorities are more urgent
- Technical debt is acceptable

---

*This session is entirely optional and can be done anytime or never*
