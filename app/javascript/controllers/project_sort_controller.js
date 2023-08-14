import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="project-sort"
export default class extends Controller {
    static targets = ["select"];
    connect() {
        console.log("Hello, Stimulus!", this.element);
        console.log(this.selectTarget.value);
    }
    sortProjects() {
        const sortBy = this.selectTarget.value;
        const url = `/projects?sort_by=${sortBy}`;

        // Refresh the page
        // Turbo.visit(url);

        this.doTurboRequest(url);
    }
    doTurboRequest(url) {
        fetch(url, {
            headers: {
                Accept: "text/vnd.turbo-stream.html",
            },
        })
            .then((response) => response.text())
            .then((html) => {
                Turbo.renderStreamMessage(html);
            });
    }
    update() {
        console.log("update");
        this.sortProjects();
    }
}