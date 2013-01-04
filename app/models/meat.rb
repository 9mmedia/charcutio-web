class Meat < ActiveRecord::Base
  belongs_to :box
  belongs_to :team
  belongs_to :user
  belongs_to :recipe

  validates :goal_weight,
    presence: true

  before_validation :set_goal_weight
  before_save :update_team

  def cancel
    !start
  end

  def cancel=(value)
    remove_timeline if ["1", 'true', 1, true].include?(value)
  end

  def check_if_completed
    if reached_goal_weight? || reached_end_date?
      UserMailer.completed_meat_email(self, team).deliver
    elsif fermenting_period_over?
      UserMailer.fermenting_completed_email(self, team).deliver
    elsif curing_period_over?
      UserMailer.curing_completed_email(self, team).deliver
    end
  end

  def current_humidity_needed
    current_water_percentage - 5 if current_weight
  end

  def current_water_percentage
    current_water_weight/current_weight if current_weight
  end

  def current_weight
    @current_weight ||= box.current_weight if box
  end

  def get_set_points
    if in_fermenting_period?
      {temperature: fermentation_temperature, humidity: fermentation_humidity}
    elsif master_meat? && current_weight.present?
      {temperature: default_drying_temperature, humidity: current_humidity_needed}
    else
      {temperature: default_drying_temperature, humidity: default_drying_humidity}
    end
  end

  def master_meat?
    box && (self.id == box.master_meat_id)
  end

  def name
    if read_attribute(:name).present?
      read_attribute :name
    else
      'Unnamed'
    end
  end

  def start
    start_date.present?
  end

  def start=(value)
    set_timeline if ["1", 'true', 1, true].include?(value)
  end

  private

    def curing_period_over?
      Time.current >= (start_date + recipe.expected_curing_time.days)
    end

    def current_water_weight
      initial_water_weight - weight_change
    end

    def fermenting_period_over?
      fermented && Time.current >= fermenting_start_date
    end

    def in_fermenting_period?
      fermented && curing_period_over? && !fermenting_period_over?
    end

    def initial_water_weight
      initial_weight * (recipe.initial_water_percentage/100.0)
    end

    def reached_end_date?
      Time.current >= end_date
    end

    def reached_goal_weight?
     current_weight && current_weight.round <= goal_weight
    end

    def remove_timeline
      update_attributes start_date: nil, fermenting_start_date: nil, drying_start_date: nil, end_date: nil
    end

    def set_goal_weight
      self.goal_weight = (initial_weight - total_weight_loss_needed).round
    end

    def set_timeline
      self.start_date = Time.current
      self.fermenting_start_date = start_date + recipe.expected_curing_time.days
      self.drying_start_date = fermenting_start_date + (recipe.expected_fermenting_time || 0).days
      self.end_date = drying_start_date + recipe.expected_drying_time.days
      save!
    end

    def total_weight_loss_needed
      initial_water_weight/3.0
    end

    def update_team
      self.team = box.team if box.present?
    end

    def weight_change
      initial_weight - current_weight
    end
end
