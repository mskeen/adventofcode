def paper_required(l, w, h)
  2 * l * w + 2 * w * h + 2 * h * l + l * w
end

def ribbon_required(l, w, h)
  l * 2 + w * 2 + l * w * h
end

begin
  area = ribbon = 0
  File.read("./day2.input.txt").split("\n").each do |content|
    l, w, h = content.split("x").map { |n| n.to_i }.sort
    area += paper_required(l, w, h)
    ribbon += ribbon_required(l, w, h)
  end
  puts "Area: #{area}"
  puts "Ribbon: #{ribbon}"
end