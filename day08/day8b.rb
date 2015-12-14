class String
  def santa_encoded
    @santa_encoded ||=
      "\"" + self.gsub("\\", "\\\\\\").gsub("\"","\\\"") + "\""
  end
end

File.open(File.join(File.dirname(__FILE__), "day8.input.txt")) do |file|
  diff = 0
  while content = file.gets
    content.strip!
    diff += (content.santa_encoded.length - content.length)
  end
  puts "Diff: #{diff}"
end
