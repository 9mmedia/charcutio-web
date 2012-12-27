class Box < ActiveRecord::Base
  belongs_to :team
  belongs_to :user
  has_many :meats
  has_many :data_points
  belongs_to :master_meat,
    class_name: Meat

  def name_hashtag
    " ##{name}" if name.present?
  end

  def tweet(message, image_file=nil)
    TWITTER_CLIENT.tweet "#{message} #meat#{name_hashtag}", image_file
  end
end

