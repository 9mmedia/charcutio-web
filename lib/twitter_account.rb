require 'meat_markov'

class TwitterAccount
  MESSAGES = %w(#pigpigpig #MEAT! #sohungry #whencanweeat #omnomnom #KeepYourEyeOnTheMeat #MeatBusted #SomeoneBeStealingOurMeat)

  def self.message_with_data(name_hashtag, data, remaining_days)
    "temperature: #{data[:temperature]}\xC2\xB0 C, humidity: #{data[:humidity]}%, days until meat: #{remaining_days} #{name_hashtag}"
  end

  def self.random_message(name_hashtag)
    "#{MeatMarkov.random_text(105)} #{name_hashtag}"
  end

  def self.tweet(args={name_hashtag: nil, image_file: nil, data: nil, remaining_days: nil})
    # 21 characters for the image url
    # 12 characters for the cropped name hashtag
    # plus 2 spaces = 33 characters already used up
    message = message_with_data args[:name_hashtag][0..11], args[:data], args[:remaining_days]
    Timeout::timeout(5) do
      if args[:image_file]
        tweet_with_image(message, args[:image_file])
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
