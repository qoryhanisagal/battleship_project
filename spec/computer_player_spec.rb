# spec/computer_player_spec.rb

require 'rspec'
require './lib/computer_player'
require './lib/board'
require './lib/ship'
require './lib/cell'

RSpec.configure do |config|
  config.formatter = :documentation
end

# Spec for ComputerPlayer class
RSpec.describe ComputerPlayer do
  before(:each) do
    # Sets up a new board and computer player for testing
    @board = Board.new
    @computer_player = ComputerPlayer.new(@board)
    @ship = Ship.new("Cruiser", 3)
    @board.place(@ship, ["A1", "A2", "A3"]) # Place ship on the board for testing
  end

  describe '#initialize' do
    it 'initializes with an empty target queue and a board' do
      # Confirms the computer player initializes correctly with empty target queue
      expect(@computer_player.board).to eq(@board)
      expect(@computer_player.target_queue).to be_empty
    end
  end

  describe '#make_move' do
    context 'when there are no previous hits' do
      it 'fires on a random unfired coordinate' do
        # Ensures make_move works without tracked hits
        coordinate = @computer_player.make_move
        expect(@board.cells[coordinate].fired_upon?).to be true
      end
    end

    context 'when a ship is hit' do
      it 'adds adjacent cells to target queue upon hitting a ship' do
        # Fire at "A1" to simulate a hit, then check for queued cells
        coordinate = "A1"
        @board.cells[coordinate].fire_upon
        @computer_player.update_strategy(coordinate, true)

        # Confirms target queue is populated after a hit
        expect(@computer_player.target_queue).not_to be_empty
      end
    end
  end

  describe '#calculate_next_move' do
    it 'chooses adjacent cells after a hit' do
      # Manually updates strategy to add targets around "A1"
      @computer_player.update_strategy("A1", true)
      next_move = @computer_player.calculate_next_move

      # Ensures the next move is one of the adjacent cells
      expect(["A2", "B1"]).to include(next_move)
    end

    it 'fires on a new cell when target queue is empty' do
      # Ensures that a move can be made with an empty queue
      next_move = @computer_player.calculate_next_move
      expect(@board.cells[next_move].fired_upon?).to be true
    end
  end

  describe '#update_strategy' do
    context 'when a hit is recorded' do
      it 'adds valid adjacent cells to the target queue' do
        # Simulates hitting "A1" and updating strategy
        @computer_player.update_strategy("A1", true)

        # Checks that valid adjacent cells are added
        expect(@computer_player.target_queue).to include("A2", "B1")
      end
    end

    context 'when a ship is sunk' do
      it 'clears the target queue after sinking a ship' do
        # Simulate hitting cells of the ship until sunk
        ["A1", "A2", "A3"].each do |coord|
          @computer_player.update_strategy(coord, true)
          @board.cells[coord].fire_upon
        end
        # Clears target queue once the ship is sunk
        expect(@computer_player.target_queue).to be_empty
      end
    end
  end

  describe '#add_adjacent_cells_to_queue' do
    it 'only adds adjacent cells that are within board limits and unfired' do
      # Updates strategy to target adjacent cells to a corner cell "A1"
      @computer_player.add_adjacent_cells_to_queue("A1")

      # Ensures only valid, unfired adjacent cells are added
      expect(@computer_player.target_queue).to include("A2", "B1")
      expect(@computer_player.target_queue).not_to include("A0", "B0") # Out of bounds
    end

    it 'does not add already fired-upon cells to the target queue' do
      # Fires on "A2" and then attempts to add it to the queue
      @board.cells["A2"].fire_upon
      @computer_player.add_adjacent_cells_to_queue("A1")

      # Ensures "A2" is not added since it was already fired upon
      expect(@computer_player.target_queue).not_to include("A2")
    end
  end
end