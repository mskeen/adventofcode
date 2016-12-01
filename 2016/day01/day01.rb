INPUT = 'R4, R3, L3, L2, L1, R1, L1, R2, R3, L5, L5, R4, L4, R2, R4, L3, R3, ' \
        'L3, R3, R4, R2, L1, R2, L3, L2, L1, R3, R5, L1, L4, R2, L4, R3, R1, ' \
        'R2, L5, R2, L189, R5, L5, R52, R3, L1, R4, R5, R1, R4, L1, L3, R2, ' \
        'L2, L3, R4, R3, L2, L5, R4, R5, L2, R2, L1, L3, R3, L4, R4, R5, L1, ' \
        'L1, R3, L5, L2, R76, R2, R2, L1, L3, R189, L3, L4, L1, L3, R5, R4, ' \
        'L1, R1, L1, L1, R2, L4, R2, L5, L5, L5, R2, L4, L5, R4, R4, R5, L5, ' \
        'R3, L1, L3, L1, L1, L3, L4, R5, L3, R5, R3, R3, L5, L5, R3, R4, L3, ' \
        'R3, R1, R3, R2, R2, L1, R1, L3, L3, L3, L1, R2, L1, R4, R4, L1, L1, ' \
        'R3, R3, R4, R1, L5, L2, R2, R3, R2, L3, R4, L5, R1, R4, R5, R4, L4, ' \
        'R1, L3, R1, R3, L2, L3, R1, L2, R3, L3, L1, L3, R4, L4, L5, R3, R5, ' \
        'R4, R1, L2, R3, R5, L5, L4, L1, L1'

MOVEMENT = { 'N' => [0, -1],
             'E' => [1, 0],
             'S' => [0, 1],
             'W' => [-1, 0] }.freeze

DIRECTION = %w(N E S W)

def turn(direction, change)
  return (DIRECTION[DIRECTION.index(direction) + 1] || 'N') if change == 'R'
  (DIRECTION[DIRECTION.index(direction) - 1] || 'W')
end

begin
  direction = 'N'
  x = y = 0

  INPUT.split(', ').each do |move|
    direction = turn(direction, move[0])
    distance = move[1..-1].to_i
    x += MOVEMENT[direction][0] * distance
    y += MOVEMENT[direction][1] * distance
  end
  puts x.abs + y.abs
end
