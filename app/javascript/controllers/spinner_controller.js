import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="spinner"
export default class extends Controller {
  static targets = ["circle", "submit"]
  connect() {

  }
  spinShow() {
    console.log("oui");
    this.submitTarget.classList.add("hidden");
    this.circleTarget.classList.remove("hidden");
    this.circleTarget.classList.add("block");
  }
}
