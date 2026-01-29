import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="scroll-navigation"
export default class extends Controller {
  // Scroll to the next section
  scrollToNext(event) {
    event.preventDefault()

    // Find the current section
    const currentSection = event.target.closest('[data-scroll-section]')

    if (!currentSection) return

    // Find the next section
    const nextSection = currentSection.nextElementSibling

    if (nextSection) {
      // Smooth scroll to next section
      nextSection.scrollIntoView({
        behavior: 'smooth',
        block: 'start'
      })
    }
  }

  // Scroll back to top
  scrollToTop(event) {
    event.preventDefault()

    // Scroll to the top of the page
    window.scrollTo({
      top: 0,
      behavior: 'smooth'
    })
  }
}
