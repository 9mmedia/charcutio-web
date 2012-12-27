class Team < ActiveRecord::Base
  has_many :boxes
  has_many :meats
  has_many :users,
    through: :teammates
end
