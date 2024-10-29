# spec/computer_player_spec.rb
require_relative '../lib/computer_player'

RSpec.describe ComputerPlayer do
  before(:each) do
    @board = Board.new
    @computer_player = ComputerPlayer.new(@board)
    @ship = Ship.new("Cruiser", 3)
    @board.place(@ship, ["A1", "A2", "A3"])  # Ensuring correct placement for hit testing
  end

  describe '#make_move' do
    context 'when a ship is hit' do
      it 'adds adjacent cells to target queue upon hitting a ship' do
        # Fire upon "A1" to simulate a hit
        coordinate = "A1"
        @board.cells[coordinate].fire_upon
        @computer_player.update_strategy(coordinate, @ship) # Update strategy after hit
        
        # Expect specific adjacent cells to be in the target queue
        expect(@computer_player.target_queue).to include("A2", "B1")
        puts "Final target queue after hit on #{coordinate}: #{@computer_player.target_queue.inspect}"
      end
    end
  end

  describe '#calculate_next_move' do
    it 'chooses adjacent cells after a hit' do
      # Simulate hit at "A1" and update strategy to add adjacent cells
      @computer_player.update_strategy("A1", @ship)
      next_move = @computer_player.calculate_next_move

      # Check that the next move chosen is one of the adjacent cells
      expect(["A2", "B1"]).to include(next_move)
      puts "Next move calculated after hit on A1: #{next_move}"
    end
  end

  describe '#update_strategy' do
    context 'when a hit is recorded' do
      it 'adds valid adjacent cells to the target queue' do
        # Simulate a hit on "A1" and update strategy to add adjacent cells
        @computer_player.update_strategy("A1", @ship)

        # Expect adjacent cells around "A1" to be in the target queue
        expect(@computer_player.target_queue).to include("A2", "B1")
        puts "Target queue after adding adjacent cells around A1: #{@computer_player.target_queue.inspect}"
      end
    end

    context 'when a ship is sunk' do
      it 'clears the target queue after sinking a ship' do
        # Hit and sink the ship
        ["A1", "A2", "A3"].each do |coord|
          @board.cells[coord].fire_upon
          @computer_player.update_strategy(coord, @ship)
        end

        # Expect target queue to be cleared after the ship is sunk
        expect(@computer_player.target_queue).to be_empty
        puts "Target queue cleared after sinking the ship: #{@computer_player.target_queue.inspect}"
      end
    end
  end

  describe '#add_adjacent_cells_to_queue' do
    it 'only adds adjacent cells that are within board limits and unfired' do
      # Add adjacent cells for "A1" and check the queue
      @computer_player.add_adjacent_cells_to_queue("A1")

      # Expect specific unfired cells to be in the queue
      expect(@computer_player.target_queue).to include("A2", "B1")
      puts "Target queue after adding adjacent cells within limits around A1: #{@computer_player.target_queue.inspect}"
    end

    it 'does not add already fired-upon cells to the target queue' do
      # Simulate firing upon "A2" then try adding it to the queue
      @board.cells["A2"].fire_upon
      @computer_player.add_adjacent_cells_to_queue("A1")

      # Expect "A2" not to be in the queue as it's already fired upon
      expect(@computer_player.target_queue).not_to include("A2")
      puts "Target queue after attempting to add fired-upon cells: #{@computer_player.target_queue.inspect}"
    end
  end
end