var Famlog = Famlog || {};

(function () {

  var tabs = Famlog.tabs = {

    init: function () {
      tabs.makeLinks();
      tabs.all().live("click", tabs.click);
      tabs.initAjaxError();
      tabs.initAjaxStart();
    },

    initAjaxError: function () {
      $('body').ajaxError(function (event, xhr, ajaxOptions, thrownError) {
        $('#error').remove();
        $('body').prepend('<div id="error"></div>');
        $('#error').text(xhr.responseText)
          .fadeOut(4000, function () {
            $('#error').remove();
          });
      });
    },

    initAjaxStart: function () {
      $('body').ajaxStart(function () {
        tabs.load();
      });
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

    load: function () {
      $('#main')
        .html('<div id="loader">Loading ...</div>');
    },
  };

})();
