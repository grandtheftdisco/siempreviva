import { Application } from "@hotwired/stimulus"
import "flowbite"

const application = Application.start()

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

// Initialize Flowbite components
document.addEventListener('DOMContentLoaded', function() {
  if (typeof window.initFlowbite === 'function') {
    window.initFlowbite()
  }
})

export { application }
