import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="content"
export default class extends Controller {
  static targets = ["articleResult"]
  connect() {
    console.log(this.articleResultTarget)
  }
}
