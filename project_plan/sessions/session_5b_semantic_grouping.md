# Session 5B: Specificity Cleanup & Semantic Grouping

**Status:** ⏸️ Deferred until post-MVP
**Branch:** TBD (when ready to begin)
**Base:** `main` (after Session 5A complete)
**Estimated Time:** 10-13 hours
**Originally Planned As:** Session 4E (semantic grouping) + Session 5A Phase 3 (!important cleanup)

---

## Overview

This session combines two types of CSS polish work deferred from earlier sessions:

1. **!important Reduction (6-8 hours)** - Originally planned for Session 5A Phase 3, deferred to prioritize foundation fixes
2. **Semantic Grouping (4-5 hours)** - Originally Session 4E, apply consistent @apply grouping pattern to remaining files

Both are code quality improvements that don't block feature development but significantly improve maintainability.

---

## Why Deferred to Post-MVP

**Both tasks are code quality, not functionality:**
- Don't affect visual appearance or user-facing features
- Don't fix blocking bugs
- Don't unblock development of new features
- Primarily improve developer experience and maintainability

**!important reduction is complex and risky:**
- 317 declarations across 9 files
- Requires careful specificity analysis
- Risk of breaking layouts if not done carefully
- Better tackled when not under MVP timeline pressure

**Most files already have semantic grouping:**
- ✅ components.css, forms.css, all cart files, checkouts.css, email.css, search.css
- Remaining files (layout, header, footer, navigation, products) are simpler

**Timeline priority:**
- MVP was 2 weeks behind when Session 5A began
- Must prioritize functionality and foundation fixes over polish
- This work can happen during maintenance phase or incrementally

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

## Part 1: !important Reduction & Specificity Cleanup (6-8 hours)

### Current State
**317 !important declarations across 9 files** (as of Session 5A completion)

**Distribution:**
- cart_page.css: 68 !important
- cart_dropdown.css: 58 !important
- search.css: 54 !important (mostly Algolia overrides - review carefully)
- layout.css: 39 !important
- cart_actions.css: 30 !important
- navigation.css: 31 !important (some justified for desktop transparency)
- Other files: Various smaller counts

### Tasks

#### Task 1.1: Audit Inline `!` Prefix Usage in Views (1 hour)
**New task - not in original plan**

Search all view files for inline Tailwind utilities using the `!` prefix (e.g., `!important` modifiers).

**Actions:**
- Grep all `.html.erb` files for `class=".*!` and `class='.*!` patterns
- Document all findings with file location and context
- Categorize by necessity:
  - **Justified:** Overriding external libraries (Stripe, Algolia, etc.)
  - **Specificity hack:** Should be refactored
  - **Unclear:** Needs investigation
- Create plan for refactoring unjustified uses

**Success Criteria:**
- Complete inventory of inline `!` prefix usage
- Clear categorization of justified vs. hack usage
- Refactoring plan for unjustified uses

---

#### Task 1.2: layout.css - .remove-button-small Cleanup (1.5 hours)
**Current:** 23 !important declarations (lines ~50-84)

**Actions:**
1. Review each !important declaration and determine necessity
2. Options for removal:
   - Increase selector specificity naturally
   - Refactor component structure
   - Use more specific class names
3. Test remove button functionality:
   - Cart dropdown remove buttons
   - Cart page remove buttons
   - Mobile and desktop views

**Success Criteria:**
- Reduced !important usage by 50%+ (target: down to ~10)
- Remove buttons work correctly in all contexts
- No visual regressions

---

#### Task 1.3: cart_dropdown.css - Remove Button Overrides (2 hours)
**Current:** 26 !important in remove button section (lines ~294-419)

**Issues:**
- Heavy !important usage for positioning, sizing, colors
- Likely due to specificity conflicts with base styles

**Actions:**
1. Identify which !important declarations are truly needed
2. Refactor specificity cascade:
   - Use more specific selectors
   - Reorganize CSS order
   - Consider utility classes
3. Test dropdown functionality:
   - Remove button positioning
   - Hover states
   - Mobile responsiveness

**Success Criteria:**
- Reduced !important count by 50%+ (target: down to ~13)
- All remove button functionality intact
- Dropdown works on mobile and desktop

---

#### Task 1.4: cart_page.css - Mobile Overrides (2-3 hours)
**Current:** 40+ !important in mobile responsive sections

**Issues:**
- Heavy !important in media queries
- Overriding base styles for mobile layouts

**Actions:**
1. Review mobile-specific overrides
2. Refactor approach:
   - Consider mobile-first CSS approach
   - Use more specific selectors
   - Reorganize media query structure
3. Test on multiple breakpoints:
   - 375px (iPhone SE)
   - 768px (tablet)
   - 1280px+ (desktop)

**Success Criteria:**
- Reduced !important in mobile sections by 50%+ (target: down to ~20)
- Mobile cart page works correctly
- Responsive behavior intact

---

#### Task 1.5: Review search.css & navigation.css (1 hour)
**Current:** 54 !important in search.css, 31 in navigation.css

