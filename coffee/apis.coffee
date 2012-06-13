getTweets = (userName = "tobywaite", count = 5, max = "") ->
  if max != ''
    tweets = $.get('https://twitter.com/status/user_timeline/' + userName + '.json')
  else
    tweets = $.get(
      'https://twitter.com/status/user_timeline/' + userName + '.json',
      {max_id: max}
    )

getTweets()
