//= require rails-ujs
//= require jquery
//= require toastr.min

$(document).ready(function() {
  var notice = $('.notice').data('notice');
  var alert = $('.alert').data('alert');

  toastr.options = {
    positionClass: 'toast-top-left',
  };
  
  if (notice) {
    toastr.success(notice);
  } else if (alert) {
    toastr.error(alert);
  }

});
