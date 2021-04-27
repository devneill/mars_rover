# frozen_string_literal: true

# A class for handling the Platform45 mars rovers
class Rovers
  def initialize(scanning_instructions)
    instructions = scanning_instructions.split(/\n/)
    @valid_instructions = instructions.count == 5

    return unless @valid_instructions

    @grid_size = instructions[0].split(' ')
    @rover_1_start_position = instructions[1].split(' ')
    @rover_1_commands = instructions[2].strip.split('')
    @rover_1_final_position = ''
    @rover_2_start_position = instructions[3].split(' ')
    @rover_2_commands = instructions[4].strip.split('')
    @rover_2_final_position = ''
  end

  def scan_territory
    return '********** ERROR: INVALID SCANNING INSTRUCTIONS provided **********' unless @valid_instructions

    puts '********** BEGINNING SCAN **********'
    execute_scan

    puts "********** \nSCAN COMPLETE. FINAL ROVER POSITIONS: \n #{final_positions} \n**********"
    final_positions
  end

  def execute_scan
    update_rover_1_position
    update_rover_2_position
  end

  def final_positions
    "#{@rover_1_final_position} \n #{@rover_2_final_position}"
  end

  def update_rover_1_position
    x = @rover_1_start_position[0]
    y = @rover_1_start_position[1]
    position = [x, y]
    direction = @rover_1_start_position[2]

    puts '********** UPDATING ROVER LOCATION **********'
    puts "COMMAND LIST RECEIVED: #{@rover_1_commands}"
    puts "ROVER START LOCATION #{[*position, direction]}"

    @rover_1_commands.each do |command|
      if command == 'L'
        direction = turn_left(direction)
        puts "TURNING LEFT TO FACE #{direction}"
      elsif command == 'R'
        direction = turn_right(direction)
        puts "TURNING RIGHT TO FACE #{direction}"
      elsif command == 'M'
        position = move(position, direction)
        puts "MOVING TO NEW POSITION #{position}"
      end
    end
    @rover_1_final_position = [*position, direction].join(' ')
    puts "********** ROVER LOCATION UPDATED TO #{@rover_1_final_position}"
  end

  def update_rover_2_position
    x = @rover_2_start_position[0]
    y = @rover_2_start_position[1]
    position = [x, y]
    direction = @rover_2_start_position[2]

    puts '********** UPDATING ROVER LOCATION **********'
    puts "COMMAND LIST RECEIVED: #{@rover_2_commands}"
    puts "ROVER START LOCATION #{[*position, direction]}"

    @rover_2_commands.each do |command|
      if command == 'L'
        direction = turn_left(direction)
        puts "TURNING LEFT TO FACE #{direction}"
      elsif command == 'R'
        direction = turn_right(direction)
        puts "TURNING RIGHT TO FACE #{direction}"
      elsif command == 'M'
        position = move(position, direction)
        puts "MOVING TO NEW POSITION #{position}"
      end
    end
    @rover_2_final_position = [*position, direction].join(' ')
    puts "********** ROVER LOCATION UPDATED TO #{@rover_2_final_position}"
  end

  def turn_left(direction)
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

  def turn_right(direction)
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

  def move(position, direction)
    max_x = @grid_size[0].to_i
    max_y = @grid_size[1].to_i
    x = position[0].to_i
    y = position[1].to_i
    y = direction == 'N' && y <= max_y ? (y + 1) : y
    x = direction == 'E' && x <= max_x ? (x + 1) : x
    y = direction == 'S' && y.positive? ? (y - 1) : y
    x = direction == 'W' && x.positive? ? (x - 1) : x
    [x.to_s, y.to_s]
  end
end
