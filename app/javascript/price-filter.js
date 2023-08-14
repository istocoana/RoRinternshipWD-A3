  let uislider = document.getElementById("uislider");
  let minPrice = document.getElementById("min-slider");
  let maxPrice = document.getElementById("max-slider");
  let filteredResults = document.getElementById("filtered-results"); 

  noUiSlider.create(uislider, {
    start: [5, 55],
    connect: true,
    range: {
      min: 0,
      max: 100,
    },
  });

  uislider.noUiSlider.on("update", function (values) {
    minPrice.textContent = "$" + values[0];
    maxPrice.textContent = "$" + values[1];

    filterFood();
    // filterFood(minPrice, maxPrice);
  });


  function filterFood() {
    const priceRange = uislider.noUiSlider.get();
    const minPrice = parseFloat(priceRange[0]);
    const maxPrice = parseFloat(priceRange[1]);
  
    const foodItems = document.getElementsByClassName("item");
  
    Array.from(foodItems).forEach((foodItem) => {
      const foodPrice = parseFloat(foodItem.dataset.price);
  
      if (foodPrice >= minPrice && foodPrice <= maxPrice) {
        foodItem.style.display = "block";
      } else {
        foodItem.style.display = "none";
      }
    })
  }



