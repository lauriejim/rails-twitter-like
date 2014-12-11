//= require jquery
//= require bootstrap-sprockets
$(document).ready(function() {
  $('.has-tooltip').tooltip();

  $('.event-border').each(function(){
    $(this).css('borderTop', '4px solid '+$(this).data('color'));
  });
});