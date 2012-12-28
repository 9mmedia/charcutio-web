class DataPoint < ActiveRecord::Base
  belongs_to :box

  def self.humidity
    where data_type: 'humidity'
  end

  def self.temperature
    where data_type: 'temperature'
  end

  def self.weight
    where data_type: 'weight'
  end
end
