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
      Twitter::Client.new(
        :consumer_key => ENV['TWITTER_APP_KEY'],
        :consumer_secret => ENV['TWITTER_APP_SECRET'],
        :oauth_token => ENV['TWITTER_CLIENT_KEY'],
        :oauth_token_secret => ENV['TWITTER_CLIENT_SECRET'])
    end

    def tweet_with_image(message, image_file)
      client.update_with_media message, image_file
    end

    def tweet_without_image(message)
      client.update message
    end
end
