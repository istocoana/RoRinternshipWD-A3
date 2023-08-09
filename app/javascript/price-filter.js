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

  // function filterFood(minPrice, maxPrice) {
  //   fetch(`/services/product_filter_service?min_price=${minPrice}&max_price=${maxPrice}`)
  //     .then(response => response.json())
  //     .then(data => {
  //       filteredResults.innerHTML = ''; 
  //       data.forEach(product => {
  //         const foodElement = document.createElement('div');
  //         foodElement.className = 'filtered-products';
          
  //         const titleElement = document.createElement('h6');
  //         titleElement.textContent = product.title;
  
  //         const descriptionElement = document.createElement('p');
  //         descriptionElement.textContent = product.description;
  
  //         const priceElement = document.createElement('p');
  //         priceElement.textContent = `$${product.price}`;
  
  //         foodElement.appendChild(titleElement);
  //         foodElement.appendChild(descriptionElement);
  //         foodElement.appendChild(priceElement);
  
  //         filteredResults.appendChild(foodElement);
  //       });
  //     })
  //     .catch(error => {
  //       console.error('Error:', error);
  //     });
  // }


