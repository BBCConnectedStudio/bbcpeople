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

});
