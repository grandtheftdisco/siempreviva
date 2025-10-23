# Design Decisions

Key architectural and technical decisions made during the CSS refactoring project.

---

## 1. Color System: Tailwind v4 @theme Directive

**Decision:** Use Tailwind v4 `@theme` directive instead of v3 `tailwind.config.js`

**Context:**
- Originally planned to use tailwind.config.js (v3 approach)
- Discovered project uses Tailwind v4 during implementation
- Tailwind v4 uses @theme in CSS files, not config.js

**Outcome:**
```css
/* application.css */
@theme {
  --color-sv-purple-400: #c5aace;
  --color-sv-green-600: #698b3f;
  /* etc. */
}
```

**Benefits:**
- Simpler configuration
- Everything in CSS files
- Better integration with @apply
- No separate config file to maintain

---

## 2. Convert SCSS to Pure CSS

**Decision:** Convert components.scss → components.css, drop SCSS entirely

**Problem:**
- `@apply` with custom Tailwind colors didn't work reliably in SCSS files
- Got errors: "Cannot apply unknown utility class `bg-sv-purple-400`"
- Could work around with hex values, but defeats purpose

**Solution:**
- Convert to pure CSS
- Use @apply with sv-colors (works perfectly)
- Remove all SCSS syntax (mixins, variables, &:hover)

**Trade-offs:**
- **Lost:** darken()/lighten() functions from SCSS
- **Solution:** Add more shades to @theme or use opacity modifiers
- **Gained:** Cleaner code, single source of truth, better maintainability

**Outcome:** Much cleaner, modern CSS with Tailwind integration

---

## 3. Color Naming Convention

**Decision:** Use `sv-[color]-[shade]` format with Tailwind-style numbering

**Examples:**
- `sv-purple-400` (medium purple)
- `sv-green-600` (primary green)
- `sv-gray-800` (dark text)

**Numbering System:**
- 50 = lightest shade
- 900 = darkest shade
- Standard increments: 100, 200, 400, 600, 700
- Can add intermediate shades (300, 500, etc.) as needed

**Reasoning:**
- Follows Tailwind's established convention
- Familiar to developers
- Scalable system
- "sv-" prefix clearly identifies brand colors

---

## 4. Backward Compatibility Strategy

**Decision:** Conservative approach - add new classes, keep old selectors

**Approach:**
- Phase 1-3: Add new component classes using @apply
- Keep existing element selectors for cart/checkout views
- New views (product/marketing) use component classes
- Phase 6 (optional future): Migrate old views, remove legacy code

**Reasoning:**
- Cart and checkout views already merged and working
- Zero risk of breaking production features
- Allows confident refactoring
- Can clean up later when modifying those features anyway

**Example:**
```css
/* forms.css */

/* Legacy (for cart/checkout) */
form input[type="submit"] {
  background-color: #c5aace;
  /* ... */
}

/* New (for product/marketing) */
.btn-submit {
  @apply bg-sv-purple-400 text-white px-6 py-3 rounded-full;
}
```

---

## 5. Component Class Naming

**Decision:** Continue with simple, clear naming style

**Format:** `.component-variant`

**Examples:**
- `.btn-primary`
- `.btn-secondary`
- `.input-text`
- `.form-container`

**NOT using:**
- ❌ BEM: `.btn--primary`, `.form__input--error`
- ❌ Inline Tailwind: `class="px-6 py-3 bg-purple-400..."`

**Reasoning:**
- Simple and clear
- Easy to type and remember
- Consistent with existing code
- Inline Tailwind is verbose and hard to maintain

---

## 6. No Inline Tailwind Utilities

**Decision:** Use component classes, not inline Tailwind

**Avoid:**
```erb
<a class="px-6 py-3 bg-purple-400 rounded-full hover:bg-purple-700">Button</a>
```

**Do:**
```erb
<a class="btn-primary">Button</a>
```

**Reasoning:**
- Reusable across views
- Single place to update styles
- Cleaner view templates
- Easier to maintain consistency

---

## 7. Git Workflow: Separate Refactor Branch

**Decision:** Create `refactor/css-to-tailwind` branch from main

**Workflow:**
```
main (cart/checkout merged)
  ↓
refactor/css-to-tailwind (Session 1 work)
  ↓ (merge PR)
main (updated)
  ↓
amanda/marketing-views (rebase on updated main)
```

**Reasoning:**
- Clean separation of infrastructure vs feature work
- Can review refactor independently
- Test impact on existing views in isolation
- Marketing views build on stable foundation

---

## 8. Testing Strategy

**Decision:** Manual testing + existing test suite (skip writing new CSS tests for now)

**Approach:**
- Thorough manual testing of cart/checkout views
- Run existing Rails test suite
- Document pre-existing failures
- Visual regression testing via manual comparison
- Skip writing new CSS-specific automated tests (can add later)

**Reasoning:**
- Manual testing sufficient for CSS changes
- Existing test suite catches functional regressions
- CSS-specific tests often provide diminishing returns
- Can add visual regression tests in future if needed

---

## 9. Session-Based Project Structure

**Decision:** Organize work into discrete "sessions" instead of monolithic refactor

**Structure:**
- **Session 1:** Foundation (colors, components, forms)
- **Session 2:** Product/marketing views
- **Session 3:** Layout (optional future)
- **Session 4:** Legacy cleanup (optional future)

**Benefits:**
- Clear milestones and deliverables
- Can merge foundation before finishing all work
- Reduces risk and scope
- Flexibility in timeline
- Can skip optional sessions

**Reasoning:**
- Monolithic refactors are risky
- Incremental approach more manageable
- Aligns with "just-in-time" philosophy
- Easier to review and test

---

## Questions & Answers

**Q: Why not use inline Tailwind?**
A: Cleaner views, reusable styles, easier maintenance

**Q: Why drop SCSS?**
A: @apply with custom Tailwind colors doesn't work reliably in SCSS

**Q: Why keep backward compatibility?**
A: Cart/checkout already working, zero risk approach

**Q: When will we clean up legacy code?**
A: Session 4 (optional), or just-in-time when modifying those features

**Q: Can we request new color shades?**
A: Yes! Just ask and we'll add them to @theme

---

*These decisions shaped the project and can inform future work*
