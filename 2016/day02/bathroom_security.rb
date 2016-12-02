TEST_INPUT = %q(
ULL
RRDDD
LURDL
UUUUD
).freeze

KEYPAD_A = %w(123 456 789).freeze
KEYPAD_B = [
  '  1  ',
  ' 234 ',
  '56789',
  ' ABC ',
  '  D  '
]

class Keypad
  def initialize(keys, start)
    @keys = keys
    @start = start
  end

  def coords(button)
    @keys.each_with_index do |line, index|
      if (x = line.index(button))
        puts "found #{button} at #{x}, #{index}"
        return [x, index]
      end
    end
    nil
  end

  def button_at(x, y)
    return nil if x < 0 || y < 0
    if (line = @keys[y])
      button = line[x]
      return button if button && button != ' '
    end
    nil
  end

  def move(button, direction)
    x, y = coords(button)
    x += 1 if direction == 'R'
    x -= 1 if direction == 'L'
    y += 1 if direction == 'D'
    y -= 1 if direction == 'U'
    puts "#{direction} : move to #{button_at(x, y)}" if button_at(x, y)
    button_at(x, y) || button
  end

  def decode(input)
    button = @start
    code = ''
    input.split.each do |line|
      line.scan(/\w/).each { |ch| button = move(button, ch) }
      code += button
      puts code
    end
    code
  end
end

begin
  input = File.read("./input.txt")

  k = Keypad.new(KEYPAD_A, '5')
  puts "#{k.decode(TEST_INPUT)} (should be 1985)"
  puts "Part A Result: #{k.decode(input)}"

  k2 = Keypad.new(KEYPAD_B, '5')
  puts "#{k2.decode(TEST_INPUT)} (should be 5DB3)"
  puts "Part B Result: #{k2.decode(input)}"
end
