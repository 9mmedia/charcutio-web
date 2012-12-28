class Meat < ActiveRecord::Base
  belongs_to :box
  belongs_to :team
  belongs_to :user
  belongs_to :recipe

  validates :goal_weight,
    presence: true

  before_validation :set_goal_weight,
    if: :recipe_id_changed?

  def check_if_completed
    send_completed_meat_alert if reached_goal_weight?
  end

  def current_water_percentage(current_weight)
    @current_weight = current_weight.to_f
    current_water_weight/@current_weight
  end

  def set_goal_weight
    self.goal_weight = (initial_weight - total_weight_loss_needed).round
  end

  def start=(value)
    set_timeline if ["1", 1, true].include?(value)
  end

  private

    def current_water_weight
      initial_water_weight - weight_change
    end

    def initial_water_weight
      initial_weight * recipe.initial_water_percentage
    end

    def reached_goal_weight?
      @current_weight.round <= goal_weight
    end

    def send_completed_meat_alert
      UserMailer.completed_meat_email(self, team).deliver
    end

    def set_timeline
      self.start_date = Time.current
      if recipe.fermented
        self.fermenting_start_date = start_date + recipe.expected_curing_time
        self.drying_start_date = fermenting_start_date + recipe.expected_fermenting_time
      else
        self.drying_start_date = start_date + recipe.expected_curing_time
      end
      self.end_date = drying_start_date + recipe.expected_drying_time
      save!
    end

    def total_weight_loss_needed
      initial_water_weight/3.0
    end

    def weight_change
      initial_weight - @current_weight
    end
end
