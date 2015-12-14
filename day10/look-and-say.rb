def look_and_say(seq)
  seq.scan(/((\d)\2*)/).map { |match| match[0].length.to_s + match[1] }.join
end

begin
  sequence = "1113122113"
  50.times { |i| sequence = look_and_say(sequence); puts i+1 }
  puts sequence.length
end