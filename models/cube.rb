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

  def initialize(size, position, rotation = Vector.new(0, 0, 0))
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
    points.map do |point|
      # translate using current position
      Point.new point.x + @position.x, point.y + @position.y, point.z + @position.z

      # TODO: Rotation
    end
  end

  def world_edges
    edges.map do |edge|
      Edge.new Point.new(edge.a.x + @position.x, edge.a.y + @position.y, edge.a.z + @position.z),
               Point.new(edge.b.x + @position.x, edge.b.y + @position.y, edge.b.z + @position.z)
    end
  end
end