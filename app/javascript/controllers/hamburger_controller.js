import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["button", "nav"]

  toggle() {
    this.buttonTarget.classList.toggle("is-active")
    this.navTarget.classList.toggle("is-open")
  }

  close() {
    this.buttonTarget.classList.remove("is-active")
    this.navTarget.classList.remove("is-open")
  }
}