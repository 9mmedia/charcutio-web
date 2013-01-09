class Team < ActiveRecord::Base
  has_many :boxes
  has_many :meats
  has_many :teammates,
    dependent: :destroy
  has_many :users,
    through: :teammates

  def self.find_or_create(params)
    find(params[:id]) || create!(name: params[:name])
  end
end
