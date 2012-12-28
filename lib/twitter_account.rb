require 'singleton'

class TwitterAccount
  include Singleton

  def tweet(message, image_file=nil)
    Timeout::timeout(5) do
      if image_file
        tweet_with_image(message, image_file)
      else
        tweet_without_image(message)
      end
    end rescue return nil
  end

  private

    def client
      OAuth::AccessToken.from_hash consumer, oauth_token: ENV['TWITTER_CLIENT_KEY'], oauth_token_secret: ENV['TWITTER_CLIENT_SECRET']
    end

    def consumer
      OAuth::Consumer.new ENV['TWITTER_APP_KEY'], ENV['TWITTER_APP_SECRET'], site: "http://api.twitter.com"
    end

    def tweet_with_image(message, image_file)
      client.post 'https://api.twitter.com/1.1/statuses/update_with_media.json',
                  {'status' => message, 'media' => image_file},
                  {'Content-Type' => 'multipart/form-data'}
    end

    def tweet_without_image(message)
      client.post 'https://api.twitter.com/1.1/statuses/update.json',
                  {'status' => message},
                  {'Accept' => 'application/xml'}
    end
end
