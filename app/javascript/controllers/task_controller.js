import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="task"
export default class extends Controller {
  connect() {
  }
  
  filter(event){
    const filter = event.srcElement;
    const frame = document.querySelector("turbo-frame#body");

    if (filter.selectedIndex) {
      const checked = filter.options[filter.selectedIndex].text;
      frame.src = location.href + '?' + new URLSearchParams({ priority: checked }).toString();
    } else {
      frame.src = location.href;
    }

    frame.reload();
  }
}
