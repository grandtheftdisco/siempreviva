import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="quantity-toggle"
export default class extends Controller {
  static targets = ["badge", "selector"]

  connect() {
    // Ensure selector starts hidden
    this.selectorTarget.classList.add("hidden")
  }

  toggle() {
    // Toggle visibility with Tailwind classes
    this.badgeTarget.classList.toggle("hidden")
    this.selectorTarget.classList.toggle("hidden")
  }

  // Alternative: separate expand/collapse methods if needed
  expand() {
    this.badgeTarget.classList.add("hidden")
    this.selectorTarget.classList.remove("hidden")
  }

  collapse() {
    this.badgeTarget.classList.remove("hidden")
    this.selectorTarget.classList.add("hidden")
  }
}
