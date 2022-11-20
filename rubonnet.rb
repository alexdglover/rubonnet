require 'YAML'

class Rubonnet
  attr_reader :value

  def initialize
    @value = {}
  end

  def to_yaml
    YAML.dump(value)
  end
end

