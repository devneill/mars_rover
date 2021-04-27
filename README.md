# The Platform45 mars rover program

## To run locally

### To run with default instructions scanning run

`ruby -r './lib/rovers.rb' -e 'Rovers.new("5 5 \n 1 2 N \n LMLMLMLMM \n 3 3 E \n MMRMMRMRRM").scan_territory' `

### To run with custom scanning instructions, run

`ruby -r './lib/rovers.rb' -e 'Rovers.new("INSERT CUSTOM INSTRUCTIONS").scan_territory' `

Here is an example
`ruby -r './lib/rovers.rb' -e 'Rovers.new("6 6 \n 5 3 E \n MMRMM \n 2 4 E \n MRMMMRMLLM \n 0 2 N \n LMLMM").scan_territory' `

## To test

### Run `bundle exec rspec`

## Assumptions

If a rover is instructed to move outside of the grid, they will ignore the command
