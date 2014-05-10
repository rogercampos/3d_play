class Point
  attr_accessor :x, :y, :z

  def initialize(x, y, z)
    @x, @y, @z = x.to_f, y.to_f, z.to_f
  end
end