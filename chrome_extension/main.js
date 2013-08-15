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

  var Router = function Router(routes) {
    this.route = function(url, handler) {
      for(var i=0;i<routes.length;i++) {
        var pattern = routes[i].pattern;
        if(pattern.test(url)){
          var matches = url.match(pattern);
          matches.shift(); // remove the first match
          routes[i].handler.apply(this, matches);
          break;
        }
      }
    }
  };

  var routes = [
    {
      pattern: new RegExp('http:\/\/www.bbc.co.uk\/news\/.*-([0-9]+)'),
      handler: showRelated
    },
    {
      pattern: new RegExp('http:\/\/www.bbc.co.uk\/sport\/0\/.*\/([0-9]+)'),
      handler: showRelated
    },
    {
      pattern: new RegExp('http:\/\/www.bbc.co.uk\/programmes\/([a-zA-Z0-9]+)'),
      handler: showRelated
    }
  ];

  var router = new Router(routes)
  router.route(document.location.href);
});