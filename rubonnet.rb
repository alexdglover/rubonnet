require 'YAML'

class Rubonnet < Hash
  def initialize(value = nil)
    if value.nil?
      self.merge!(self.class::DEFAULTS)
      return
    end
    raise ArgumentError unless [self.class, Hash].include?(value.class)
    self.merge!(value)
    unless valid(self.class::DEFAULTS, self)
      raise ArgumentError.new "Missing required keys, should match #{self.class::DEFAULTS}"
    end
    return
  end

  def valid(expected, actual)
    expected.each do |key, value|
      return false unless actual.has_key?(key)
      if value.is_a? Hash
        valid(expected[key], actual[key])
      end
      return true
    end
  end

  def to_yaml
    YAML.dump(self)
  end
end

