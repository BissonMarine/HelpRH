import { Controller } from "@hotwired/stimulus"
import Typed from "typed.js"

// Connects to data-controller="typed-js"
export default class extends Controller {
  connect() {
    new Typed(this.element, {
      strings: ["Je cherche des informations sur mes droits à congés payés ?", "Je cherche des informations sur mon préavis quand je démissionne ?", "Je cherche des informations sur le paiement de mes heures supplémentaires ?", "<strong>Je tape ma recherche sur le formulaire ci-contre !</strong>"],
      typeSpeed: 50,
      loop: false
    })
  }
}
