class Vector < Point
  def initialize(x, y, z)
    super
    raise "Vector segments are between -1 are 1" unless [@x, @y, @z].all? {|value| value <= 1 && value >= -1}
  end
end

class Angle < Point
end

