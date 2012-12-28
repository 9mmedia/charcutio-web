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

  def self.check_if_meats_completed
    active.each { |box| box.check_meat_statuses }
  end

  def check_dead_mans_switch
    @last_update_time = data_points.order('created_at desc').first.created_at
    pull_dead_mans_switch if @last_update_time >= 2.hours.ago
  end

  def check_meat_statuses
    meats.each { |meat| meat.check_if_completed if meat.start_date }
  end

  def current_weight
    data_points.weight.order('created_at desc').first.value
  end

  def get_set_points
    (master_meat || meats.first).get_set_points
  end

  def pull_dead_mans_switch
    UserMailer.meat_down_email(self, team, @last_update_time).deliver
  end

  def name_hashtag
    " ##{name}" if name.present?
  end

  def tweet(message, image_file=nil)
    TWITTER_CLIENT.tweet "#{message} #meat#{name_hashtag}", image_file
  end
end

