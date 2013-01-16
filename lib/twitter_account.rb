require 'meat_markov'

class TwitterAccount
  MESSAGES = %w(#pigpigpig #MEAT! #sohungry #whencanweeat #omnomnom #KeepYourEyeOnTheMeat #MeatBusted #SomeoneBeStealingOurMeat)

  def self.random_message(name_hashtag)
    # 21 characters for the image url
    # 10 characters for the cropped name hashtag
    # plus 2 spaces = 33 characters already used up
    "#{MeatMarkov.random_tweet_text(107)} #{name_hashtag[0..9]}"
  end

  def self.tweet(name_hashtag, image_file=nil)
    message = random_message(name_hashtag)
    Timeout::timeout(5) do
      if image_file
        tweet_with_image(message, image_file)
      else
        tweet_without_image(message)
      end
    end rescue nil
  end

  private

    def self.client
      Twitter::Client.new(
        :consumer_key => ENV['TWITTER_APP_KEY'],
        :consumer_secret => ENV['TWITTER_APP_SECRET'],
        :oauth_token => ENV['TWITTER_CLIENT_KEY'],
        :oauth_token_secret => ENV['TWITTER_CLIENT_SECRET'])
    end

    def self.tweet_with_image(message, image_file)
      client.update_with_media message, image_file
    end

    def self.tweet_without_image(message)
      client.update message
    end
end
