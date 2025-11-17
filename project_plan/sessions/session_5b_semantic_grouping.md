# Session 5B: Semantic Grouping Retroactive Pass

**Status:** ⏸️ Deferred until post-MVP
**Branch:** TBD (when ready to begin)
**Base:** `main` (after Session 5A complete)
**Estimated Time:** 4-5 hours
**Originally Planned As:** Session 4E

---

## Overview

Apply the semantic grouping pattern for `@apply` directives consistently across remaining CSS files. This pattern was established in Session 3 (components.css) and Session 4A (forms.css) and improves code readability and maintainability.

**Note:** This session was moved from Session 4E to 5B because specificity cleanup (Session 5A) must happen first to avoid reorganizing code twice.

---

## Why Deferred to Post-MVP

**Semantic grouping is code organization, not functionality:**
- Doesn't affect visual appearance
- Doesn't fix bugs
- Doesn't unblock development

**Most files already have semantic grouping:**
- ✅ components.css (Session 3)
- ✅ forms.css (Session 4A)
- ✅ cart_dropdown.css, cart_page.css, cart_actions.css, cart_empty.css (Session 4B)
- ✅ checkouts.css (Session 4C)
- ✅ email.css, search.css (Session 4D)

**Remaining files are simpler:**
- layout.css, header.css, footer.css, navigation.css, products.css
- These files have less complex @apply blocks
- Can be done incrementally as we touch these files

**Timeline priority:**
- MVP is 2 weeks behind schedule
- Must prioritize functionality over polish
- This work can happen during maintenance phase

---

## Background

### What is Semantic Grouping?

**Pattern established in Sessions 3 & 4:**
- Group related `@apply` utilities together by semantic category
- Add explanatory comments for each group
- Follow Tailwind 2024 best practices for component class organization

**Example:**
```css
.input-text {
  /* Sizing & spacing */
  @apply w-full px-3 py-2 rounded border;

  /* Colors */
  @apply bg-sv-purple-100 border-sv-purple-200 text-sv-gray-800;

  /* Focus states */
  @apply focus:outline-none focus:border-sv-purple-400 focus:ring-2 focus:ring-sv-purple-400/20;

  /* Animation & typography */
  @apply transition-all duration-150 font-sans;
}
```

### Benefits

- **Readability:** Clear visual separation of concerns
- **Maintainability:** Easier to locate and modify specific properties
- **Consistency:** Follows established Tailwind best practices
- **Onboarding:** New developers understand component structure faster
- **Debugging:** Easier to identify which group needs changes

---

## Scope

### Files to Update

Apply semantic grouping to remaining CSS files using `@apply` directives:

1. **layout.css** - After Session 5A cleanup
2. **header.css** - Simple file, optional enhancement
3. **footer.css** - Simple file, optional enhancement
4. **navigation.css** - Simple file, optional enhancement
5. **products.css** - Simple file, optional enhancement

### Files Already Complete (No Work Needed)

- ✅ **components.css** - Completed in Session 3
- ✅ **forms.css** - Completed in Session 4A
- ✅ **cart_dropdown.css** - Completed in Session 4B
- ✅ **cart_page.css** - Completed in Session 4B
- ✅ **cart_actions.css** - Completed in Session 4B
- ✅ **cart_empty.css** - Completed in Session 4B
- ✅ **checkouts.css** - Completed in Session 4C
- ✅ **email.css** - Completed in Session 4D
- ✅ **search.css** - Completed in Session 4D

---

## Standard Semantic Categories

Use these categories consistently across all files:

**Common categories (in order):**
1. **Sizing & spacing** - width, height, padding, margin
2. **Layout & positioning** - display, position, flex, grid properties
3. **Border & shape** - border properties, border-radius
4. **Colors** - background, text, border colors
5. **Interactive & animation** - hover, focus, active states, transitions
6. **Typography** - font properties, text alignment, letter-spacing
7. **Visual effects** - shadows, filters, opacity
8. **Behavior** - cursor, overflow, resize

