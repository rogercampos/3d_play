class Vector < Point
  def initialize(x, y, z)
    super
    raise "Vector segments are between 0 are 1" unless [@x, @y, @z].all? {|value| value <= 1 && value >= 0}
  end
end

