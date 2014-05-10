require 'gosu'

Dir[File.join(File.dirname(__FILE__), "models/**")].each {|x| require x}

class GameWindow < Gosu::Window
  def initialize
    @screen_width = 1000
    @screen_height = 600
    super @screen_width, @screen_height, false
    self.caption = "Gosu Tutorial Game"

    @cube = Cube.new 1, Point.new(10, 0, 10)
    @camera = Camera.new Point.new(10, 0, 0), Vector.new(0, 0, 1)

    @velocity = 0.1
    @fov = 800.0
  end

  def update
    if button_down? Gosu::KbLeft
      @cube.position.x -= @velocity
    end

    if button_down? Gosu::KbRight
      @cube.position.x += @velocity
    end

    if button_down? Gosu::KbUp
      @cube.position.y += @velocity
    end

    if button_down? Gosu::KbDown
      @cube.position.y -= @velocity
    end

    if button_down? Gosu::KbA
      @cube.rotation.y += 0.1
    end

    if button_down? Gosu::KbS
      @cube.rotation.x += 0.1
    end

    if button_down? Gosu::KbD
      @cube.rotation.z += 0.1
    end
  end

  def button_down(id)
    if id == Gosu::KbEscape
      close
    end
  end

  def draw_point(x, y)
    draw_triangle x-5, y-5, Gosu::Color::WHITE, x, y, Gosu::Color::WHITE, x, y-5, Gosu::Color::WHITE
  end

  def draw
    # draw_cube_points
    draw_cube_edges
  end

  def draw_cube_edges
    @cube.world_edges.each do |edge|
      x0, y0, x1, y1 = [edge.a, edge.b].map do |point|
        screen_coords_from_point(point)
      end.flatten

      draw_line x0, y0, Gosu::Color::WHITE, x1, y1, Gosu::Color::WHITE
    end
  end

  def draw_cube_points
    @cube.world_points.each do |point|
      x, y = screen_coords_from_point(point)
      draw_point x, y
    end
  end

  def screen_coords_from_point(point)
    x, y = calculate_object_screen_coords(point)

    # Y dimension goes up in 3d-world by down in screen-world
    y = -y

    # Position the camera at the center of the screen
    [x + @screen_width / 2, y + @screen_height / 2]
  end

  def calculate_object_screen_coords(point)
    real_point = @camera.transform(point)
    [real_point.x * @fov / real_point.z, real_point.y * @fov / real_point.z]
  end
end

window = GameWindow.new
window.show