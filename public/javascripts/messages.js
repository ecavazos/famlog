var Famlog = Famlog || {};

Famlog.messages = {
  init: function () {
    var selector  = "#messages li",
        className = ".action";

    $(selector)
    .bind("mouseover", function () {
      $(this).children(className).css({
        display: "block"
      });
    })
    .bind("mouseout", function () {
      $(this).children(className).css({
        display: "none"
      });
    });
  }
};
