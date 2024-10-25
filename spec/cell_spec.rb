# spec/ship_spec.rb
# This file tests the functionality of the Cell class.
# It requires the 'spec_helper' to load the RSpec configuration.
require 'spec_helper'

# Your tests go here...

require './lib/ship'
require './lib/cell'

RSpec.configure do |config|
    config.formatter = :documentation
end

RSpec.describe Cell do
    describe '#initialize' do
        it 'exists' do
            cell = Cell.new("B4")

            expect(cell).to be_a Cell
        end

    end
    
end
