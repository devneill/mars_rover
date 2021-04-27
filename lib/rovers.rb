# frozen_string_literal: true

# A class for handling the Platform45 mars rovers
class Rovers
  def initialize(scanning_instructions)
    @instructions = validate_and_clean(scanning_instructions)
    return unless @valid_instructions

    @grid = load_grid
    @rovers = load_rovers
    @final_positions = []
  end

  def scan_territory
    return '********** ERROR: INVALID SCANNING INSTRUCTIONS PROVIDED' unless @valid_instructions

    puts '********** BEGINNING SCAN'
    execute_scan

    puts "SCAN COMPLETE. FINAL ROVER POSITIONS: \n #{final_positions}"
    final_positions
  end

  private

  def validate_and_clean(scanning_instructions)
    @valid_instructions = (scanning_instructions.count("\n").positive? && scanning_instructions.count("\n").even?)
    scanning_instructions.split(/\n/)
  end

  def load_grid
    @instructions[0].split(' ')
  end

  def load_rovers
    rovers = []
    rover_count.times do |i|
      rovers << new_rover(i)
    end
    rovers
  end

  def rover_count
    (@instructions.count - 1) / 2
  end

  def new_rover(index)
    {
      start_position: @instructions[2 * index + 1].split(' '),
      commands: @instructions[2 * index + 2].strip.split(''),
      final_position: ''
    }
  end

  def execute_scan
    @rovers.each_with_index do |rover, index|
      @rovers[index] = update_position_for(rover, index)
      @final_positions << rover[:final_position]
    end
  end

  def update_position_for(rover, index)
    x = rover[:start_position][0]
    y = rover[:start_position][1]
    start_position = [x, y]
    start_direction = rover[:start_position][2]

    puts "********** UPDATING ROVER #{index + 1} LOCATION"
    puts "COMMAND LIST RECEIVED: #{rover[:commands]}"
    puts "ROVER START LOCATION #{[*start_position, start_direction]}"

    rover[:final_position] = execute_commands(rover[:commands], start_position, start_direction)
    puts "********** ROVER #{index + 1} LOCATION UPDATED TO #{rover[:final_position]}"
    rover
  end

  def execute_commands(commands, position, direction)
    commands.each do |command|
      case command
      when 'L'
        direction = turn_left(direction)
      when 'R'
        direction = turn_right(direction)
      when 'M'
        position = move(position, direction)
      end
    end
    [*position, direction].join(' ')
  end

  def turn_left(direction)
    case direction
    when 'N'
      direction = 'W'
    when 'E'
      direction = 'N'
    when 'S'
      direction = 'E'
    when 'W'
      direction = 'S'
    end
    puts "TURNING LEFT TO FACE #{direction}"
    direction
  end

  def turn_right(direction)
    case direction
    when 'N'
      direction = 'E'
    when 'E'
      direction = 'S'
    when 'S'
      direction = 'W'
    when 'W'
      direction = 'N'
    end
    puts "TURNING RIGHT TO FACE #{direction}"
    direction
  end

  def move(position, direction)
    x = position[0].to_i
    y = position[1].to_i
    new_position = update_position(x, y, direction)
    puts "MOVING TO NEW POSITION #{new_position}"
    new_position
  end

  def update_position(x, y, direction)
    case direction
    when 'N'
      y = attempt_move_north(y)
    when 'E'
      x = attempt_move_east(x)
    when 'S'
      y = attempt_move_south(y)
    when 'W'
      x = attempt_move_west(x)
    end
    [x.to_s, y.to_s]
  end

  def attempt_move_north(y)
    max_y = @grid[1].to_i
    y < max_y ? (y + 1) : y
  end

  def attempt_move_east(x)
    max_x = @grid[0].to_i
    x < max_x ? (x + 1) : x
  end

  def attempt_move_south(y)
    y.positive? ? (y - 1) : y
  end

  def attempt_move_west(x)
    x.positive? ? (x - 1) : x
  end

  def final_positions
    @final_positions.join(" \n ")
  end
end
