# Session 5C: Code Quality Audit & Polish

**Status:** 🔮 Deferred until post-MVP
**Branch:** TBD (when ready to begin)
**Base:** `main` (after Session 5A, optionally 5B)
**Estimated Time:** 5-6 hours

---

## Overview

Nice-to-have improvements and polish work that doesn't block development. This session addresses remaining technical debt, unused code, and edge cases that survived earlier refactoring sessions.

---

## Why Deferred to Post-MVP

**These are polish items, not blockers:**
- Don't affect functionality
- Don't prevent styling new views
- Don't cause bugs or conflicts
- Can be done anytime

**Timeline priority:**
- MVP is 2 weeks behind schedule
- Must prioritize shipping over perfection
- This work can happen during maintenance phase
- Or incrementally as we touch these files

**Risk is low:**
- Unused classes don't break anything
- External library !important may be necessary
- Complex selectors work, just not ideal
- These are improvements, not fixes

---

## Scope

### 1. Unused Class Scan (1 hour)

**Goal:** Identify CSS classes not referenced in views

**Actions:**
- Scan all CSS files for class definitions
- Search views/partials for usage of each class
- Flag classes with no references
- **Do not auto-remove** - determine case-by-case:
  - Might be useful for marketing views (not yet styled)
  - Might be useful for admin dashboard (not yet styled)
  - Might be legitimate unused technical debt

**Deliverable:** List of potentially unused classes with usage analysis

---

### 2. Manual Vanilla CSS Audit (2-3 hours)

**Goal:** Catch vanilla CSS → Tailwind conversions that automated tools missed

**Actions:**
- Line-by-line review of remaining vanilla CSS
- Look for patterns Claude/tools might have missed:
  - Properties that could be @apply
  - Hardcoded values with Tailwind equivalents
  - Repeated patterns that could be utilities
- Convert where beneficial (don't force conversions)

**Focus files:**
- layout.css (post-5A cleanup)
- header.css
- footer.css
- navigation.css
- Any vanilla CSS that survived Session 5A

---

### 3. Advanced !important Review (1-2 hours)

**Goal:** Determine if external library overrides are truly necessary

**search.css (54 !important):**
- Algolia InstantSearch overrides
- Review which are necessary vs. can be removed
- Test search functionality if changes made
- Document which must stay and why

**navigation.css (31 !important):**
- Some are desktop nav transparency
- Review if these can be solved with better specificity
- Test mobile menu and desktop nav

**components.css (28 !important):**
- Flash messages and form inputs
- Review if specificity can be improved
- Test all component usage

**Outcome:** Reduce !important count further OR document justification for keeping

---

### 4. TODO Cleanup (30 mins)

**Current TODOs:**
- components.css line 10: Reorganization note
- footer.css line 4: Contact form branch note

**Actions:**
- Address or update each TODO
- Remove completed TODOs
- Update notes with current context

---

### 5. Selector Simplification (1 hour)

**layout.css: 11-chain :not() selector**

**Current:**
```css
a:not(.logo-link):not(.breadcrumb-link):not(.ais-Hits-item a):not(.remove-button-small):not(.social-icon):not(.shop-products-btn):not(.btn-primary):not(.btn-secondary):not(.btn-green):not(.btn-green-light):not(.btn-danger):not(.cart-view-button)
```

**Options:**
- Add utility class for styled links
- Use positive selector instead of negative
- Document why complex selector is necessary
- Or simplify specificity cascade

**Goal:** More maintainable selector OR clear documentation

---

### 6. Button Naming Consolidation (30 mins)

**Current situation:**
- `btn-submit` (forms.css line 8): Main submit button component class
- `submit-btn` (forms.css line 120): Utility class for margin only

**Actions:**
- Document difference clearly in comments
- Consider consolidating if `.submit-btn` isn't widely used
- OR keep both with clear purpose explanation

---

### 7. Minor Modernizations (30 mins - 1 hour)

**checkouts.css improvements:**
- Line 54: `min-height: fit-content` → `@apply min-h-fit` (Tailwind 3.3+)
- Lines 74-78: Height-based media query - document or simplify

**Other opportunities:**
- Look for CSS features with modern Tailwind equivalents
- Convert if beneficial and well-supported

---

## Success Criteria

✅ Unused classes identified and documented
✅ Manual audit catches any missed conversions
✅ !important usage further reduced OR justified
✅ All TODOs addressed or updated
✅ Complex selectors simplified OR documented
✅ Button naming clarified
✅ No regressions in functionality
✅ CSS builds without errors

---

## Deliverables

1. **Unused Classes Report**
   - List of potentially unused classes
   - Usage analysis
   - Recommendations for each

2. **!important Justification Document**
   - Which !important declarations must stay
   - Why they're necessary
   - What they're overriding

3. **Updated CSS Files**
   - Additional conversions from manual audit
   - Simplified selectors
   - Updated comments/documentation

4. **Clean TODO List**
   - All TODOs addressed
   - Current context documented

---

## Non-Goals

This session does NOT include:
- Major refactoring (keep changes small)
- Changing functionality or appearance
- Converting working code just for purity
- Breaking external library integrations

---

## Testing Requirements

**After each change:**
- Visual regression check
- Affected functionality testing
- Build verification

**Specific areas to test:**
- Search functionality (if changing Algolia overrides)
- Mobile navigation (if changing nav !important)
- Flash messages and forms (if changing components.css)
- All link hover states (if changing complex selector)

---

## When to Do This

**Good times:**
- After MVP launch
- During maintenance phase
- When adding new features to affected areas
- When you have extra time between sprints

**Skip if:**
- Time is constrained
- Other priorities are urgent
- Current code is working well enough
- Risk outweighs benefit

---

## Priority Within 5C

If doing this work incrementally, prioritize:

**High value, low risk:**
1. TODO cleanup (quick wins)
2. Button naming documentation (clarity)
3. Unused class identification (awareness)

**Medium value, medium risk:**
4. Manual vanilla CSS audit (thoroughness)
5. Selector simplification (maintainability)

**Lower value, higher risk:**
6. Advanced !important review (could break things)
7. Minor modernizations (nice-to-have)

---

## Related Documentation

- **[Session 5A](./session_5a_specificity_cleanup.md)** - Critical foundation work
- **[Session 5B](./session_5b_semantic_grouping.md)** - Code organization polish
- **[Comprehensive Plan](../../x_notes_x/SESSION_5_COMPREHENSIVE_PLAN.md)** - Full Session 5 overview
- **[Audit Report](../../x_notes_x/SESSION_5_COMPREHENSIVE_PLAN.md#audit-summary)** - Original findings

---

## Notes

**Philosophy for this session:**
- Don't break working code
- Document rather than force changes
- Small, safe improvements
- Testing is critical
- When in doubt, defer

**Remember:**
- Perfect is the enemy of shipped
- This is maintenance work, not critical path
- Can be done incrementally
- Focus on value, not purity

---

*This session is optional polish work - deferred to prioritize MVP timeline and reduce risk.*
