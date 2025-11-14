# Session 4D: email.css + search.css Refactoring

**Status:** ⏳ UPCOMING
**When:** After Session 4A submitted for review
**Estimated Time:** 1.5-2 hours
**Branch:** `css-refactor/session-4d-email-search` (will branch from `main`, NOT 4A)

---

## Overview

Refactor email.css and search.css to use Tailwind's `@apply` directive with sv-colors. These two smaller files are grouped together as they're both independent and straightforward refactoring tasks.

**Why these are grouped:**
- Both are smaller files (<500 lines combined estimated)
- Both are straightforward refactoring (no complex functionality)
- Grouping keeps PR count manageable
- Can be done in parallel with 4B and 4C

---

## Scope

### Files to Refactor
- `app/assets/tailwind/email.css` - Email template styling
- `app/assets/tailwind/search.css` - Algolia search components

### What Stays the Same
- Email template layouts and functionality
- Search component functionality
- Algolia integration
- All visual appearance

### What Changes
- Replace all hex color values with sv-color variables
- Convert vanilla CSS to @apply where appropriate
- Organize with clear section headers
- Preserve !important where needed for email clients

---

## Part 1: email.css Refactoring

### Special Considerations for Email CSS

**Email clients have poor CSS support:**
- Limited @apply support in some email clients
- May need to keep more vanilla CSS than other files
- !important often required for email client overrides
- Inline styles may be necessary for some email clients

**Approach:**
- Use sv-colors for consistency
- Convert to @apply where safe
- Keep !important if needed for email clients
- Test in multiple email clients (Gmail, Outlook, Apple Mail)
- Document any email-specific !important in Session 5

---

### Task 1A: Analyze email.css Structure

**Steps:**
- [ ] Read through email.css
- [ ] Identify all sections (email layout, headers, body, footers, etc.)
- [ ] Catalog hex values
- [ ] Note email-client-specific overrides

**Expected sections:**
- Email container/wrapper
- Email headers
- Email body content
- Call-to-action buttons
- Email footers
- Mobile responsive overrides

---

### Task 1B: Replace Colors and Convert to @apply

**Steps:**
- [ ] Replace hex colors with sv-colors
- [ ] Convert layout patterns to @apply (where email-safe)
- [ ] Convert typography to @apply
- [ ] Keep email-client-specific !important
- [ ] Test email rendering

**Email testing:**
- [ ] View in Gmail (web)
- [ ] View in Outlook (if available)
- [ ] View in Apple Mail (if available)
- [ ] View on mobile email clients
- [ ] Check dark mode rendering

---

## Part 2: search.css Refactoring

### Special Considerations for Algolia

**Algolia components have specific class names:**
- `.ais-*` class naming convention
- InstantSearch widget styling
- Search box styling
- Results styling
- Pagination styling

**Approach:**
- Replace colors with sv-colors
- Convert to @apply where appropriate
- Preserve Algolia-specific selectors
- Test search functionality thoroughly

---

### Task 2A: Analyze search.css Structure

**Steps:**
- [ ] Read through search.css
- [ ] Identify all Algolia components
- [ ] Catalog hex values
- [ ] Note Algolia-specific overrides

**Expected sections:**
- Search box/input
- Search results container
- Hit (result item) styling
- Pagination controls
- Filters (if any)
- Empty state
- Loading state

---

### Task 2B: Replace Colors and Convert to @apply

**Steps:**
- [ ] Replace hex colors with sv-colors
- [ ] Convert layout patterns to @apply
- [ ] Convert typography to @apply
- [ ] Preserve Algolia widget styling
- [ ] Test search functionality

**Search testing:**
- [ ] Search box displays correctly
- [ ] Can type in search input
- [ ] Results display properly
- [ ] Hit styling correct
- [ ] Pagination works
- [ ] Empty state displays
- [ ] Loading state shows

---

## Task 3: Organize Both Files

**Apply Session 3 organizational pattern for both files:**
- Clear `/* ===== ALL CAPS SECTION ===== */` headers
- Group related components together
- Place media queries adjacent to base classes
- Logical top-to-bottom flow

**email.css suggested structure:**
```css
/* ===== EMAIL CONTAINER ===== */
/* ===== EMAIL HEADERS ===== */
/* ===== EMAIL BODY CONTENT ===== */
/* ===== CALL-TO-ACTION BUTTONS ===== */
/* ===== EMAIL FOOTERS ===== */
/* ===== RESPONSIVE OVERRIDES ===== */
```

**search.css suggested structure:**
```css
/* ===== SEARCH BOX ===== */
/* ===== SEARCH RESULTS CONTAINER ===== */
/* ===== HIT STYLING ===== */
/* ===== PAGINATION ===== */
/* ===== EMPTY STATE ===== */
/* ===== LOADING STATE ===== */
```

---

## Success Criteria

✅ All hex colors replaced with sv-color variables in both files
✅ Vanilla CSS converted to @apply where appropriate
✅ Clear section organization with headers
✅ Media queries adjacent to base classes
✅ Email client compatibility preserved
✅ Algolia search functionality working
✅ Emails render correctly in multiple clients
✅ Search results display properly
✅ No visual regressions
✅ Mobile responsive (375px, 768px, 1280px+)

---

## Testing Checklist

### Email Testing
- [ ] Order confirmation email renders
- [ ] Shipping notification email renders
- [ ] Gmail (web)
- [ ] Outlook (if available)
- [ ] Apple Mail (if available)
- [ ] Mobile email clients
- [ ] Dark mode rendering
- [ ] CTA buttons styled correctly

### Search Testing
- [ ] Search box displays correctly
- [ ] Can perform search
- [ ] Results display properly
- [ ] Hit styling correct
- [ ] Can click results
- [ ] Pagination works
- [ ] Empty state shows
- [ ] Loading state shows

### Responsive
- [ ] Mobile (375px - iPhone SE)
- [ ] Tablet (768px)
- [ ] Desktop (1280px+)

---

## Risk Management

**Risk Level:** Low-Medium

**email.css risks:**
- Email client rendering differences
- Dark mode issues
- Mobile email client issues

**search.css risks:**
- Algolia widget styling breaks
- Search functionality issues

**Mitigation:**
- Test emails in multiple clients
- Test search functionality thoroughly
- Keep email-client !important for Session 5
- Preserve Algolia-specific selectors
- Test on multiple devices

**Rollback Plan:**
- Can revert PR if issues arise
- Independent of 4A/4B/4C
- Original files in git history

---

## Dependencies

**Branches from:** `main` (NOT from 4A)

**Why not 4A?**
- email.css and search.css are independent of view changes
- Can be reviewed/merged in any order after 4A
- Avoids complex rebasing if 4A needs changes

**After 4A merges:**
```bash
git checkout session-4d-email-search
git merge main  # Pull in 4A's changes
# Test, then merge this PR
```

---

## Files Modified in This Session

**CSS:**
- `app/assets/tailwind/email.css` - Complete refactor
- `app/assets/tailwind/search.css` - Complete refactor

**No view changes** (handled in 4A)
**No JS changes** (Algolia integration stays the same)

---

## Session 5 Note

**email.css may keep some !important:**
Email clients often require !important to override their default styles. Document which !important declarations are email-client-specific vs. unnecessary overrides during this session, so Session 5 knows which ones to keep.

---

*Session 4D can be done in parallel with 4B and 4C*