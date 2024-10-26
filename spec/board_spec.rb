# spec/ship_spec.rb
# This file tests the functionality of the Board class.
# It requires the 'spec_helper' to load the RSpec configuration.
require 'spec_helper'

# Your tests go here...
RSpec.configure do |config|
    config.formatter = :documentation
end

RSpec.describe Board do
    describe '#initialize' do
        it 'exists' do
            board = Board.new
            expect(board).to be_a Board
        end

        it 'has 16 cells at instantiation' do
            board = Board.new

            expect(board.cells.count).to eq 16
        end

    end

    describe 'coordinate validation' do
        it 'returns true if coordinates have been created' do
            board = Board.new

            expect(board.valid_coordinate?("A1")).to eq true
            expect(board.valid_coordinate?("D4")).to eq true
        end

        it 'returns false if coordinates do not exist' do
            board = Board.new

            expect(board.valid_coordinate?("D5")).to eq false
            expect(board.valid_coordinate?("E1")).to eq false
            expect(board.valid_coordinate?("A22")).to eq false
        end
    end

    describe '#valid_placement' do
        it 'returns false if ship length != number of coordinates' do
            board = Board.new
            cruiser = Ship.new("Cruiser", 3)
            submarine = Ship.new("Submarine", 2)  

            expect(board.valid_placement?(cruiser, ["A1", "A2"])).to eq false
            expect(board.valid_placement?(submarine, ["A2", "A3", "A4"])).to eq false
        end

        it 'returns false if coordinates are not consecutive' do
            board = Board.new
            cruiser = Ship.new("Cruiser", 3)
            submarine = Ship.new("Submarine", 2)  

            expect(board.valid_placement?(cruiser, ["A1", "A2", "A4"])).to eq false
            expect(board.valid_placement?(submarine, ["A1", "C1"])).to eq false
            expect(board.valid_placement?(cruiser, ["A3", "A2", "A1"])).to eq false
            expect(board.valid_placement?(submarine, ["C1", "B1"])).to eq false
        end

        xit 'returns false if coordinates are diagonal' do
            board = Board.new
            cruiser = Ship.new("Cruiser", 3)
            submarine = Ship.new("Submarine", 2)  

            expect(board.valid_placement?(cruiser, ["A1", "B2", "C3"])).to eq false
            expect(board.valid_placement?(submarine, ["C2", "D3"])).to eq false
        end

        xit 'returns true if ship placement is valid' do
            board = Board.new
            cruiser = Ship.new("Cruiser", 3)
            submarine = Ship.new("Submarine", 2) 
            
            expect(board.valid_placement?(submarine, ["A1", "A2"])).to eq true
            expect(board.valid_placement?(cruiser, ["B1", "C1", "D1"])).to eq true
        end
    end
end

