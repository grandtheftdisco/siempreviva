# Session 2a: Product Views CSS Refactoring

**Status:** 🎯 NEXT (Ready to start)
**Branch:** `amanda/css-refactor-session-2a` (based on main after Session 1 merge)
**Focus:** Refactor product view styling to use new component classes from Session 1

---

## Objectives

1. Replace inline Tailwind utilities with component classes in product views
2. Refactor products.css to use @apply with sv-colors
3. Ensure consistent styling with new design system
4. Maintain all existing functionality

---

## Prerequisites

✅ Session 1 PR merged to main
✅ Color system (sv-colors) available
✅ Component classes (.btn-primary, .input-text, etc.) available
✅ Backward compatibility maintained for cart/checkout

---

## Files to Work On

### Primary Focus
- `app/views/products/show.html.erb` - Product detail page
- `app/views/products/index.html.erb` - Product listing page
- `app/views/products/_*.html.erb` - Product partials
- `app/assets/tailwind/products.css` - Refactor to use @apply with sv-colors

### Don't Touch (Yet)
- `cart.css` - Deferred to Session 4
- `checkouts.css` - Deferred to Session 4
- `layout.css` - Deferred to Session 3
- Marketing views - Deferred to Session 2b

---

## Approach

### Step 1: Identify Inline Tailwind in Product Views
Look for patterns like:
```erb
<a href="#" class="px-6 py-3 bg-blue-600 rounded-lg hover:bg-blue-700">Add to Bag</a>
```

### Step 2: Replace with Component Classes
```erb
<a href="#" class="btn-primary">Add to Bag</a>
```

### Step 3: Refactor products.css
Convert vanilla CSS to use @apply with sv-colors:

**Before:**
```css
.product-card {
  background-color: #f0e8f5;
  border: 1px solid #c5aace;
  padding: 1rem;
}
```

**After:**
```css
.product-card {
  @apply bg-sv-purple-100 border border-sv-purple-400 rounded-lg p-4;
}
```

---

## Component Classes Available

### Buttons
- `.btn-primary` - Purple filled button
- `.btn-secondary` - Green outline button
- `.btn-green` - Green filled button
- `.btn-danger` - Red filled button
- `.btn-small` - Small size variant
- `.btn-large` - Large size variant

### Forms
- `.btn-submit` - Submit button
- `.input-text` - Text input
- `.input-textarea` - Textarea
- `.label-text` - Form label
- `.input-error` - Error state
- `.input-success` - Success state
- `.form-container` - Form wrapper

### Colors
Use sv-colors with @apply in CSS:
```css
@apply bg-sv-purple-400 text-white border-sv-green-600;
```

---

## Testing Checklist

- [ ] Product index page renders correctly (mobile + desktop)
- [ ] Product show page renders correctly (mobile + desktop)
- [ ] All buttons styled consistently
- [ ] Forms styled consistently
- [ ] Hover states work correctly
- [ ] Mobile responsive behavior correct
- [ ] No console errors
- [ ] No visual regressions

---

## Success Criteria

✅ All product views styled using new component classes
✅ products.css refactored to use @apply with sv-colors
✅ No inline Tailwind utilities in product views
✅ Consistent with design system
✅ Mobile responsive
✅ All functionality working
✅ Ready for code review and merge

---

## Next Steps

After Session 2a complete:
- **Session 2b:** Marketing views CSS refactoring
- Then optionally: Session 3 (layout) or Session 4 (cart/checkout)

---

*Ready to start after Session 1 merged to main*
