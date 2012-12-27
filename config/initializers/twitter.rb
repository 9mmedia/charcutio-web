twitter_consumer = OAuth::Consumer.new ENV['TWITTER_APP_KEY'], ENV['TWITTER_APP_SECRET'], site: "http://api.twitter.com"
TWITTER_CLIENT = OAuth::AccessToken.from_hash twitter_consumer, oauth_token: ENV['TWITTER_CLIENT_KEY'], oauth_token_secret: ENV['TWITTER_CLIENT_SECRET']
