class Box < ActiveRecord::Base
  belongs_to :team
  belongs_to :user
  has_many :meats
  has_many :data_points
  belongs_to :master_meat,
    class_name: Meat

  def tweet(message, image_url)
    Timeout::timeout(5) do
      @response = TWITTER_CLIENT.post 'https://api.twitter.com/1.1/statuses/update.json',
                                      {'status' => "#{message} #meat#{name_hashtag}"},
                                      {'Accept' => 'application/xml'}
    end rescue return nil
    return tweet_successful?
  end

  private

    def name_hashtag
      " ##{name}" if name.present?
    end

    def tweet_successful?
      @response ? @response.code.to_i == 200 : nil
    end
end
