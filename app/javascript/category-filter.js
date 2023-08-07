
// document.addEventListener("DOMContentLoaded", () => {
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
// })

function toggleDropdownMenu(dropdownId, arrowId) {
  var dropdown = document.getElementById(dropdownId);
  var arrow = document.getElementById(arrowId);


  var otherDropdowns = document.querySelectorAll(".dropdown-content");
  otherDropdowns.forEach(function(otherDropdown) {
    if (otherDropdown !== dropdown) {
      otherDropdown.style.display = "none";
    }
  });

  var arrows = document.querySelectorAll(".bi");
  arrows.forEach(function(arrow) {
    arrow.classList.remove("bi-caret-up-fill");
    arrow.classList.add("bi-caret-down-fill");
  });

  if (dropdown.style.display === "none") {
    dropdown.style.display = "flex";
    arrow.classList.remove("bi-caret-down-fill");
    arrow.classList.add("bi-caret-up-fill");
  } else {
    dropdown.style.display = "none";
    arrow.classList.remove("bi-caret-up-fill");
    arrow.classList.add("bi-caret-down-fill");
  }
}

document.addEventListener("click", function(event) {
  var dropdowns = document.querySelectorAll(".dropdown-content");
  dropdowns.forEach(function(dropdown) {
    dropdown.style.display = "none";
  });

  var arrows = document.querySelectorAll(".bi");
  arrows.forEach(function(arrow) {
    arrow.classList.remove("bi-caret-up-fill");
    arrow.classList.add("bi-caret-down-fill");
  });
});

function submitFormWithCategory(category) {
  var form = document.getElementById('filter_form');
  let selected = document.getElementById("selected");
  let showAll = document.getElementById("show-all").innerHTML;

  form.category.value = category;

  if (category === 'Category') {
    selected.textContent = showAll
  } else {
    selected.innerHTML = category ? category.replace(/_/g, ' ').charAt(0).toUpperCase() + category.slice(1) : "Category";
  }
}

function submitFormWithVegetarian(isVegetarian, text) {
  var form = document.getElementById('filter_form');
  let vegetarian = document.getElementById("vegetarian");
  form.vegetarian.value = isVegetarian;
  vegetarian.innerHTML = text;
}


function applyFilters(){
  var form = document.getElementById('filter_form');
  form.submit();
  
}
