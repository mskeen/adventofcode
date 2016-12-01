def nice?(string)
  return false if string.match(/ab|cd|pq|xy/)
  return false if string.scan(/a|e|i|o|u/).size < 3
  return false unless string.match(/(.)\1/)
  true
end

def nice_b?(string)
  return false unless string.match(/(..).*\1/)
  return false unless string.match(/(.).\1/)
  true
end

def test(name, value, expected_value)
  if value == expected_value
    puts "#{name} test passed (#{value})"
  else
    puts "#{name} test failed (#{expected_value} expected. Got #{value})"
  end
end

begin
  # test("#1", nice?("ugknbfddgicrmopn"), true)
  # test("#2", nice?("aaa"), true)
  # test("#3", nice?("jchzalrnumimnmhp"), false)
  # test("#2", nice?("haegwjzuvuyypxyu"), false)
  # test("#2", nice?("dvszwmarrgswjxmb"), false)

  part_a = File.read("./day5.input.txt").split("\n").keep_if { |s| nice?(s) }.size
  part_b = File.read("./day5.input.txt").split("\n").keep_if { |s| nice_b?(s) }.size
  puts "Part a: #{part_a}"
  puts "Part b: #{part_b}"
end