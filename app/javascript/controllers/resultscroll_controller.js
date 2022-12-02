import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="resultscroll"
export default class extends Controller {
  connect() {
    document.getElementById('main-subject-chapter').scrollIntoView()
  }
}
