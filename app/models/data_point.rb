class DataPoint < ActiveRecord::Base
  belongs_to :box

  before_save :convert_boolean_value_to_float

  def self.humidity
    where data_type: 'humidity'
  end

  def self.temperature
    where data_type: 'temperature'
  end

  def self.weight
    where data_type: 'weight'
  end

  private

    def convert_boolean_value_to_float
      self.value = 0.0 if ['false', ''].include?(self.value)
      self.value = 100.0 if self.value == 'true'
    end
end
