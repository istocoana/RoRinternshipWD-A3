let uislider = document.getElementById("uislider");
  let min = document.getElementById("min-slider");
  let max = document.getElementById("max-slider");

  noUiSlider.create(uislider, {
    start: [5, 55],
    connect: true,
    range: {
      min: 0,
      max: 100,
    },
  });

  uislider.noUiSlider.on("update", function (values) {
    min.textContent = "$" + values[0];
    max.textContent = "$" + values[1];
    filterFood();
  });


function filterFood() {
  const priceRange = uislider.noUiSlider.get();
  const minPrice = parseFloat(priceRange[0]);
  const maxPrice = parseFloat(priceRange[1]);

  const foodItems = document.getElementsByClassName("food-item");

  Array.from(foodItems).forEach((foodItem) => {
    const foodPrice = parseFloat(foodItem.dataset.price);

    if (foodPrice >= minPrice && foodPrice <= maxPrice) {
      foodItem.style.display = "block";
    } else {
      foodItem.style.display = "none";
    }
  })
}

var bar = document.getElementById("bar-scroll");
var sticky = bar.offsetTop;

window.onscroll = function () {
  stickyBar();
};

function stickyBar() {
  if (window.pageYOffset >= sticky) {
    bar.style.position = "fixed";
    bar.style.top = "0";
    bar.style.width = "100%";
    bar.style.zIndex = "100";
  } else {
    bar.style.position = "";
    bar.style.top = "";
    bar.style.width = "";
    bar.style.zIndex = "";
  }
}

