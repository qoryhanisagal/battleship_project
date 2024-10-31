# lib/player.rb
require_relative './board'

class Player
  attr_reader :name, :board

  # Initialize with a name and board size
  def initialize(name, board_size)
    @name = name
    @board = Board.new(board_size, board_size) # Initializes a board with the specified size
  end

  # Method to fire a shot at the opponent's board
  def fire_shot(opponent_board, coordinate)
    if opponent_board.valid_coordinate?(coordinate) && !opponent_board.cells[coordinate].fired_upon?
      opponent_board.cells[coordinate].fire_upon
    else
      puts "Invalid coordinate or already fired upon. Try again."
    end
  end

  # Method to check if all player's ships are sunk
  def all_ships_sunk?
    board.cells.values.all? { |cell| cell.ship.nil? || cell.ship.sunk? }
  end
end