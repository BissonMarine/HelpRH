import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="resultscroll"
export default class extends Controller {
  connect() {
    setTimeout(() => {
      if(document.getElementById('main-subject-chapter')){
        document.getElementById('main-subject-chapter').scrollIntoView();
      }
      else {
        document.getElementById('main-subject-article').scrollIntoView();
      }
    }, "500")
  }
}
