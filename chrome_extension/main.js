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

  var showRelatedProgrammes = function(pid) {
    // get tagged programmes for this programme
    $.ajax({
      url: apiBase + '/programmes/' + pid + '/related'
    }).done(function(data){
      $('#content .col-a').prepend(data);
    });
  }

  var showRelatedIplayerProgrammes = function(pid) {
    // get tagged programmes for this programme
    $.ajax({
      url: apiBase + '/programmes/' + pid + '/related'
    }).done(function(data){
      $('#related-links').prepend(data);
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
      pattern: new RegExp('http:\/\/www.bbc.co.uk\/programmes\/([a-z]{1}[0-9]{1}[a-zA-Z0-9]+)$'),
      handler: showRelatedProgrammes
    },
    {
      pattern: new RegExp('http:\/\/www.bbc.co.uk\/iplayer\/episode\/([a-z]{1}[0-9]{1}[a-zA-Z0-9]+)\/.*\/'),
      handler: showRelatedIplayerProgrammes
    }
 
  ];

  var router = new Router(routes)
  router.route(document.location.href);
});
