require 'rovers'

RSpec.describe Rovers do
  describe '#scan_territory' do
    context 'given a invalid input' do
      it 'returns an error message' do
        expect(Rovers.new('invalid input').scan_territory).to eql '********** ERROR: INVALID SCANNING INSTRUCTIONS provided **********'
      end
    end

    context 'given valid scanning instructions' do
      it 'returns final rover positions' do
        scanning_instructions = "5 5 \n 1 2 N \n LMLMLMLMM \n 3 3 E \n MMRMMRMRRM"
        expect(Rovers.new(scanning_instructions).scan_territory).to eql "1 3 N \n 5 1 E"
      end
    end
  end
end