**Notes:**
- Not every class uses every category
- Group order should be logical for the specific component
- Categories can be combined if small (e.g., "Shape & spacing", "Colors & states")
- Add custom categories when needed (e.g., "Custom dropdown arrow" for select inputs)

---

## Tasks

### 1. Audit Current State
- [ ] Review remaining files (layout, header, footer, navigation, products)
- [ ] Identify which @apply blocks would benefit from grouping
- [ ] Note any files with mixed vanilla/@apply that need more work

### 2. Apply Semantic Grouping
- [ ] Update layout.css with semantic grouping (after 5A cleanup)
- [ ] Update header.css with semantic grouping (if beneficial)
- [ ] Update footer.css with semantic grouping (if beneficial)
- [ ] Update navigation.css with semantic grouping (if beneficial)
- [ ] Update products.css with semantic grouping (if beneficial)

### 3. Review & Consistency Check
- [ ] Verify all files use consistent category names
- [ ] Verify all files use consistent category ordering
- [ ] Check for any missed `@apply` blocks
- [ ] Ensure comments are clear and helpful

### 4. Testing
- [ ] Visual regression testing - ensure no styling changes
- [ ] Review all pages in browser
- [ ] Verify CSS builds correctly

---

## Dependencies

**Depends on:**
- Session 5A complete (specificity & foundation cleanup)
- All Session 4 work merged (4A-4D)

**Blocks:**
- Nothing - this is polish work

---

## Success Criteria

✅ All CSS files using `@apply` have semantic grouping applied (where beneficial)
✅ Category names are consistent across all files
✅ Category ordering is logical and consistent
✅ All classes have explanatory comments
✅ No visual changes to the application
✅ CSS builds without errors

---

## Non-Goals

This session does NOT include:
- Converting vanilla CSS to `@apply` (that's Session 5A)
- Removing `!important` declarations (that's Session 5A)
- Changing any actual styling or behavior
- Refactoring component structure

---

## Example Before/After

### Before (no semantic grouping)
```css
.btn-primary {
  @apply px-6 py-3 rounded-full no-underline text-center font-medium cursor-pointer inline-block transition-all duration-200 border-2 text-white;
  @apply bg-sv-purple-400 border-sv-purple-400 hover:bg-sv-purple-700 hover:border-sv-purple-700;
  @apply font-sans;
}
```

### After (with semantic grouping)
```css
.btn-primary {
  /* Spacing & shape */
  @apply px-6 py-3 rounded-full;

  /* Border & layout */
  @apply border-2 inline-block;

  /* Interactive & animation */
  @apply cursor-pointer transition-all duration-200;

  /* Link styling */
  @apply no-underline text-center;

  /* Colors */
  @apply bg-sv-purple-400 border-sv-purple-400 text-white;
  @apply hover:bg-sv-purple-700 hover:border-sv-purple-700;

  /* Typography */
  @apply font-medium font-sans;
}
```

---

## When to Do This

**Ideal timing:**
- After MVP launch
- During maintenance phase
- When you have downtime between features
- Or incrementally as you touch these files

**Or skip if:**
- Time is constrained
- Other priorities are more urgent
- Current organization is sufficient
- Files are simple enough without grouping

---

## Notes

- This is a **code organization enhancement**, not a functional change
- No changes to actual styling or behavior
- Purely for developer experience and maintainability
- Can be done incrementally (file by file) or all at once
- Remaining files are simpler than those already done
- Some files may be too simple to benefit from grouping

---

## Related Documentation

- **[Session 4E](./session_4e_semantic_grouping.md)** - Original plan (preserved for reference)
- **[Session 5A](./session_5a_specificity_cleanup.md)** - Must complete first
- **[Session 5C](./session_5c_code_quality.md)** - Other deferred polish work
- **[Comprehensive Plan](../../x_notes_x/SESSION_5_COMPREHENSIVE_PLAN.md)** - Full Session 5 overview

---

*This session is optional polish work - deferred to prioritize MVP timeline.*
