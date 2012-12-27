class Meat < ActiveRecord::Base
  belongs_to :box
  belongs_to :team
  belongs_to :user
  belongs_to :recipe

  validates :goal_weight,
    presence: true

  before_validation :set_goal_weight,
    if: :recipe_id_changed?

  def set_goal_weight
    self.goal_weight = initial_weight - total_weight_loss_needed
  end

  def current_water_percentage(current_weight)
    @current_weight = current_weight.to_f
    current_water_weight/@current_weight
  end

  private

    def current_water_weight
      initial_water_weight - weight_change
    end

    def initial_water_weight
      initial_weight * recipe.initial_water_percentage
    end

    def total_weight_loss_needed
      initial_water_weight/3.0
    end

    def weight_change
      initial_weight - @current_weight
    end
end
