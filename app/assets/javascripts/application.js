//= require jquery
//= require bootstrap-sprockets
$(document).ready(function() {
  $('.has-tooltip').tooltip();

  $('.event-border').each(function(){
    $(this).css('borderTop', '4px solid '+$(this).data('color'));
  });

   $('.sport-border').each(function(){
    $(this).css('borderTop', '4px solid '+$(this).data('color'));
  });

   $(".sport-selection").mouseover(function () {
      $(this).find('img').css('opacity', '0.7');
    }).mouseout(function() {
      $(this).find('img').css('opacity', '0');
    });

    $('.filter-sport').on('click', function(){
      if($(this).hasClass('active')){
        $(this).removeClass('active');
      }
      else{
        $(this).addClass('active');
      }
    });

    $('#page-event').css('background-image', 'url(/uploads/'+$('#event').data('sport')+')');
});