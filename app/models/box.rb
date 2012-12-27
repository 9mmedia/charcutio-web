class Box < ActiveRecord::Base
  belongs_to :team
  belongs_to :user
  has_many :meats
  has_many :data_points
  belongs_to :master_meat,
    class_name: Meat

  def self.active
    where active: true
  end

  def self.check_dead_mans_switches
    active.each { |box| box.check_dead_mans_switch }
  end

  def check_dead_mans_switch
    pull_dead_mans_switch if data_points.order('created_at desc').first.created_at >= 2.hours.ago
  end

  def pull_dead_mans_switch
    # update the team? or just the user? twilio or email?
  end

  def name_hashtag
    " ##{name}" if name.present?
  end

  def tweet(message, image_file=nil)
    TWITTER_CLIENT.tweet "#{message} #meat#{name_hashtag}", image_file
  end
end

