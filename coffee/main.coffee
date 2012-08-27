jQuery ->
  initialize()
  # Load each section of the page asynchronously
  populateBlog()
  #populateGithub()
  populateTwitter()
  #populateLastfm()
  populateYelp()
  #populateFlickr()

initialize = () ->
  # Create container on window object for template caching.
  window.templateCache = {}

populateTWSRV = (section) ->
  $.ajax(url: ['http://tw-srv.herokuapp.com/', section].join('')).done(
    (sectionData) ->
      sectionID = ['#', section].join('')
      renderedTemplate = Milk.render(getTemplate(section), sectionData)
      $(sectionID).html(renderedTemplate)
  )

populateBlog = () ->
  populateTWSRV('blog')

populateTwitter = () ->
  populateTWSRV('twitter')

populateYelp = () ->
  populateTWSRV('yelp')

getTemplate = (templateName) ->
  if window.templateCache[templateName] is undefined
    $.ajax(url: ['/templates', '/', templateName, '.mustache'].join(''), async: false).done(
      (tmplResponse) ->
        window.templateCache[templateName] = tmplResponse
    )
  window.templateCache[templateName]
