# Session 4E: Apply Semantic Grouping Pattern Across All CSS Files

**⚠️ THIS FILE HAS BEEN ARCHIVED**

**This session is now Session 5B** due to project priority changes. Specificity cleanup must happen before semantic grouping to avoid reorganizing code twice.

**📁 See the updated plan:** [`session_5b_semantic_grouping.md`](../sessions/session_5b_semantic_grouping.md)

---

## Original Plan (Preserved for Reference)

**Status:** ⏸️ Deferred - Now Session 5B
**Branch:** TBD (was `css-refactor/session-4e-semantic-grouping`)
**Base:** `main` (after Sessions 3, 4A-4D, and 5A complete)

---

## Overview

Apply the semantic grouping pattern for `@apply` directives consistently across all CSS files in the codebase. This pattern was established in Session 4A (forms.css) and Session 3 (components.css) and improves code readability and maintainability.

---

## Background

### What is Semantic Grouping?

**Pattern established in Sessions 3 & 4A:**
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

### Why This Matters

**Benefits:**
- **Readability:** Clear visual separation of concerns
- **Maintainability:** Easier to locate and modify specific properties
- **Consistency:** Follows established Tailwind best practices
- **Onboarding:** New developers can understand component structure faster
- **Debugging:** Easier to identify which group needs changes

---

## Scope

### Files to Update

Apply semantic grouping to all CSS files using `@apply` directives:

1. **cart.css** - After Session 4B refactoring
2. **checkouts.css** - After Session 4C refactoring
3. **email.css** - After Session 4D refactoring
4. **search.css** - After Session 4D refactoring
5. **layout.css** - Already refactored, add grouping
6. **Any other CSS files** discovered during audit

### Files Already Complete

- ✅ **forms.css** - Completed in Session 4A
- ✅ **components.css** - Completed in Session 3

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
- [ ] Identify all CSS files using `@apply` directives
- [ ] Document which files need grouping added
- [ ] Note any files with mixed vanilla/@apply that need refactoring first

### 2. Apply Semantic Grouping
- [ ] Update layout.css with semantic grouping
- [ ] Update cart.css with semantic grouping (after 4B)
- [ ] Update checkouts.css with semantic grouping (after 4C)
- [ ] Update email.css with semantic grouping (after 4D)
- [ ] Update search.css with semantic grouping (after 4D)
- [ ] Update any other discovered files

### 3. Review & Consistency Check
- [ ] Verify all files use consistent category names
- [ ] Verify all files use consistent category ordering
- [ ] Check for any missed `@apply` blocks
- [ ] Ensure comments are clear and helpful

### 4. Documentation
- [ ] Update project documentation with semantic grouping standards
- [ ] Add examples to coding standards
- [ ] Update Session 4 completion notes

### 5. Testing
- [ ] Visual regression testing - ensure no styling changes
- [ ] Review all pages in browser
- [ ] Verify CSS builds correctly

---

## Dependencies

**Depends on:**
- Session 3 merged (components.css pattern established)
- Session 4A merged (forms.css pattern established)
- Session 4B merged (cart.css refactored to @apply)
- Session 4C merged (checkouts.css refactored to @apply)
- Session 4D merged (email.css & search.css refactored to @apply)

**Note:** This session MUST come after all other Session 4 work is complete.

---

## Success Criteria

✅ All CSS files using `@apply` have semantic grouping applied
✅ Category names are consistent across all files
✅ Category ordering is logical and consistent
✅ All classes have explanatory comments
✅ No visual changes to the application
✅ CSS builds without errors
✅ Documentation updated with standards

---

## Non-Goals

This session does NOT include:
- Converting vanilla CSS to `@apply` (that's Sessions 4B/4C/4D)
- Removing `!important` declarations (that's Session 5)
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
- After all Session 4 (A-D) work is complete and merged
- Before Session 5 (!important cleanup)
- When you want to improve code maintainability
- During a low-priority period

**Or skip if:**
- Sessions 4B/4C/4D not yet complete
- Other priorities are more urgent
- Current organization is sufficient

---

## Notes

- This is a **code organization enhancement**, not a functional change
- No changes to actual styling or behavior
- Purely for developer experience and maintainability
- Can be done incrementally (file by file) or all at once
- Recommend doing all at once for consistency

---

*This session is optional but highly recommended for long-term maintainability*
