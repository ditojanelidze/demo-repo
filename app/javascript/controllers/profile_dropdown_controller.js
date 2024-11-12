import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="navigation"
export default class extends Controller {
  static targets = ["menu"]

  toggle(event) {
    event.preventDefault()
    this.menuTarget.classList.toggle("hidden")
  }

  connect() {
    document.addEventListener('click', this.handleOutsideClick.bind(this))
  }

  disconnect() {
    document.removeEventListener('click', this.handleOutsideClick.bind(this))
  }

  handleOutsideClick(event) {
    if (!this.element.contains(event.target)) {
      this.menuTarget.classList.add("hidden")
    }
  }
}
