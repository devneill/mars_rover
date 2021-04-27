# frozen_string_literal: true

# A class for handling the Platform45 mars rovers
class Rovers
  def self.scan_territory(scanning_instructions)
    return 'Error: No scanning instructions provided' unless scanning_instructions != ''

    # TODO: Add more error hadnling

    grid_size, rover_1_start_position, rover_1_commands, rover_2_start_position, rover_2_commands = analyse(scanning_instructions)

    rover_1_final_position = update_rover_position(grid_size, rover_1_start_position, rover_1_commands)
    rover_2_final_position = update_rover_position(grid_size, rover_2_start_position, rover_2_commands)

    "#{rover_1_final_position} \n #{rover_2_final_position}"
  end

  def self.analyse(scanning_instructions)
    instructions = scanning_instructions.split(/\n/)
    grid_size = instructions[0].split(' ')
    rover_1_start_position = instructions[1].split(' ')
    rover_1_commands = instructions[2].strip.split('')
    rover_2_start_position = instructions[3].split(' ')
    rover_2_commands = instructions[4].strip.split('')
    [grid_size, rover_1_start_position, rover_1_commands, rover_2_start_position, rover_2_commands]
  end

  def self.update_rover_position(grid_size, start_position, commands)
    x = start_position[0]
    y = start_position[1]
    position = [x, y]
    direction = start_position[2]
    puts "**********COMMANDS #{commands}"

    commands.each do |command|
      puts "**********START LOCATION #{[*position, direction]}"
      puts "**********COMMAND #{command}"
      if command == 'L'
        direction = turn_left(direction)
        puts "NEW DIRECTION #{direction}"
      elsif command == 'R'
        direction = turn_right(direction)
        puts "NEW DIRECTION #{direction}"
      elsif command == 'M'
        position = move(grid_size, position, direction)
        puts "NEW POSITION #{position}"
      end
      puts "**********END LOCATION #{[*position, direction]}"
    end
    [*position, direction].join(' ')
  end

  def self.turn_left(direction)
    if direction == 'N'
      direction = 'W'
    elsif direction == 'E'
      direction = 'N'
    elsif direction == 'S'
      direction = 'E'
    elsif direction == 'W'
      direction = 'S'
    end
    direction
  end

  def self.turn_right(direction)
    if direction == 'N'
      direction = 'E'
    elsif direction == 'E'
      direction = 'S'
    elsif direction == 'S'
      direction = 'W'
    elsif direction == 'W'
      direction = 'N'
    end
    direction
  end

  def self.move(grid_size, position, direction)
    max_x = grid_size[0].to_i
    max_y = grid_size[1].to_i
    x = position[0].to_i
    y = position[1].to_i
    puts x, y
    y = direction == 'N' && y <= max_y ? (y + 1) : y
    x = direction == 'E' && x <= max_x ? (x + 1) : x
    y = direction == 'S' && y.positive? ? (y - 1) : y
    x = direction == 'W' && x.positive? ? (x - 1) : x
    [x.to_s, y.to_s]
  end
end
