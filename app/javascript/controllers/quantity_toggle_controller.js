import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="quantity-toggle"
export default class extends Controller {
  static targets = ["badge", "selector"]

  connect() {
    console.log("quantity-toggle controller connected!")
    console.log("Badge target:", this.badgeTarget)
    console.log("Selector target:", this.selectorTarget)

    // Ensure selector starts hidden
    this.selectorTarget.classList.add("hidden")
  }

  toggle() {
    console.log("Toggle clicked!")
    console.log("Badge classes before:", this.badgeTarget.classList.toString())
    console.log("Selector classes before:", this.selectorTarget.classList.toString())

    // Toggle visibility with Tailwind classes
    this.badgeTarget.classList.toggle("hidden")
    this.selectorTarget.classList.toggle("hidden")

    console.log("Badge classes after:", this.badgeTarget.classList.toString())
    console.log("Selector classes after:", this.selectorTarget.classList.toString())
  }

  // Alternative: separate expand/collapse methods if needed
  expand() {
    console.log("Expand called!")
    this.badgeTarget.classList.add("hidden")
    this.selectorTarget.classList.remove("hidden")
  }

  collapse() {
    console.log("Collapse called!")
    this.badgeTarget.classList.remove("hidden")
    this.selectorTarget.classList.add("hidden")
  }
}
