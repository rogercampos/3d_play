class Camera
  attr_accessor :position, :orientation

  def initialize(position, orientation)
    @position = position
    @orientation = orientation
  end

  def transform(point)
    # translate with camera position
    Point.new point.x - @position.x, point.y - @position.y, point.z - @position.z

    # TODO: Rotation
  end
end

