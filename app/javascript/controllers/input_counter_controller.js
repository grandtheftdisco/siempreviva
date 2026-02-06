import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input"]

  decrement() {
    const min = parseInt(this.inputTarget.min) || 0
    const current = parseInt(this.inputTarget.value) || 0
    if (current > min) {
      this.inputTarget.value = current - 1
    }
  }

  increment() {
    const current = parseInt(this.inputTarget.value) || 0
    this.inputTarget.value = current + 1
  }
}
