# Testing Checklist

Comprehensive testing checklist for CSS refactoring sessions.

---

## Session 1: Foundation Testing ✅

### Cart Views
- [x] Cart dropdown renders correctly
- [x] Cart page renders correctly
- [x] Add to cart buttons work
- [x] Update quantity works
- [x] Remove item works
- [x] Checkout button navigation works
- [x] Quantity selectors work

### Checkout Views
- [x] Checkout page renders correctly
- [x] Stripe embedded form displays
- [x] Payment flow works
- [x] Success page renders

### General
- [x] Header/navigation unchanged
- [x] Footer unchanged
- [x] No console errors
- [x] Test suite run (no new failures)

---

## Session 2: Product/Marketing Testing

### Product Views
- [ ] Product index renders (mobile + desktop)
- [ ] Product show renders (mobile + desktop)
- [ ] Product images display correctly
- [ ] Add to cart functionality works
- [ ] Quantity selector works
- [ ] Cross-sell section renders

### Marketing Pages
- [ ] Home page renders (mobile + desktop)
- [ ] About page renders (mobile + desktop)
- [ ] Contact page renders (mobile + desktop)
- [ ] Gallery page renders (mobile + desktop)
- [ ] Contact form submission works

### Component Consistency
- [ ] All buttons use new component classes
- [ ] All forms use new component classes
- [ ] Colors consistent across pages
- [ ] Hover states work correctly

### Responsive
- [ ] Mobile menu works
- [ ] Desktop navigation works
- [ ] Product grid responsive
- [ ] Forms responsive
- [ ] Images responsive

---

## Session 3: Layout Testing (If Done)

### Header/Navigation
- [ ] Fixed header works (desktop)
- [ ] Mobile menu toggle works
- [ ] Logo displays correctly
- [ ] Navigation links work
- [ ] Cart icon/count displays
- [ ] Search functionality works (if applicable)

### Footer
- [ ] Footer renders correctly
- [ ] Social icons work
- [ ] Footer links work
- [ ] Mobile footer layout correct

### Responsive
- [ ] Header collapses on mobile
- [ ] Mobile menu accessible
- [ ] Footer stacks on mobile
- [ ] Logo sizing correct across breakpoints

---

## Session 4: Legacy Cleanup Testing (If Done)

### Cart Views Migration
- [ ] Cart dropdown uses new classes
- [ ] Cart page uses new classes
- [ ] Add to cart still works
- [ ] Update quantity still works
- [ ] Remove item still works
- [ ] Checkout navigation still works

### Checkout Views Migration
- [ ] Checkout form uses new classes
- [ ] Form submission works
- [ ] Payment processing works
- [ ] Success page renders

### CSS Cleanup Verification
- [ ] No references to removed element selectors
- [ ] All views using component classes
- [ ] cart.css refactored correctly
- [ ] checkouts.css refactored correctly
- [ ] No visual regressions

---

## Cross-Browser Testing

### Desktop
- [ ] Chrome/Edge (latest)
- [ ] Firefox (latest)
- [ ] Safari (latest, if Mac available)

### Mobile
- [ ] iOS Safari (if available)
- [ ] Android Chrome (if available)
- [ ] Mobile responsive view in Chrome DevTools

---

## Performance Checks

- [ ] No CSS compilation errors
- [ ] Page load times reasonable
- [ ] No layout shift on load
- [ ] Hover states smooth
- [ ] Transitions performant

---

## Accessibility

- [ ] Forms keyboard accessible
- [ ] Buttons have proper focus states
- [ ] Color contrast sufficient
- [ ] Labels properly associated with inputs
- [ ] Error messages accessible

---

## Visual Regression

Compare with pre-refactor screenshots:
- [ ] Cart dropdown matches
- [ ] Cart page matches
- [ ] Checkout page matches
- [ ] Button styling matches
- [ ] Form styling matches
- [ ] Colors match design system

---

## Test Suite

### Run Full Suite
```bash
rails test
```

### Expected Results
- Pre-Session 1: 31 runs, 17 assertions, 5 failures, 16 errors
- Post-Session 1: Same failures (none new)
- Post-Session 2: Same or better
- Post-Session 3: Same or better
- Post-Session 4: Same or better

### System Tests (If Available)
```bash
rails test:system
```

---

## Before Merging PR

### Must Pass
- [ ] All manual testing complete
- [ ] No visual regressions
- [ ] All functionality working
- [ ] No console errors
- [ ] Test suite passing (or pre-existing failures only)
- [ ] Code review completed

### Nice to Have
- [ ] Cross-browser tested
- [ ] Mobile devices tested
- [ ] Performance acceptable
- [ ] Accessibility checked

---

## Testing Tips

### Finding Issues
1. **Use browser DevTools** - Check for console errors
2. **Test mobile first** - Mobile often has more layout issues
3. **Test hover states** - Easy to miss
4. **Test form submission** - Don't just render, submit
5. **Test edge cases** - Empty cart, validation errors, etc.

### Documentation
- Take screenshots of any issues
- Note browser/device where issue occurs
- Document steps to reproduce
- Log error messages

### Quick Test Script
```bash
# Start server
bin/dev

# In browser:
# 1. Add product to cart
# 2. Update quantity
# 3. Remove item
# 4. Add product again
# 5. Go to checkout
# 6. Fill out form
# 7. Submit (test mode)
# 8. Verify success page
```

---

*Use this checklist for each session to ensure quality*
