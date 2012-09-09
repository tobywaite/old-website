jQuery ->
  # Load and render each section of the page asynchronously
  blog = new FeedModule('blog').render()
  flickr = new FlickrModule().render()
  github = new GithubModule().render()
  lastfm = new LastFMModule().render()
  twitter = new FeedModule('twitter').render()
  yelp = new FeedModule('yelp').render()

class FeedModule
  constructor: (@name) ->
    @source = ['http://tw-srv.herokuapp.com/', @name].join('')
    @domElement = $('#'+@name)

  render: ->
    if @context is undefined
      @loadContext()
    if @template is undefined
      @loadTemplate()
    @domElement.html(Milk.render(@template, @context))

  loadContext: =>
    # load a new context from the source.
    $.ajax(url: @source, async: false).done(
      (response) =>
        @context = response
    )

  loadTemplate: =>
    $.ajax(url: ['/templates', '/', @name, '.mustache'].join(''), async: false).done(
      (response) =>
        @template = response
    )

class GithubModule extends FeedModule
  constructor: ->
    super 'github'
    @source = 'https://api.github.com/users/tobywaite/repos'

class LastFMModule extends FeedModule
  constructor: ->
    super 'lastfm'
    @source = 'http://ws.audioscrobbler.com/2.0/?method=user.getrecenttracks&user=thebrokenfish&api_key=b25b959554ed76058ac220b7b2e0a026&format=json'

class FlickrModule extends FeedModule
  constructor: ->
    super 'flickr'
    @source = 'http://api.flickr.com/services/rest/?method=flickr.activity.userPhotos&format=json'
