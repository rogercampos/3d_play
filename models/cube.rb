class Cube
  attr_reader :points
  attr_accessor :position
  attr_accessor :rotation

  def initialize(size, position, rotation = Vector.new(0, 0, 0))
    @points = []
    @position = position
    @rotation = rotation

    [-size, size].each do |x|
      [-size, size].each do |y|
        [-size, size].each do |z|
          @points << Point.new(x, y, z)
        end
      end
    end
  end

  def world_points
    points.map do |point|
      # translate using current position
      Point.new point.x + @position.x, point.y + @position.y, point.z + @position.z

      # TODO: Rotation
    end
  end
end