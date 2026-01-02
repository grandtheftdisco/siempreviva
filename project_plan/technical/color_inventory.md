# Color System Inventory

**System:** sv-colors (Tailwind v4 @theme)
**Location:** `app/assets/tailwind/application.css`
**Status:** ✅ Implemented in Session 1

---

## Available Colors

### Purple Shades
| Color | Hex | Use Case |
|-------|-----|----------|
| `sv-purple-100` | #f0e8f5 | Light backgrounds, form inputs |
| `sv-purple-200` | #e6d3ec | Subtle backgrounds, borders |
| `sv-purple-400` | #c5aace | Primary buttons, accents |
| `sv-purple-700` | #674174 | Hover states, dark text |

### Green Shades
| Color | Hex | Use Case |
|-------|-----|----------|
| `sv-green-200` | #bdcea9 | Light backgrounds, success states |
| `sv-green-400` | #8ba170 | Medium accents |
| `sv-green-600` | #698b3f | Primary green buttons |
| `sv-green-700` | #4f5e3c | Hover states, dark green |

---

## Usage Examples

### In CSS (with @apply)
```css
.my-component {
  @apply bg-sv-purple-100 border-sv-purple-400;
  @apply text-sv-gray-800 hover:bg-sv-purple-200;
}
```

### Adding Opacity
```css
.my-component {
  @apply bg-sv-purple-400/90;  /* 90% opacity */
  @apply border-sv-green-600/50;  /* 50% opacity */
}
```

---

## Requesting New Colors

Need an intermediate shade? Just ask! We can add:
- `sv-purple-300` (between 200 and 400)
- `sv-purple-500` (between 400 and 700)
- Or any other shade needed

Colors are calculated using interpolation for consistency.

---

## Color System Philosophy

- **Numbered system (100-900):** Follows Tailwind convention
- **sv- prefix:** "Siempreviva" brand colors
- **Semantic names:** success, danger, warning for common UI states
- **Single source of truth:** All defined in @theme block

---

*For implementation details, see `app/assets/tailwind/application.css` lines 6-34*
