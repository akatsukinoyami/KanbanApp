import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="task"
export default class extends Controller {
  connect() {
  }
  
  close(event){
    const button = event.srcElement;
    const alert = button.parentElement;
    alert.style.display = "none";
  }
}
