$(document).ready(function() {
  var apiBase = 'http://localhost:3000'
  //var apiBase = 'http://csbbcpeople.herokuapp.com'

  var showRelated = function(id) {
      // get related people for this article
      $.ajax({
        url: apiBase + '/articles/' + id + '/related'
      }).done(function(data){
        $('.layout-block-b').prepend(data);
      });
  }

  var routes = [
    new RegExp('http:\/\/www.bbc.co.uk\/news\/.*-([0-9]+)'),
    new RegExp('http:\/\/www.bbc.co.uk\/sport\/0\/.*\/([0-9]+)')
  ];

  var Router = {
    route: function(url, handler) {
      for(var i=0;i<routes.length;i++) {
        if(routes[i].test(url)){
          var match = url.match(routes[i]);
          handler(match[1]);
          break;
        }
      }
    }
  };

  Router.route(document.location.href, showRelated);
});
