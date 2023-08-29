import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="project-sort"
export default class extends Controller {
    static targets = ["select"];
    connect() {

    }
    sortProjects() {
        const sortBy = this.selectTarget.value;
        var selectElement = document.getElementById("sort_by");
        var userId = selectElement.getAttribute("data-user-id");
        const url = `/users/${userId}/projects?sort_by=${sortBy}`;

        // Refresh the page
        Turbo.visit(url);
    }

    update() {
        console.log("update");
        this.sortProjects();
    }
}