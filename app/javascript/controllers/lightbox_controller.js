import { Controller } from "@hotwired/stimulus"
import GLightbox from "glightbox"

export default class extends Controller {
  connect() {
    this.lightbox = GLightbox({
      selector: ".glightbox",
      touchNavigation: true,
      loop: true,
      closeOnOutsideClick: true,
      autofocusVideos: false,
      zoomable: true,
      draggable: true
    })
  }

  disconnect() {
    if (this.lightbox) {
      this.lightbox.destroy()
    }
  }
}
