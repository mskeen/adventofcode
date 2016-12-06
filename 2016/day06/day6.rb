lines = File.read('./input.txt').split("\n")

digits = lines[0].size

answer1 = answer2 = ''

(0..(digits - 1)).each do |i|
  # puts i
  counts = Hash.new(0)
  lines.each do |line|
    counts[line[i]] += 1
  end
  # Part a
  answer1 += counts.sort_by { |k,v| v }.last[0]
  # Part b
  answer2 += counts.sort_by { |k,v| v }.first[0]
end

puts answer1
puts answer2
