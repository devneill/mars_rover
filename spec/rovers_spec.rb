require 'rovers'

RSpec.describe Rovers do
  describe '#scan_territory' do
    context 'given a blank input' do
      it 'returns an error message' do
        expect(Rovers.scan_territory('')).to eql 'Error: No scanning instructions provided'
      end
    end

    context 'given valid scanning instructions' do
      it 'returns final rover positions' do
        scanning_instructions = "5 5 \n 1 2 N \n LMLMLMLMM \n 3 3 E \n MMRMMRMRRM"
        expect(Rovers.scan_territory(scanning_instructions)).to eql "1 3 N \n 5 1 E"
      end
    end
  end

  describe '#update_rover_position' do
    context 'given a valid grid_size, start_position and commands' do
      it 'returns final rover position' do
        scanning_instructions = "5 5 \n 1 2 N \n LMLMLMLMM \n 3 3 E \n MMRMMRMRRM"
        expect(Rovers.scan_territory(scanning_instructions)).to eql "1 3 N \n 5 1 E"
      end
    end
  end
end
