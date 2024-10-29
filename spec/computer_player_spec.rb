# spec/computer_player_spec.rb

require 'rspec'
require './lib/computer_player'
require './lib/board'
require './lib/ship'
require './lib/cell'

RSpec.describe ComputerPlayer do
  before(:each) do
    @board = Board.new
    @computer_player = ComputerPlayer.new(@board)
    @ship = Ship.new("Cruiser", 3)
    @board.place(@ship, ["A1", "A2", "A3"])  # Place a ship to test hits
  end

  describe '#initialize' do
    it 'initializes with an empty target queue and a board' do
      expect(@computer_player.board).to eq(@board)
      expect(@computer_player.target_queue).to be_empty
    end
  end

  describe '#make_move' do
    it 'fires on a random coordinate when no hits are tracked' do
      coordinate = @computer_player.make_move
      expect(@board.cells[coordinate].fired_upon?).to be true
    end

    it 'adds adjacent cells to queue when a ship is hit' do
      coordinate = "A1"
      @computer_player.make_move
      if @board.cells[coordinate].ship
        @computer_player.update_strategy(coordinate, true)
      end
      expect(@computer_player.target_queue).not_to be_empty
    end
  end

  describe '#calculate_next_move' do
    it 'selects adjacent cells after a hit' do
      # Simulate a hit on "A1"
      @computer_player.update_strategy("A1", true)
      next_move = @computer_player.calculate_next_move
      expect(["A2", "B1"]).to include(next_move)
    end
  end
end