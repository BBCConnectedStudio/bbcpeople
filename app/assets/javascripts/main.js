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
        $('.data').removeClass('show');
        $('.data').removeClass('hide');
        $('.source-legend').hide();
        break;
      case 'source':
        $('.data').addClass('show');
        $('.data').removeClass('hide');
        $('.source-legend').show();
        break;
      case 'hidden':
//        $('.data').removeClass('show');
        $('.data').addClass('hide show');
        $('.source-legend').hide();
        break;
    }

  });


  $('a[rel="popover"]').popover().click(function(e) {
            e.preventDefault();
  });

});
