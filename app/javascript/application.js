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
        setTimeout(function () {
          splide.go(">");
        }, 300);
      }

      if (splide.index === splide.length - 1) {
        setTimeout(() => {
          splide.go(splide.length - 2);
        }, 300);
      }
    });

    splide.mount();
  }
});
