class String
  def stripped
    self[1..-2].gsub("\\\\", " ").gsub("\\\"", " ").gsub(/\\x[0-9a-f][0-9a-f]/, " ")
  end
end

File.open(File.join(File.dirname(__FILE__), "day8.input.txt")) do |file|
  diff = 0
  while content = file.gets
    content.strip!
    diff += (content.length - content.stripped.length)
  end
  puts "Diff: #{diff}"
end
