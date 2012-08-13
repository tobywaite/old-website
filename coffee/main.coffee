jQuery ->
  initialize()
  # Load each section of the page asynchronously
  populateBlog()
  populateGithub()
  populateTwitter()
  populateLastfm()
  populateYelp()
  populateFlickr()

initialize ->
  # Create container on window object for templates.
  this.templates = {}

populateTWSRV = (section) ->
  $.ajax(url: 'http://tw-srv.herokuapp.com/#{ section }').done(
    (response) ->
      $('##{ section }').html(Milk.render(this.templates[section], response))
  )

populateBlog ->
  populateTWSRV('blog')

populateTwitter ->
  populateTWSRV('twitter')

populateBlog ->
  populateTWSRV('yelp')
