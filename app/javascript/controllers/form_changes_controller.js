// app/javascript/controllers/form_changes_controller.js
import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["submitButton"];

  connect() {
    this.disableSubmitButton();
  }

  checkForChanges() {
    console.log("checking for changes")
    let changed = false
    const profileForm = document.getElementById('profile-update-form')
    const inputFields = ['#user_first_name', '#user_last_name']
    const selectFields = ['#user_locale']

    inputFields.forEach((item) => {
        const currentInput = profileForm.querySelector(item);
        if(currentInput.defaultValue !== currentInput.value){
          changed = true
        }
      }
    )

    selectFields.forEach((item) => {
      const currentSelect = profileForm.querySelector(item);
      if(!currentSelect.options[currentSelect.options.selectedIndex].defaultSelected){
        changed = true
      }
    })


    if (changed) {
      this.enableSubmitButton();
    } else {
      this.disableSubmitButton();
    }
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
