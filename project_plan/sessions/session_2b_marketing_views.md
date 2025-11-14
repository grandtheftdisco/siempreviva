# Session 2b: Marketing Views CSS Refactoring

**Status:** ⏳ PENDING (After Session 2a)
**Branch:** `amanda/css-refactor-session-2b` (based on main after Session 2a merge)
**Focus:** Refactor marketing page styling to use new component classes from Session 1

---

## Objectives

1. Replace inline Tailwind utilities with component classes in marketing views
2. Create any needed marketing-specific component classes
3. Ensure consistent styling across all marketing pages
4. Maintain all existing functionality

---

## Prerequisites

✅ Session 1 PR merged to main
✅ Session 2a PR merged to main (product views refactored)
✅ Color system (sv-colors) available
✅ Component classes (.btn-primary, .input-text, etc.) available

---

## Files to Work On

### Primary Focus
- `app/views/marketing/home.html.erb` - Homepage
- `app/views/marketing/contact.html.erb` - Contact page
- `app/views/marketing/gallery.html.erb` - Gallery page
- `app/views/marketing/learn.html.erb` - Learn page
- `app/views/marketing/our_farms.html.erb` - Our farms page

### Don't Touch (Yet)
- `cart.css` - Deferred to Session 4
- `checkouts.css` - Deferred to Session 4
- `layout.css` - Deferred to Session 3

---

## Approach

### Step 1: Audit Current Marketing Views
Review each marketing page for:
- Inline Tailwind utilities
- Custom styling that could be component classes
- Inconsistent patterns across pages

### Step 2: Replace with Component Classes
Use existing classes where possible:
```erb
<!-- Before -->
<a href="/products" class="px-6 py-3 bg-purple-500 rounded-full hover:bg-purple-700">Shop Now</a>

<!-- After -->
<a href="/products" class="btn-primary">Shop Now</a>
```

### Step 3: Create New Component Classes if Needed
For marketing-specific patterns, add to `components.css`:
```css
.hero-section {
  @apply bg-sv-purple-100 py-12 px-4 text-center;
}

.marketing-card {
  @apply bg-white rounded-lg shadow-md p-6 hover:shadow-lg transition-shadow;
}
```

---

## Component Classes Available

### Buttons
- `.btn-primary` - Purple filled button
- `.btn-secondary` - Green outline button
- `.btn-green` - Green filled button
- `.btn-large` - Large size variant

### Forms
- `.form-container` - Form wrapper
- `.input-text` - Text input
- `.input-textarea` - Textarea
- `.label-text` - Form label
- `.btn-submit` - Submit button

### Colors
Use sv-colors with @apply in CSS:
```css
@apply bg-sv-purple-400 text-white border-sv-green-600;
```

---

## Testing Checklist

- [ ] Home page renders correctly (mobile + desktop)
- [ ] Contact page renders correctly (mobile + desktop)
- [ ] Gallery page renders correctly (mobile + desktop)
- [ ] Learn page renders correctly (mobile + desktop)
- [ ] Our Farms page renders correctly (mobile + desktop)
- [ ] All buttons styled consistently
- [ ] Forms styled consistently
- [ ] Hover states work correctly
- [ ] Mobile responsive behavior correct
- [ ] No console errors
- [ ] No visual regressions

---

## Success Criteria

✅ All marketing views styled using component classes
✅ Consistent design system across all marketing pages
✅ No inline Tailwind utilities in marketing views
✅ Mobile responsive
✅ All functionality working
✅ Ready for code review and merge

---

## Next Steps

After Session 2b complete:
- **Session 3:** Layout & navigation refactoring (optional)
- **Session 4:** Cart/checkout refactoring (optional)

---

*Ready to start after Session 2a merged to main*
