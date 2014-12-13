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
        if($(this).hasClass('pop')){
          $('.filter-sport').removeClass('active');
        }
        else{
          $('#pop').removeClass('active');
        }
        $(this).addClass('active');
      }
    });

    $('#page-event').css('background-image', 'url(/uploads/'+$('#page-event').data('sport')+')');

    $('#sidebar-user').css( "width", function( index ) {
      return (($('body').width()-1000)/2+200);
    });

    $('.author').on('click', function(){
      $('#sidebar-user').addClass('active');
      $.ajax({
          type: 'POST',
          url: "/user/1",
          beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
          data: { "id": '1' },
          success: function( data ){
            $('#sidebar-user-title').text(data.firstname+' '+data.lastname);
            $('#sidebar-user-img').attr("src", '/uploads/'+data.picture);
          }
      });
    });

    $('#sidebar-close').on('click', function(){
      $('#sidebar-user').removeClass('active');
    });

    $('#event-like').on('click', function(e){
      var $this = $(this);
      e.preventDefault();
      if($(this).hasClass('active')){
        $.ajax({
            type: 'POST',
            url: "/actions/unlike",
            beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
            data: { "id": $('#page-event').data('event') },
            success: function( data ){
              $this.removeClass('active');
              $this.text('Like');
              var count = parseInt($('#event-count').text());
              $('#event-count').text(count - 1);
            }
        });
      }
      else{
        $.ajax({
            type: 'POST',
            url: "/actions/like",
            beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
            data: { "id": $('#page-event').data('event') },
            success: function( data ){
              $this.addClass('active');
              $this.text('Unlike');
              var count = parseInt($('#event-count').text());
              $('#event-count').text(count + 1);
            }
        });

      }
    })
});