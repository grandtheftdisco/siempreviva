# Component Classes Reference

Quick reference for all available component classes created in Session 1.

---

## Buttons

### Primary Button
```html
<a href="#" class="btn-primary">Primary Action</a>
```
- Purple filled button (sv-purple-400)
- Hovers to darker purple (sv-purple-700)
- Use for primary CTAs

### Secondary Button
```html
<a href="#" class="btn-secondary">Secondary Action</a>
```
- Green outline button
- Hovers to filled green (sv-green-700)
- Use for secondary actions

### Green Button
```html
<button class="btn-green">Add to Cart</button>
```
- Green filled button (sv-green-700)
- Hovers to brighter green (sv-green-600)
- Use for additive actions

### Danger Button
```html
<button class="btn-danger">Delete</button>
```
- Red filled button (sv-danger)
- Use for destructive actions

### Size Variants
```html
<a href="#" class="btn-primary btn-small">Small</a>
<a href="#" class="btn-primary btn-large">Large</a>
```
- Combine with any button style
- `btn-small`: Compact padding
- `btn-large`: Extra padding

---

## Forms

### Form Container
```html
<form class="form-container">
  <!-- form content -->
</form>
```
- Modern form wrapper
- Padding, border, rounded corners
- No max-width constraint

### Submit Button
```html
<button type="submit" class="btn-submit">Submit</button>
```
- Purple submit button
- Hovers to darker purple
- Use for all form submissions

### Text Input
```html
<input type="text" class="input-text" placeholder="Enter text">
<input type="email" class="input-text" placeholder="Email">
```
- Light purple background (sv-purple-100)
- Purple border (sv-purple-200)
- Focus state with ring

### Textarea
```html
<textarea class="input-textarea" placeholder="Your message"></textarea>
```
- Same styling as text input
- Vertically resizable
- Min-height: 150px

### Label
```html
<label class="label-text">Email Address</label>
```
- Bold, purple text (sv-purple-700)
- Block display with margin-bottom

### Input States

**Error State:**
```html
<input type="text" class="input-error" placeholder="Required field">
```
- Red border (sv-danger)
- Light red background
- Use with error messages

**Success State:**
```html
<input type="text" class="input-success" placeholder="Looks good!">
```
- Green border (sv-success)
- Light green background
- Use for validation feedback

---

## Complete Form Example

```html
<form class="form-container">
  <div>
    <label class="label-text">Full Name</label>
    <input type="text" class="input-text" placeholder="John Doe" required>
  </div>

  <div>
    <label class="label-text">Email</label>
    <input type="email" class="input-text" placeholder="john@example.com" required>
  </div>

  <div>
    <label class="label-text">Message</label>
    <textarea class="input-textarea" placeholder="Your message here"></textarea>
  </div>

  <button type="submit" class="btn-submit">Send Message</button>
</form>
```

---

## Legacy Classes (Still Available)

These classes are still available for backward compatibility with cart/checkout views:

- `.checkout-btn` - Green checkout button (used in cart)
- `.continue-shopping-btn` - Green outline button
- `.cart-checkout-btn` - Full-width checkout button
- `.quantity-update-btn-visible` - Light green update button
- `.remove-item-btn-red` - Red remove button

**Note:** New views should use the modern component classes above. Legacy classes will be removed in Session 4 (optional future cleanup).

---

## Using sv-Colors in CSS

### With @apply Directive
```css
.custom-component {
  @apply bg-sv-purple-100 border-sv-purple-400;
  @apply text-sv-gray-800 hover:bg-sv-purple-200;
  @apply px-4 py-2 rounded-lg transition-colors;
}
```

### With Opacity Modifiers
```css
.translucent-bg {
  @apply bg-sv-purple-400/50;  /* 50% opacity */
}
```

### Responsive Variants
```css
.responsive-button {
  @apply bg-sv-purple-400 px-4 py-2;
  @apply md:px-6 md:py-3;  /* Larger on tablet+ */
  @apply lg:text-lg;  /* Bigger text on desktop */
}
```

---

## Best Practices

### DO:
✅ Use component classes for consistent styling
✅ Combine classes for variants (btn-primary btn-small)
✅ Create new component classes in components.css as needed
✅ Use sv-colors with @apply in custom CSS

### DON'T:
❌ Use inline Tailwind utilities in views
❌ Hardcode hex colors in CSS
❌ Mix component classes with inline styles
❌ Override component classes with !important

---

## Need Something New?

If you need a component class that doesn't exist:

1. **Check if it's truly reusable** - Will you use it more than once?
2. **Add it to components.css** with @apply and sv-colors
3. **Document it** with inline comments
4. **Update this reference** if it's commonly used

---

*For complete implementation details, see `app/assets/tailwind/components.css` and `app/assets/tailwind/forms.css`*
