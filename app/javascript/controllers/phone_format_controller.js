import {Controller} from "@hotwired/stimulus"

// Connects to data-controller="phone-format"
export default class extends Controller {
  static targets = ['phoneNumberInput']
  connect() {
    console.log("FORMATTING phone number")
  }

  formatPhoneNumber(event) {
    const input = event.target.value.replace(/\D/g, ''); // Remove all non-numeric characters
    const formatted = this.applyFormat(input);
    event.target.value = formatted;
  }

  applyFormat(value) {
    // Format as "597 03 36 35"
    const part1 = value.slice(0, 3);
    const part2 = value.slice(3, 5);
    const part3 = value.slice(5, 7);
    const part4 = value.slice(7, 9);

    return [part1, part2, part3, part4].filter(Boolean).join(' ');
  }
}
