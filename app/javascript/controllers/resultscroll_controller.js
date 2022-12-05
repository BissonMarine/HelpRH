import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="resultscroll"
export default class extends Controller {
  connect() {
    setTimeout(() => {
      document.getElementById('main-subject-chapter').scrollIntoView();
    }, "500")
  }
}
