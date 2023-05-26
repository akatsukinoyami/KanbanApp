import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="task"
export default class extends Controller {
  connect() {
  }
  
  filter(){
    const priorities = [];
    [...document.getElementsByClassName("priority-filter")].forEach((element) => {
      if(element.checked) priorities.push(element.id.replace("_priority_filter", ""))
    })

    if (priorities.length !== 0){
      const filter = document.getElementById("btn-check").checked;
      const prioritiesStrigified = encodeURIComponent(JSON.stringify(priorities));

      const frame = document.querySelector("turbo-frame#body");
      frame.src = `${location.href}?filter_opened=${filter}&priorities=${prioritiesStrigified}`;
      frame.reload();
    }
  }
}
