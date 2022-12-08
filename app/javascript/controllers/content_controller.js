import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="content"
export default class extends Controller {
  static targets = ["articleResult", "form"]
  connect() {
  }

  send(event) {
    event.preventDefault()
    console.log(this.formTarget)
    const search = new URLSearchParams(new FormData(this.formTarget));
    console.log(search.toString())
    fetch('${this.formTarget.formAction}?${search.toString()}', {
      method: "GET",
      headers: { "Accept": "application/json" },
    })
      .then(response => response.json())
      .then((data) => {
        console.log(data)
      })
  }
}
