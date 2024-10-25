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

        it 'has a coordinate' do
            cell = Cell.new("B4")

            expect(cell.coordinate).to eq "B4"
        end

        it 'can have a ship' do
            cell = Cell.new("B4")

            expect(cell.ship).to eq nil
        end

        it 'is either empty or not' do
            cell = Cell.new("B4")

            expect(cell.empty?).to eq true
        end

    end

end
