$(document).ready(function() {

  if( ! $('#tag-cloud').tagcanvas({
    textColour : '#000000',
    outlineThickness : 1,
    maxSpeed : 0.03,
    depth : 0.75,
    initial: [0.3,-0.3]
  })) {
    // TagCanvas failed to load
    $('#tag-container').hide();
  }

  // select normal radio button by default
  $('input[value=normal]').attr('checked', 'checked');

  $('.source-legend').hide();
  $('input[name=mode]').on('change', function() {
    var action = $('input[name=mode]:checked').val();
    switch (action) {
      case 'normal':
        $('.data').removeClass('show hide');
        $('.source-legend').hide();
        break;
      case 'source':
        $('.data').addClass('show');
        $('.data').removeClass('hide');
        $('.source-legend').show();
        break;
      case 'hidden':
        $('.data').addClass('hide show');
        $('.source-legend').hide();
        break;
    }

  });


  $('a[rel="popover"]').popover().click(function(e) {
            e.preventDefault();
  });

  // following
  $(document).on('click', '.follow', function() {
    var dbpediaKey = $(this).attr('data-dbpedia-key');
    if ($(this).text() == 'Follow') {
      var action = 'follow';
    } else {
      var action = 'unfollow';
    }
    var that = this;
    $.ajax({
      url: '/profiles/'+dbpediaKey+'/'+action,
      type: 'post',
    }).done(function(response) {
      if(response == 'set following') {
        $(that).removeClass('btn-success').addClass('btn-info').text('Following');
      } else if(response == 'set follow') {
        $(that).removeClass('btn-info').addClass('btn-success').text('Follow');
      }
    });
  });
  $(document).on('mouseenter', '.follow', function() {
    if($(this).text() == 'Following') {
      $(this).removeClass('btn-info').addClass('btn-danger').text('Unfollow');
    }
  });
  $(document).on('mouseleave', '.follow', function() {
    if($(this).text() == 'Unfollow') {
      $(this).removeClass('btn-danger').addClass('btn-info').text('Following');
    }
  });



});
