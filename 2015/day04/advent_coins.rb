require "digest"

class AdventCoin

  def self.mine(secret)
    i = 1
    while (!Digest::MD5.hexdigest("#{secret}#{i}").start_with?("00000") ) do
      i += 1
    end
    i
  end
end


def test(name, value, expected_value)
  if value == expected_value
    puts "#{name} test passed (#{value})"
  else
    puts "#{name} test failed (#{expected_value} expected. Got #{value})"
  end
end

begin
  # test("#1", AdventCoin.mine("abcdef"), 609043)
  # test("#2", AdventCoin.mine("pqrstuv"), 1048970)

  puts AdventCoin.mine("ckczppom")
end