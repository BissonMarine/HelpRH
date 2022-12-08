import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="chapters"
export default class extends Controller {
  static targets = ["position"]

  connect() {

  }

  scroll(event){
    console.log("connected to scroll controller");
    const positionIndex = event.target.dataset.index;
    this.positionTargets[positionIndex].scrollIntoView()
  }
}
