def valid(sides)
  sorted = sides.sort
  return 1 if sorted[0] + sorted[1] > sorted[2]
  0
end

begin
  # Part A
  valid_count = 0
  File.read('./input.txt').split("\n").each do |line|
    valid_count += valid(line.split(' ').collect { |side| side.strip.to_i })
  end
  puts valid_count

  # Part B
  valid_count = 0
  File.read('./input.txt').gsub("\n", ' ').split(" ").collect { |side| side.strip.to_i }.each_slice(9).to_a.each do |a|
    valid_count += valid([a[0], a[3], a[6]])
    valid_count += valid([a[1], a[4], a[7]])
    valid_count += valid([a[2], a[5], a[8]])
  end
  puts valid_count
end
