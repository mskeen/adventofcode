class Password
  attr_accessor :password

  def initialize(password)
    @password = password
  end

  def valid?
    !@password.match(/[iol]/) && @password.scan(/(.)\1/).size > 1 && has_straight?
  end

  def next
    loop do
      @password = increment(@password, @password.length - 1)
      break if valid?
    end
    @password
  end

  protected

  def has_straight?
    chars = @password.chars
    chars[2..-1].each_with_index do |c, i|
      return true if c == chars[i + 1].next && c == chars[i].next.next
    end
    false
  end

  def increment(value, index)
    return value if index < 0
    if value[index] == 'z'
      value[index] = 'a'
      return increment(value, index - 1)
    else
      loop do
        value[index] = value[index].next
        break unless value[index].match(/[iol]/)
      end
    end
    value
  end
end

begin
  p = Password.new("hxbxwxba")
  puts p.next
  puts p.next
end