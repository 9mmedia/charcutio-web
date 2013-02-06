require 'twitter_account'

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

  def self.check_if_data_acceptable
    active.each { |box| box.check_recent_sensor_data }
  end

  def self.check_if_meats_completed
    active.each { |box| box.check_meat_statuses }
  end

  def check_dead_mans_switch
    latest_data_points = []
    %w(humidity humidifier dehumidifier temperature freezer).each do |data_type|
      latest_data_points << data_points.where(data_type: data_type).order('created_at desc').first
    end
    if @dead_data_point = latest_data_points.find { |data_point| data_point.created_at >= 2.hours.ago }
      pull_dead_mans_switch
    end
  end

  def check_meat_statuses
    meats.each { |meat| meat.check_if_completed if meat.start_date }
  end

  def check_recent_sensor_data
    return nil if data_points.empty?
    desired_values = get_set_points
    check_sensor_data_subset :humidity, desired_value[:humidity]
    check_sensor_data_subset :temperature, desired_value[:temperature]
  end

  def current_weight
    data_points.weight.order('created_at desc').first.value
  end

  def days_remaining_until_first_meat_done
    meats.order('end_date asc').first.days_remaining_on_timeline
  end

  def get_set_points
    (master_meat || meats.first).get_set_points
  end

  def goal_weight
    @goal_weight ||= initial_weight - initial_weight/3.0
  end

  def initial_weight
    @initial_weight ||= meats.map(&:initial_weight).inject(:+)
  end

  def name
    if read_attribute(:name).present?
      read_attribute :name
    else
      'Unnamed'
    end
  end

  def pull_dead_mans_switch
    UserMailer.meat_down_email(self, team, @dead_data_point).deliver
  end

  def name_hashtag
    name.present? ? " ##{name}" : ''
  end

  def tweet(image_file=nil)
    TwitterAccount.tweet name_hashtag: name_hashtag, image_file: image_file, data: tweet_data, remaining_days: days_remaining_until_first_meat_done
  end

  def tweet_data
    {temperature: data_points.where(data_type: 'temperature').order('created_at desc').first.try(:value),
     humidity: data_points.where(data_type: 'humidity').order('created_at desc').first.try(:value)}
  end

  def data_for(type, span)
    data = data_points.where('data_type IN (?)', [type, DataPoint::RELAY_TYPES[type.to_sym]].flatten).order("created_at DESC")
    range = 1.day.ago..Time.now
    case span
    when :six_hours
      range = 6.hours.ago..Time.now
    when :day
      range = 1.day.ago..Time.now
    when :week
      range = 1.week.ago..Time.now
    when :month
      range = 1.month.ago..Time.now
    when :three_months
      range = 3.months.ago..Time.now
    when :six_months
      range = 6.months.ago..Time.now
    end
    data = data.where(created_at: range)
  end

  private

    def check_sensor_data_subset(data_type, desired_value)
      values = data_points.send(data_type).where('created_at > ?', 1.hour.ago).map(&:value)
      average_value = values.inject(:+).to_f/values.size
      difference = (average_value - desired_value).abs
      if difference > 20
        UserMailer.sensor_alert_email(self, team, data_type, average_value, desired_value, difference).deliver
      end
    end
end

