substitutions = Hash.new {|h,k| h[k] = Array.new }
@words = {}
@sorted_words = []
source = ""
results = {}

# def reduce(molecule, steps = 0)
#   @sorted_words.each do |w|
#     if molecule.start_with?(w)
#       molecule, steps = reduce(@words[w] + molecule[w.size..-1], steps + 1)
#       break
#     end
#   end
#   return [molecule, steps]
# end

def reduce(molecule, steps = 0)
  loop do
    changed = false
    @sorted_words.each do |w|
      while (molecule.index(w)) do
        steps += 1
        changed = true
        molecule.sub!(w, @words[w])
      end
    end
    break unless changed
  end
  [molecule, steps]
end

File.read("./input.txt").split("\n").each do |line|
  if m = line.match(/(.+) => (.+)/)
    substitutions[m[1]] << m[2]
    @words[m[2]] = m[1]
  else
    source = line
  end
end


# A
substitutions.each do |key, values|
  index = source.index(key)
  while (index) do
    values.each do |v|
      new_molecule = source[0..(index - 1)] + v + source[(index + key.size)..-1]
      results[new_molecule] = 1
    end
    index = source.index(key, index + 1)
  end
end
puts results.size

# B
@sorted_words = @words.keys.sort { |x,y| y.size <=> x.size }
puts @sorted_words.join(", ")


puts source
puts
puts reduce(source)
