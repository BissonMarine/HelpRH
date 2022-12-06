import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["keyup", "input", "div", "li", "a", "i"]

  connect() {
    // console.log("Connected to Dropdown ctrller !")
  }

  show() {
    this.keyupTarget.classList.toggle("display");
  }

  filter() {
    for (i = 0; i < a.length; i++) {
      txtValue = a[i].textContent || a[i].innerText;
      if (txtValue.indexOf(this.inputTarget.value) > -1) {
        a[i].style.display = "";
      } else {
        a[i].style.display = "none";
      }
    }
  }
}
