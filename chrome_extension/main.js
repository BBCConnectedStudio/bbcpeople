$(document).ready(function() {
  //var apiBase = 'http://localhost:3000'
  var apiBase = 'http://csbbcpeople.herokuapp.com'

  var showRelated = function(id) {
      // get related people for this article
      $.ajax({
        url: apiBase + '/articles/' + id + '/related'
      }).done(function(data){
        $('.layout-block-b').prepend(data);
      });
  }

  var newsPattern = new RegExp('http:\/\/www.bbc.co.uk\/news\/.*-([0-9]+)');
  var match = document.location.href.match(newsPattern);
  // if we are on a news page
  if (newsPattern.test(document.location.href)) {
    showRelated(match[1]);
  }
  var sportPattern = new RegExp('http:\/\/www.bbc.co.uk\/sport\/0\/.*\/([0-9]+)');
  var match = document.location.href.match(sportPattern);
  // if we are on a sports page
  if (sportPattern.test(document.location.href)) {
    showRelated(match[1])
  }
});
