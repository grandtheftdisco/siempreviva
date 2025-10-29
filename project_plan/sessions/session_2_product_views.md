# Session 2: Product & Marketing Views

**Status:** 🎯 NEXT (Ready to start)
**Branch:** `amanda/marketing-views` (rebase on main after Session 1 merge)
**Focus:** Complete product and marketing page styling using new component classes

---

## Objectives

1. Rebase marketing-views branch on updated main (with Session 1 foundation)
2. Style product and marketing pages using new component classes
3. Just-in-time refactor products.css as needed
4. Complete marketing views implementation

---

## Prerequisites

✅ Session 1 PR merged to main
✅ Color system (sv-colors) available
✅ Component classes (.btn-primary, .input-text, etc.) available
✅ Backward compatibility maintained for cart/checkout

---

## Workflow

### Step 1: Rebase Marketing Views Branch
```bash
git checkout amanda/marketing-views
git rebase main
# Resolve any conflicts (should be minimal)
```

**Expected conflicts:** Minimal, since Session 1 didn't touch view files

### Step 2: Use New Component Classes

**Instead of:**
```erb
<!-- Old inline Tailwind or custom classes -->
<%= link_to "Shop Now", products_path, class: "px-6 py-3 bg-purple-500..." %>
```

**Do this:**
```erb
<!-- Use new component classes -->
<%= link_to "Shop Now", products_path, class: "btn-primary" %>
<%= link_to "Learn More", about_path, class: "btn-secondary" %>
```

### Step 3: Refactor products.css (Just-in-Time)

**Approach:** Only touch what you're actively working on
- Convert vanilla selectors to component classes as needed
- Use @apply with sv-colors
- Document any new patterns

**Example:**
```css
/* Old */
.product-card {
  background-color: #f0e8f5;
  border: 1px solid #c5aace;
}

/* New */
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

## Files to Work On

### Primary Focus
- `app/views/products/` - Product show, index views
- `app/views/marketing/` - Home, about, contact, gallery
- `app/assets/tailwind/products.css` - Refactor as needed

### Don't Touch (Yet)
- `cart.css` - Working fine, leave for Session 4
- `checkouts.css` - Working fine, leave for Session 4
- `layout.css` - Working fine, leave for Session 3

---

## Best Practices

### 1. Use Component Classes, Not Inline Tailwind
❌ **Avoid:**
```erb
<a href="#" class="px-6 py-3 bg-purple-400 rounded-full hover:bg-purple-700">Button</a>
```

✅ **Do:**
```erb
<a href="#" class="btn-primary">Button</a>
```

### 2. Create New Component Classes as Needed
If you need a style repeatedly, add it to components.css:
```css
.product-card {
  @apply bg-white rounded-lg shadow-md p-6;
  @apply border border-gray-200 hover:shadow-lg transition-shadow;
}
```

### 3. Use sv-Colors Consistently
```css
/* Good */
.my-component {
  @apply bg-sv-purple-100 border-sv-purple-400;
}

/* Avoid */
.my-component {
  background: #f0e8f5; /* Use sv-purple-100 instead */
}
```

### 4. Document New Patterns
If you create new component classes, add inline comments explaining their use.

---

## Testing Checklist

As you build:
- [ ] Product index page renders correctly (mobile + desktop)
- [ ] Product show page renders correctly (mobile + desktop)
- [ ] Marketing pages render correctly (home, about, contact, gallery)
- [ ] All buttons styled consistently
- [ ] Forms styled consistently
- [ ] Hover states work correctly
- [ ] Mobile responsive behavior correct
- [ ] No console errors

---

## Estimated Timeline

**Duration:** 1-2 weeks (depending on scope)

**Breakdown:**
- Product views: 2-3 days
- Marketing pages: 2-3 days
- products.css refactoring: 1 day
- Testing & polish: 1-2 days

---

## Success Criteria

✅ All product/marketing views styled using new component classes
✅ Consistent design system across all pages
✅ products.css refactored to use @apply with sv-colors
✅ No inline Tailwind utilities
✅ Mobile responsive
✅ All functionality working
✅ Ready for code review and merge

---

## Next Session

After Session 2 complete:
- **Option A:** Session 3 - Refactor layout.css (header/nav/footer)
- **Option B:** Session 4 - Migrate cart/checkout to new classes
- **Option C:** Leave as-is and move on to other features

---

*Ready to start after Session 1 PR merged*
