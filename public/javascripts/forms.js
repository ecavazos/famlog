var Famlog = Famlog || {};

Famlog.forms = {
  init: function () {
    $('#s_date').datepicker();
    $('#e_date').datepicker();
  }
};

$(function () {
  Famlog.forms.init();
});
