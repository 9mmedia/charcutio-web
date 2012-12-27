class Meat < ActiveRecord::Base
  belongs_to :box
  belongs_to :team
  belongs_to :user
  belongs_to :recipe
end
