$(document).ready(function() {
  $(".clickable").on("click", function() {
    var orderId = $(this).data("order-id");
    $(".product-list[data-order-id='" + orderId + "']").toggle();
  });
});
