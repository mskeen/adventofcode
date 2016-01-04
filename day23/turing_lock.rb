class Computer
  attr_accessor :registers

  PARSER = /((?<instruction>hlf|tpl|inc|jie|jio|jmp) (?<register>a|b)*(, )*(?<offset>[+\-\d]+)*)/

  INSTRUCTIONS = {
    "hlf" => { cmd: -> (c, reg, off) { c.registers[reg] /= 2; c.jump(1) } },
    "tpl" => { cmd: -> (c, reg, off) { c.registers[reg] *= 3; c.jump(1) } },
    "inc" => { cmd: -> (c, reg, off) { c.registers[reg] += 1; c.jump(1) } },
    "jmp" => { cmd: -> (c, reg, off) { c.jump(off) } },
    "jie" => { cmd: -> (c, reg, off) { c.jump(c.registers[reg] % 2 == 0 ? off : 1) } },
    "jio" => { cmd: -> (c, reg, off) { c.jump(c.registers[reg] == 1 ? off : 1) } }
  }

  def initialize(program, a_init = 0, b_init = 0)
    @registers = { "a" => a_init, "b" => b_init }
    @instructions = program.split("\n")
    @stack_pointer = 0
  end

  def jump(distance)
    @stack_pointer += distance.to_i
  end

  def execute_instruction
    if m = @instructions[@stack_pointer].match(PARSER)
      # puts "a: #{@registers["a"]} b: #{@registers["b"]} ptr: #{@stack_pointer} #{m["instruction"]} reg: #{m['register']} offset: #{m['offset']}"
      INSTRUCTIONS[m["instruction"]][:cmd].call(self, m["register"], m["offset"].to_i)
    else
      exit "PROGRAM ERROR with offset #{@stack_pointer}: #{@instructions[@stack_pointer.to_i]}"
    end
  end

  def run
    loop do
      execute_instruction
      break if @stack_pointer < 0 || @stack_pointer >= @instructions.size
    end
  end
end

begin
  c = Computer.new(File.read("./input.txt"))
  c.run
  puts c.registers["b"]

  c2 = Computer.new(File.read("./input.txt"), 1)
  c2.run
  puts c2.registers["b"]
end