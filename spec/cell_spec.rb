# spec/cell_spec.rb
# This file tests the functionality of the Cell class.
# It requires the 'spec_helper' to load the RSpec configuration.
require 'spec_helper'

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

        it 'does not have a ship' do
            cell = Cell.new("B4")

            expect(cell.ship).to eq nil
        end

        it 'has not been fired upon' do
            cell = Cell.new("B4")

            expect(cell.fired_upon?).to eq false
        end
    end
    
    describe 'behaviors' do
        it 'can be empty' do
            cell = Cell.new("B4")

            expect(cell.empty?).to eq true
        end

        it 'can place a ship' do
            cell = Cell.new("B4")
            cruiser = Ship.new("Cruiser", 3)

            cell.place_ship(cruiser)

            expect(cell.empty?).to be false
        end  
        
        it 'can be fired upon' do
            cell = Cell.new("B4")
            cruiser = Ship.new("Cruiser", 3)
            
            cell.place_ship(cruiser)

            cell.fire_upon

            expect(cell.ship.health).to eq 2
        end
    end

    describe '#render' do
        it 'identifies a cell' do
            cell_1 = Cell.new("B4")
        
            expect(cell_1.render).to eq '.'
        end
######### STOPPED HERE, want to talk about how we want to code misses
        it 'marks a missed shot' do
            cell_1 = Cell.new("B4")

            cell_1.fire_upon
            
            expect(cell_1.render).to eq 'M'
        end

        it 'marks a ship that is hit' do
            
    end
end
