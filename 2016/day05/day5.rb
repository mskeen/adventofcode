require 'digest'

def part_a
  # input = 'abc'
  input = 'wtnhxymk'
  output = ''

  index = 0

  while output.size < 8
    dig = Digest::MD5.hexdigest("#{input}#{index}")
    if dig =~ /^00000/
      output += dig[5]
      puts "#{index}: #{dig}: #{output}"
    end
    index += 1
  end
  puts output
end

def part_b
  # input = 'abc'
  input = 'wtnhxymk'
  output = '        '

  index = 0

  while output =~ / /
    dig = Digest::MD5.hexdigest("#{input}#{index}")
    if dig =~ /^00000/
      if dig[5] =~ /[0-7]/ && output[dig[5].to_i] == ' '
        output[dig[5].to_i] = dig[6]
        puts "#{index}: #{dig}: #{output}"
      end
    end
    index += 1
  end
  puts output
end

begin
  # part_a
  part_b
end
