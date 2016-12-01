def value_at(row, column)
  SEED = 20151125
  col, last = 2, SEED
  loop do
    (1..col).each do |x|
      last = last * 252533 % 33554393
      return last if x == column && (col - x + 1) == row
    end
    col += 1
  end
end

puts value_at(2981, 3075)
