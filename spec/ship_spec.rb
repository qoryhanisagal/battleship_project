# spec/ship_spec.rb
# This file tests the functionality of the Ship class.
# It requires the 'spec_helper' to load the RSpec configuration.
require 'spec_helper'

require_relative '../lib/ship'

RSpec.configure do |config|
    config.formatter = :documentation
end

RSpec.describe Ship do
    describe '#initialize' do
        it 'exists' do
            cruiser = Ship.new('Cruiser', 3)

            expect(cruiser).to be_a Ship
        end
        
        it 'has a name' do
            cruiser = Ship.new('Cruiser', 3)

            expect(cruiser.name).to eq 'Cruiser'
        end

        it 'has length' do
            cruiser = Ship.new('Cruiser', 3)

            expect(cruiser.length).to eq 3
        end

        it 'has health' do
            cruiser = Ship.new('Cruiser', 3)
    
            expect(cruiser.health).to eq 3
        end

    end

    describe 'takes hits' do
        it 'takes one health away' do
            cruiser = Ship.new('Cruiser', 3)  
            cruiser.hit

            expect(cruiser.health).to eq 2
        end
    end

end