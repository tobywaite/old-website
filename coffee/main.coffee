jQuery ->
  # Load and render each section of the page asynchronously
  #blog = new FeedModule('blog').render()
  #flickr = new FlickrModule().render()
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
        @context = @formatResponse(response)
    )

  loadTemplate: =>
    $.ajax(url: ['/templates', '/', @name, '.mustache'].join(''), async: false).done(
      (response) =>
        @template = response
    )

  formatResponse: (response) ->
    """When loading the context, reformat the response data to the appropriate
    context format. This should probably be overridden by extending classes.
    """
    response


class GithubModule extends FeedModule
  constructor: ->
    super 'github'
    @source = 'https://api.github.com/users/tobywaite/repos'

  formatResponse: (response) ->
    # response from github is a list of repos

    format = (repo) ->

      #format datestrings
      formatDate = (datestring) ->
        datestring[0..9]
      formatTime = (datestring) ->
        datestring[11..18]

      {
        repoUrl: repo.html_url
        repoName: repo.name
        repoDesc: repo.description
        commitMessage: "no commit data"
        commitDate: formatDate repo.updated_at
        commitTime: formatTime repo.updated_at
      }

    repos = (format repo for repo in response)
    repos[0]


class LastFMModule extends FeedModule
  constructor: ->
    super 'lastfm'
    @source = 'http://ws.audioscrobbler.com/2.0/?method=user.getrecenttracks&user=thebrokenfish&api_key=b25b959554ed76058ac220b7b2e0a026&format=json'

  formatResponse: (response) ->
    #response is a list of recently played tracks

    format = (track) ->
      {
        nowPlaying: track['@attr']?.nowplaying
        song: track.name
        artist: track.artist.name
        album: track.album['#text']
        artUrl: track.image[1]['#text']
      }

    tracks = (format track for track in response.recenttracks.track)
    tracks[0]

class FlickrModule extends FeedModule
  constructor: ->
    super 'flickr'
    @source = 'http://api.flickr.com/services/rest/?method=flickr.activity.userPhotos&format=json'
