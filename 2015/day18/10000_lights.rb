class Grid
  attr_accessor :grid, :width, :height, :corners_on

  def initialize(start_setup, corners_on = false)
    @width = @height = start_setup.size
    @grid = start_setup
    @corners_on = corners_on
    turn_corners_on if corners_on
  end

  def to_s
    @grid
  end

  def neighbours(x, y)
    total = 0
    ((x-1)..(x+1)).each do |gx|
      ((y-1)..(y+1)).each do |gy|
        total += 1 if !(gx == x && gy == y) && on?(gx, gy)
      end
    end
    total
  end

  def on?(x, y)
    return false if x < 0 || y < 0 || x >= @width || y >= @height
    @grid[y][x] == '#'
  end

  def turn_corners_on
    @grid[0][0] = '#'
    @grid[0][@width - 1] = '#'
    @grid[@height - 1][0] = '#'
    @grid[@height - 1][@width - 1] = '#'
  end

  def process_turn()
    turn_corners_on if corners_on
    new_grid = @grid.map { |row| row.dup }
    (0..(@height-1)).each do |y|
      (0..(@width-1)).each do |x|
        if on?(x,y)
          if [2,3].include? neighbours(x, y)
            new_grid[y][x] = "#"
          else
            new_grid[y][x] = "."
          end
        else
          if neighbours(x, y) == 3
            new_grid[y][x] = "#"
          else
            new_grid[y][x] = "."
          end
        end
      end
    end
    @grid = new_grid
    turn_corners_on if @corners_on
  end

  def on_count
    total = 0
    (0..(@height-1)).each do |y|
      (0..(@width-1)).each do |x|
        total += 1 if on?(x,y)
      end
    end
    total
  end
end

begin
  g = Grid.new(File.read("./input.txt").split("\n"), true)
  puts g.to_s
  puts
  100.times { g.process_turn }
  puts g.to_s
  puts g.on_count

end