**Actions:**
1. Review each file to identify:
   - External library overrides (Algolia, etc.) → Keep justified
   - Specificity hacks → Flag for refactoring
   - Desktop transparency overrides → Evaluate necessity
2. Document which !important declarations are justified
3. Create issue/TODO for remaining hacks to address later

**Success Criteria:**
- Clear documentation of justified vs. hack !important usage
- Plan for addressing hacks (may defer to future session)
- No changes if all are justified external overrides

---

### Keep These !important (Justified External Overrides)
- checkouts.css: Stripe iframe overrides (6 instances) - DO NOT TOUCH
- search.css: Algolia widget overrides - Review but likely keep most
- navigation.css: Some desktop transparency - Evaluate case-by-case

---

## Part 2: Semantic Grouping Retroactive Pass (4-5 hours)

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

### Tasks

#### Task 2.1: Audit Current State (30 mins)
- Review remaining files (layout, header, footer, navigation, products)
- Identify which @apply blocks would benefit from grouping
- Note any files with mixed vanilla/@apply that need more work

#### Task 2.2: Apply Semantic Grouping (2-3 hours)
- Update layout.css with semantic grouping
- Update header.css with semantic grouping (if beneficial)
- Update footer.css with semantic grouping (if beneficial)
- Update navigation.css with semantic grouping (if beneficial)
- Update products.css with semantic grouping (if beneficial)

#### Task 2.3: Review & Consistency Check (1 hour)
- Verify all files use consistent category names
- Verify all files use consistent category ordering
- Check for any missed `@apply` blocks
- Ensure comments are clear and helpful

#### Task 2.4: Testing (30 mins)
- Visual regression testing - ensure no styling changes
- Review all pages in browser
- Verify CSS builds correctly

---

## Dependencies

**Depends on:**
- Session 5A complete (specificity & foundation cleanup)
- All Session 4 work merged (4A-4D)

**Blocks:**
- Nothing - this is polish work

---

## Success Criteria

**Part 1: !important Reduction**
- ✅ Complete inventory of inline `!` prefix usage in views
- ✅ !important usage reduced by ~50% in cart components (target: ~160 total, down from 317)
- ✅ Clear documentation of justified vs. hack !important usage
- ✅ All cart functionality working after refactoring
- ✅ No visual regressions

**Part 2: Semantic Grouping**
- ✅ All CSS files using `@apply` have semantic grouping applied (where beneficial)
- ✅ Category names are consistent across all files
- ✅ Category ordering is logical and consistent
- ✅ All classes have explanatory comments
- ✅ No visual changes to the application

**Overall**
- ✅ CSS builds without errors
- ✅ Comprehensive testing across all breakpoints
- ✅ Work log documenting decisions made

---

## Non-Goals

This session does NOT include:
- Converting vanilla CSS to `@apply` (completed in Session 5A)
- Removing ALL !important declarations (goal is 50% reduction, not 100% elimination)
- Major component structure refactoring
- Changing actual styling or visual behavior (should look identical)
- Unused class cleanup (that's Session 5C)
- TODO/FIXME resolution (that's Session 5C)
- Button naming consolidation (that's Session 5C)

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
- When you have dedicated time for quality improvements
- When not under timeline pressure (specificity work is risky)

**Do incrementally if preferred:**
- Can tackle !important reduction file by file as you touch them
- Can apply semantic grouping as you work in each file
- Don't have to do all at once

**Or defer indefinitely if:**
- Time is severely constrained
- Other priorities are more urgent
- Current state is workable
- Risk tolerance is low

---

## Notes

**Part 1: !important Reduction**
- This is moderately risky work - specificity changes can break layouts
- Requires thorough testing after each file
- Better done when not under timeline pressure
- Document all decisions (what to keep, what to refactor, why)
- Expect some trial and error

**Part 2: Semantic Grouping**
- This is low-risk code organization work
- No functional changes, purely developer experience
- Can be done incrementally or all at once
- Remaining files are simpler than those already done
- Some files may be too simple to benefit from grouping

**Combined Approach:**
- Can do Part 1 and Part 2 together in same session
- Or split them into separate sessions if preferred
- Part 2 is a good "cooldown" task after risky Part 1 work

---

## Related Documentation

- **[Session 5A](./session_5a_specificity_cleanup.md)** - Completed foundation fixes (prerequisite)
- **[Session 5C](./session_5c_code_quality.md)** - Other deferred polish work
- **[Session 4E](./session_4e_semantic_grouping.md)** - Original semantic grouping plan
- **[Comprehensive Plan](../../x_notes_x/SESSION_5_COMPREHENSIVE_PLAN.md)** - Full Session 5 overview with audit findings
- **[Session 5A Commit Strategy](../../x_notes_x/SESSION_5A_COMMIT_STRATEGY.md)** - Original commit plan that included !important work

---

*This session combines two types of polish work deferred from Session 5A to prioritize MVP timeline. Both are code quality improvements that significantly enhance maintainability but don't block feature development.*
