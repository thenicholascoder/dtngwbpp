// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails";
import "controllers";
import "custom/menu";

let splide; // Declare splide in a wider scope

document.addEventListener("turbo:load", function () {
  if (
    window.location.pathname === "/" &&
    window.location.pathname.length === 1
  ) {
    splide = new Splide(".splide", {
      start: 1,
      arrows: false,
      pagination: false,
      perPage: 1,
      perMove: 1,
      focus: "center",
      gap: "1rem",
    });

    let prevSlide = 2;

    splide.on("move", function () {
      const currSlide = splide.index + 1;
      prevSlide = currSlide;

      if (splide.index === 0) {
        // Get the element by its id
        var dangerBtn = document.getElementById("dangerBtn");

        // Check if the element exists
        if (dangerBtn !== null) {
          // Simulate a click event on the element
          dangerBtn.click();
        } else {
          console.log("Element with id 'dangerBtn' not found.");
        }
        setTimeout(function () {
          splide.go(">");
        }, 300);
      }

      if (splide.index === splide.length - 1) {
        // Get the element by its id
        var successBtn = document.getElementById("successBtn");

        // Check if the element exists
        if (successBtn !== null) {
          // Simulate a click event on the element
          successBtn.click();
        } else {
          console.log("Element with id 'successBtn' not found.");
        }
        setTimeout(() => {
          splide.go(splide.length - 2);
        }, 300);
      }
    });

    splide.mount();
  }
});
