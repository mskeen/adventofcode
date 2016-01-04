@target = 29000000

def house_value_a(house_number)
  sum = 0
  (1..house_number).each do |n|
    sum += (n * 10) if house_number % n == 0
  end
  puts "house_value for ##{house_number} is #{sum}"
  sum
end

def house_value_b(house_number)
  sum = 0
  (1..house_number).each do |n|
    sum += (n * 11) if house_number % n == 0 && house_number / n <= 50
  end
  puts "house_value for ##{house_number} is #{sum}"
  sum
end

begin
  step = 128
  index = 665280
  low_bounds = 0
  while (house_value_b(index) < @target) do
    low_bounds = index
    index += step
  end
  puts "went over on #{index}"
  puts "established lower bounds of: #{low_bounds}"

  index = low_bounds
  step = 8
  while (house_value_b(index) < @target) do
    low_bounds = index
    index += step
  end
  puts "went over on #{index}"
  puts "established lower bounds of: #{low_bounds}"

  index = low_bounds
  step = 1
  while (house_value_b(index) < @target) do
    low_bounds = index
    index += step
  end
  puts "went over on #{index}"

end
