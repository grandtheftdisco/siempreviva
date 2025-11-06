# Session 4: Legacy Views Migration & CSS Cleanup

**⚠️ This file has been split into focused session documents**

---

## New Session Files

Session 4 has been divided into 4 independent sessions for better focus and manageable PRs:

1. **[Session 4A: View Migrations & Legacy Code Removal](./session_4a_view_migrations.md)** - Audit views, migrate cart/checkout, remove backward compatibility
2. **[Session 4B: cart.css Refactoring](./session_4b_cart_css.md)** - Convert cart.css to @apply with sv-colors
3. **[Session 4C: checkouts.css Refactoring](./session_4c_checkouts_css.md)** - Convert checkouts.css to @apply with sv-colors
4. **[Session 4D: email.css + search.css Refactoring](./session_4d_email_search_css.md)** - Convert email.css and search.css to @apply with sv-colors

---

## Original Overview (Preserved for Context)

**Status:** 🧹 OPTIONAL - Future
**When:** If/when we modify cart or checkout features
**Estimated Time:** 8.5-11 hours total (split across 4 sessions)
**Branch:** Split into 4 branches (see individual sessions)

---

## Overview

Migrate cart and checkout views to use new component classes, remove backward-compatibility code from CSS files, and **eliminate inline CSS/Tailwind utilities** by extracting them into reusable component classes. This completes the CSS refactoring project with a focus on maximizing maintainability through component-based styling.

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

### Views to Migrate & Audit
- `app/views/carts/` - Cart page, cart dropdown
- `app/views/checkouts/` - Checkout form, success page
- `app/views/layouts/application.html.erb` - Cart dropdown in header
- **All views with inline CSS or extensive inline Tailwind** - Extract to component classes

### CSS to Clean Up
- `app/assets/tailwind/forms.css` - Remove element selectors
- `app/assets/tailwind/components.css` - Remove legacy classes
- `app/assets/tailwind/cart.css` - Refactor to @apply
- `app/assets/tailwind/checkouts.css` - Refactor to @apply
- `app/assets/tailwind/email.css` - Refactor to @apply with sv-colors
- `app/assets/tailwind/search.css` - Refactor to @apply with sv-colors

---

## Tasks Breakdown

### 1. Audit All Views for Inline Styles (PRIORITY)
- [ ] Grep codebase for `style=` attributes (inline CSS)
- [ ] Identify views with excessive inline Tailwind utilities (3+ utilities)
- [ ] Create component classes for repeated patterns
- [ ] Extract inline styles to appropriate CSS files
- [ ] Document any inline utilities that must remain (responsive utilities, etc.)

### 2. Migrate Cart Views
- [ ] Update cart dropdown form to use `.btn-submit` class
- [ ] Update cart page forms to use component classes
- [ ] Update quantity controls to use component classes
- [ ] **Remove inline styles and extract to cart.css**
- [ ] Test cart dropdown functionality
- [ ] Test cart page (add, update, remove items)

### 3. Migrate Checkout Views
- [ ] Update checkout forms to use `.btn-submit` class
- [ ] Update any custom styling to use component classes
- [ ] **Remove inline styles and extract to checkouts.css**
- [ ] Test checkout flow end-to-end
- [ ] Test payment processing

### 4. Remove Backward-Compatibility Code

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

### 5. Refactor Feature CSS Files

**cart.css:**
- Convert to @apply with sv-colors
- Remove hardcoded colors
- Use component classes where possible

**checkouts.css:**
- Convert to @apply with sv-colors
- Remove hardcoded colors
- Use component classes where possible

**email.css:**
- Convert to @apply with sv-colors
- Remove hardcoded hex values
- Maintain email client compatibility

**search.css:**
- Convert to @apply with sv-colors
- Remove hardcoded hex values
- Ensure Algolia components styled correctly

### 6. Testing
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

✅ **No inline CSS (scan for both `style=` and `class=` attributes) in views unless there is a valid reason**
✅ **Inline Tailwind reduced to minimum** (only layout/responsive utilities)
✅ Cart views use new component classes
✅ Checkout views use new component classes
✅ All backward-compatibility code removed
✅ cart.css, checkouts.css, email.css, and search.css refactored to @apply
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
