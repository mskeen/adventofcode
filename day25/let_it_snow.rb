col = 2
last = 20151125

loop do
  (1..col).each do |x|
    last = last * 252533 % 33554393
    if x == 3075 && (col - x + 1) == 2981
      puts "#{last}"
      exit
    end
  end
  col += 1
end

