import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["modal"]

  hideModal() {
    this.modalTarget.remove()
  }

  submitEnd(e) {
    if (e.detail.success) {
      this.hideModal()
    }
  }

  closeWithKeyboard(e) {
    if (e.code == "Escape") {
      this.hideModal()
    }
  }

}
