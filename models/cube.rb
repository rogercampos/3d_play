class Edge
  attr_accessor :a, :b

  def initialize(a, b)
    @a, @b = a, b
  end
end

class Cube
  attr_reader :points
  attr_accessor :position
  attr_accessor :rotation
  attr_reader :edges

  def initialize(size, position, rotation = Angle.new(0, 0, 0))
    @points = []
    @position = position
    @rotation = rotation
    @edges = []

    d1 = Point.new -size, -size, -size
    d2 = Point.new -size, -size, size
    d3 = Point.new size, -size, size
    d4 = Point.new size, -size, -size

    u1 = Point.new -size, size, -size
    u2 = Point.new -size, size, size
    u3 = Point.new size, size, size
    u4 = Point.new size, size, -size

    @points += [d1, d2, d3, d4, u1, u2, u3, u4]

    @edges << Edge.new(d1, d2)
    @edges << Edge.new(d2, d3)
    @edges << Edge.new(d3, d4)
    @edges << Edge.new(d4, d1)

    @edges << Edge.new(u1, u2)
    @edges << Edge.new(u2, u3)
    @edges << Edge.new(u3, u4)
    @edges << Edge.new(u4, u1)

    @edges << Edge.new(d1, u1)
    @edges << Edge.new(d2, u2)
    @edges << Edge.new(d3, u3)
    @edges << Edge.new(d4, u4)
  end

  def world_points
    points.map { |point| transform(point) }
  end

  def world_edges
    edges.map { |edge| Edge.new(transform(edge.a), transform(edge.b)) }
  end

  private

  def transform(point)
    x = point.x
    y = point.y
    z = point.z

    # rotation over Y
    x = point.x * Math.cos(@rotation.y) - point.z * Math.sin(@rotation.y)
    z = point.x * Math.sin(@rotation.y) + point.z * Math.cos(@rotation.y)

    # translation
    Point.new(x + @position.x, y + @position.y, z + @position.z)
  end
end