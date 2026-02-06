import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = { targetId: String }

  connect() {
    this.clickOutsideHandler = this.closeOnClickOutside.bind(this)
    document.addEventListener("click", this.clickOutsideHandler)
  }

  disconnect() {
    document.removeEventListener("click", this.clickOutsideHandler)
  }

  get collapseElement() {
    return document.getElementById(this.targetIdValue)
  }

  toggle(event) {
    event.preventDefault()
    this.collapseElement?.classList.toggle("hidden")
  }

  closeOnClickOutside(event) {
    if (!this.element.contains(event.target) && !this.collapseElement?.contains(event.target)) {
      this.collapseElement?.classList.add("hidden")
    }
  }
}
