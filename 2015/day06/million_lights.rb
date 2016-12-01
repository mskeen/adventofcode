class Grid
  def initialize
    @grid = Hash.new(0)
  end

  def process_instruction(instruction)
    tokens = instruction.gsub("turn ", '').gsub("through ", '').split()
    x1, y1 = tokens[1].split(',')
    x2, y2 = tokens[2].split(',')
    puts "Processing #{tokens[0]} #{x1}, #{y1} through #{x2}, #{y2}"
    x1.to_i.upto(x2.to_i) do |x|
      y1.to_i.upto(y2.to_i) do |y|
        key = "#{x}:#{y}"
        case tokens[0]
        when 'on' then @grid[key] += 1
        when 'off' then
          @grid[key] -= 1 unless @grid[key] == 0
        else @grid[key] += 2
        end
      end
    end
  end

  def lit_count
    count = 0
    @grid.keys.each do |key|
      count += @grid[key]
    end
    count
  end
end

begin
  grid = Grid.new

  # grid.process_instruction("turn on 0,0 through 0,0")
  # grid.process_instruction("toggle 0,0 through 999,999")

  File.read("./day6.input.txt").split("\n").each do |content|
    grid.process_instruction(content)
  end

  puts "#{grid.lit_count}"
end