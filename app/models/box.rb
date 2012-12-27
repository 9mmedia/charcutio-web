class Box < ActiveRecord::Base
  belongs_to :team
  belongs_to :user
  has_many :meats
  has_many :data_points
  belongs_to :master_meat,
    class_name: Meat
end
