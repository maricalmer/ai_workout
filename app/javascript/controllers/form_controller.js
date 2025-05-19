import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["submitBtn", "loadingBtn"]

  submit() {
    this.submitBtnTarget.classList.add("d-none")
    this.loadingBtnTarget.classList.remove("d-none")
  }
}
