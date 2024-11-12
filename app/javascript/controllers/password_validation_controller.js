import {Controller} from "@hotwired/stimulus"

// Connects to data-controller="password-validation"
export default class extends Controller {
    static targets = ["password", "passwordConfirmation", "passwordConfirmationError", "passwordError"]

    // Called when the form is submitted
    validate(event) {
        this.passwordErrorTarget.textContent = '';
        this.passwordErrorTarget.classList.add('hidden');

        this.passwordConfirmationErrorTarget.textContent = '';
        this.passwordConfirmationErrorTarget.classList.add('hidden')


        if (this.passwordTarget.value.length < 8 || !/[A-Za-z]/.test(this.passwordTarget.value) || !/[0-9]/.test(this.passwordTarget.value)) {
            event.preventDefault();
            this.passwordErrorTarget.textContent = "Password is not strong enough";
            this.passwordErrorTarget.classList.remove('hidden');
        }

        if (this.passwordTarget.value !== this.passwordConfirmationTarget.value) {
            event.preventDefault();
            this.passwordConfirmationErrorTarget.textContent = "Passwords do not match";
            this.passwordConfirmationErrorTarget.classList.remove('hidden');
        }
    }
}
