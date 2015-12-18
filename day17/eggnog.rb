@source_buckets = [11, 30, 47, 31, 32, 36, 3, 1, 5, 3, 32, 36, 15, 11, 46, 26, 28, 1, 19, 3]
@target = 150
@bits = @source_buckets.size

total_count = best_bit_count_freq = 0
best_bit_count = @bits

(1..(2**@bits - 1)).each do |i|
  sum = bit_count = 0
  (0..(@bits - 1)).each do |index|
    if ((2 ** index) & i) > 0
      sum += @source_buckets[index]
      bit_count += 1
    end
  end
  if sum == @target
    total_count += 1
    if bit_count == best_bit_count
      best_bit_count_freq += 1
    elsif bit_count < best_bit_count
      best_bit_count_freq = 1
      best_bit_count = bit_count
    end
  end
end

puts total_count

puts "#{best_bit_count} containers were used in #{best_bit_count_freq} combinations"