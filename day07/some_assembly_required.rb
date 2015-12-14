class Circuit
  def initialize
    @list = Hash.new
  end

  def add(instruction)
    calc, wire = instruction.split(" -> ")
    @list[wire.strip] = calc.strip
  end

  def value_for(wire)
    @list[wire]
  end

  def evaluate_all
    changes_made = true
    loop do
      changes_made = false
      atom_count = 0
      @list.keys.each { |k| changes_made = true if update_wire(k) }
      break unless changes_made
    end
  end

  def set_wire(wire, value)
    @list[wire] = value
  end

  protected

  def update_wire(key)
    calc = @list[key]
    return false if is_number?(calc)
    @list[key] = perform_calc(calc)
    true
  end

  def perform_calc(calc)
    if m = (calc.match(/(?<operation>NOT) (?<operand1>.+)/) ||
       calc.match(/(?<operand1>.+) (?<operation>LSHIFT|AND|OR|RSHIFT) (?<operand2>.+)/))
      operation = m["operation"]
      operand1 = lookup(m["operand1"])
      operand2 = lookup(m["operand2"]) if m.names.include? "operand2"

      if operation == "NOT"
        if is_number?(operand1)
          return operand1.to_i ^ 65535
        else
          return "NOT #{operand1}"
        end
      elsif operation == "AND"
        if is_number?(operand1) && is_number?(operand2)
          return operand1.to_i & operand2.to_i
        else
          return "#{operand1} AND #{operand2}"
        end
      elsif operation == "OR"
        if is_number?(operand1) && is_number?(operand2)
          return operand1.to_i | operand2.to_i
        else
          return "#{operand1} OR #{operand2}"
        end
      elsif operation == "RSHIFT"
        if is_number?(operand1) && is_number?(operand2)
          return operand1.to_i >> operand2.to_i
        else
          return "#{operand1} RSHIFT #{operand2}"
        end
      elsif operation == "LSHIFT"
        if is_number?(operand1) && is_number?(operand2)
          return operand1.to_i << operand2.to_i
        else
          return "#{operand1} LSHIFT #{operand2}"
        end
      end
      return calc
    end
    lookup(calc)
  end

  def lookup(wire)
    # puts "  lookup: #{wire} (#{@list[wire]})"
    return @list[wire] if !is_number?(wire) && is_number?(@list[wire])
    wire
  end

  def is_number?(input)
    return true if input && (input.class == Fixnum || !input.strip.match(/[^\d]+/))
    false
  end
end

begin
  c = Circuit.new
  # c.add '123 -> x'
  # c.add '456 -> y'
  # c.add 'x AND y -> d'
  # c.add 'x OR y -> e'
  # c.add 'x LSHIFT 2 -> f'
  # c.add 'y RSHIFT 2 -> g'
  # c.add 'NOT x -> h'
  # c.add 'NOT y -> i'
  # c.evaluate_all
  # puts c.value_for('h')
  # puts c.value_for('i')

  File.open(File.join(File.dirname(__FILE__), "day7.input.txt")) do |file|
    while content = file.gets
      c.add(content)
    end
    c.set_wire("b", "3176")
  end

  c.evaluate_all
  puts c.value_for('a')

end