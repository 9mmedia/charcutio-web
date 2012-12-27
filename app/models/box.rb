class Box < ActiveRecord::Base
  belongs_to :team
  has_many :meats
end
