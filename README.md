# The Platform45 mars rover program

## To run locally

### For basic scanning instructions run `ruby -r './lib/rovers.rb' -e 'Rovers.scan_territory "5 5 \n 1 2 N \n LMLMLMLMM \n 3 3 E \n MMRMMRMRRM"'`

### For custom scanning instructions, run `ruby -r './lib/rovers.rb' -e 'Rovers.scan_territory "INSERT CUSTOM INSTRUCTIONS"'`

## To test

### Run `bundle exec rspec`

### Assumptions

If a rover is instructed to move outside of the grid, they will ignore the command
