var Famlog = Famlog || {};

(function () {

  var tabs = Famlog.tabs = {

    init: function() {
      tabs.makeLinks();
      tabs.all().live("click", tabs.click);
    },

    all: function () {
      return $("#tabs li");
    },

    makeLinks: function () {
      tabs.all().not(".active")
        .wrapInner("<a href='' />")
    },

    click: function(event) {
      event.preventDefault();
      var link = $(this),
          html = tabs.pages[link.attr("id")],
          text = link.text().trim();

      tabs.all().removeClass("active");
      link.addClass("active");
      console.log(text);
      link.text(text);
      tabs.makeLinks();

      $("#main").text(html);
    },

    pages: {
      home: "this will contain the most recent messages",
      today: "events for the day will be shown first followed by messages created today",
      week: "all events for the next five days",
      history: "all past events and messages ordered by date"
    }
  };

})();
