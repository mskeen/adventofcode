GIFTS = [ 1, 3, 5, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 67, 71, 73, 79, 83, 89, 97, 101, 103, 107, 109, 113 ]

def can_package?(gifts, num_packages, target_weight, min_package_size)
  return (gifts.reduce(:+) == target_weight) if num_packages == 1
  (min_package_size..(gifts.size - (min_package_size * (num_packages - 1)))).each do |i|
    gifts.combination(i).each do |giftset|
      return true if giftset.reduce(:+) == target_weight && can_package?(gifts - giftset, num_packages - 1, target_weight, min_package_size)
    end
  end
  false
end

def build_passenger_gifts(gifts, num_packages)
  low_package_count = 30
  best_qe = 99999999999999
  target_weight = gifts.reduce(:+) / num_packages
  (1..(gifts.size - (num_packages - 1))).each do |i|
    next if i > low_package_count
    gifts.combination(i).each do |giftset|
      if giftset.reduce(:+) == target_weight
        if can_package?(gifts - giftset, num_packages - 1, target_weight, giftset.size)
          low_package_count = i if i < low_package_count
          best_qe = [best_qe, giftset.reduce(:*)].min
        end
      end
    end
  end
  best_qe
end

puts build_passenger_gifts(GIFTS, 3)
puts build_passenger_gifts(GIFTS, 4)
