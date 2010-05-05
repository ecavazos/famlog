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
      var tab  = $(this),
          name = tab.attr('id'),
          html = tabs.pages[name],
          text = tab.text().trim();

      tabs.all().removeClass("active");
      tab.addClass("active");
      $.ajax({
        url: '/messages?tab=' + name,
        cache: false,
        success: function (html) {
          $("#main").html(html);
        }
      });

      tab.text(text);
      tabs.makeLinks();
    },

    pages: {
      home: "this will contain the most recent messages",
      today: "events for the day will be shown first followed by messages created today",
      forecast: "all events for the next five days",
      history: "all past events and messages ordered by date"
    }
  };

})();
