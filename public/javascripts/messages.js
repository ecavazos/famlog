var Famlog = Famlog || {};

Famlog.messages = {
  init: function () {
    var selector  = "#messages li",
        className = ".action";

    $(selector)
      .live("mouseover", function () {
        $(this).children(className).css({
          display: "block"
        });
      })
      .live("mouseout", function () {
        $(this).children(className).css({
          display: "none"
        });
      });
  }
};
