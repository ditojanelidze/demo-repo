import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="phone-number-change"
export default class extends Controller {
  static targets = ["submitButton", "phoneNumberInput"];

  connect() {
    this.disableSubmitButton();
  }

  checkForChanges() {
    if (this.phoneNumberInputTarget.defaultValue !== this.phoneNumberInputTarget.value && this.correctFormat()) {
      this.enableSubmitButton();
    } else {
      this.disableSubmitButton();
    }
  }

  correctFormat() {
    return (/^\d{3} \d{2} \d{2} \d{2}$/).test(this.phoneNumberInputTarget.value)
  }
  disableSubmitButton() {
    this.submitButtonTarget.disabled = true;
    this.submitButtonTarget.classList.add("opacity-50", "cursor-not-allowed");
  }

  enableSubmitButton() {
    this.submitButtonTarget.disabled = false;
    this.submitButtonTarget.classList.remove("opacity-50", "cursor-not-allowed");
  }
}
