target = {
  "children" => { count: 3, operation: "==" },
  "cats" => { count: 7, operation: ">" },
  "samoyeds" => { count: 2, operation: "==" },
  "pomeranians" => { count: 3, operation: "<" },
  "akitas" => { count: 0, operation: "==" },
  "vizslas" => { count: 0, operation: "==" },
  "goldfish" => { count: 5, operation: "<" },
  "trees" => { count: 3, operation: ">" },
  "cars" => { count: 2, operation: "==" },
  "perfumes" => { count: 1, operation: "==" }
}

# Process the input file
sue_list = Hash.new{|hash, key| hash[key] = Hash.new}
File.read("./input.txt").split("\n").each do |sue|
  m = sue.match(/Sue (?<num>\d+): (?<attrs>.+)/)
  sue_num = m["num"]
  h = {}
  m["attrs"].split(", ").each do |attr|
    attr_name, attr_value = attr.split(": ")
    h[attr_name] = attr_value.to_i
  end
  sue_list[sue_num] = h
end

sue_list.keys.each do |key|
  match_for_a = match_for_b = 0
  target.keys.each do |tkey|
    match_for_a += 1 if (sue_list[key][tkey] || -1) == target[tkey][:count]
    match_for_b += 1 if sue_list[key][tkey] && sue_list[key][tkey].send(target[tkey][:operation], target[tkey][:count])
  end
  puts "A #{key}: #{match_for_a}" if match_for_a == 3
  puts "B #{key}: #{match_for_b}" if match_for_b == 3
end