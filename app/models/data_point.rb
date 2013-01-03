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

  def value=(val)
    # Overwritten so we can first convert boolean values to floats
    val = 0.0 if ['false', ''].include?(val)
    val = 100.0 if val == 'true'
    write_attribute :value, val
  end
end
