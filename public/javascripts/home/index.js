$(function () {
  var app = app || {};

  var Message = app.Message = function () {
    $("#messages li")
    .bind("mouseover", function () {
      $(this).children(".action").css({
        display: "block"
      });
    })
    .bind("mouseout", function () {
      $(this).children(".action").css({
        display: "none"
      });
    });
  };

  new app.Message();

});


