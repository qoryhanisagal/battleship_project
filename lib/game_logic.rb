# lib/game_logic.rb
# Initial Setup include Two Player Mode
require_relative './board'
require_relative './ship'
require_relative './cell'
require_relative './modules/placement_validator'
require_relative './modules/renderer'
require_relative './modules/guessing_strategy'
require_relative './modules/two_player_mode'
require_relative './computer_player'
require_relative './player.rb'

class GameLogic
  include PlacementValidator
  include Renderer
  include GuessingStrategy
  include TwoPlayerMode

  attr_reader :player1_board, :player2_board, :computer_board, :computer_player, :ships, :winner, :two_player_mode, :player1, :player2

  def initialize
    @player1_board = Board.new
    @player2_board = Board.new
    @computer_board = Board.new
    @ships = [Ship.new("Cruiser", 3), Ship.new("Submarine", 2)]
    @winner = nil
    @two_player_mode = false
    @player_board = @player1_board
    @player1 = Player.new("Player 1", 4)  # Example size, customize as needed
    @player2 = Player.new("Player 2", 4)
    @computer_player = ComputerPlayer.new(@computer_board) # Ensure @computer_board is initialized before this
    # Initialize the rest of your game state here
  end


  def start_game
    puts "Welcome to BATTLESHIP!"
    main_menu
  end

  def set_game_difficulty
    puts "Select Difficulty: Enter 1 for Calm Seas (Easy), 2 for Rough Waters (Normal), 3 for War Zone Waters (Medium), 4 for Deep Abyss (Hard)"
    difficulty_choice = gets.chomp.to_i
    @computer_player.set_difficulty(difficulty_choice)
  end
  
  def main_menu
    puts "Choose game mode: Enter 1 for Single Player, 2 for Two Player, or 'q' to quit."
    input = gets.chomp.downcase

    case input
    when "1"
      @two_player_mode = false
      setup_single_player_game
      take_turn
    when "2"
      @two_player_mode = true
      setup_two_player_game
      take_turns
    when "q"
      puts "Sorry to see you Leave. Thank you for playing. Goodbye!"
      exit
    else
      puts "Invalid input. Please enter '1' for Single Player, '2' for Two Player, or 'q' to quit."
      main_menu
    end
  end

  def play_game
    puts "Prepare for Battle!"
    place_computer_ships
    place_player_ships(@player1_board)
    take_turn
  end

  def setup_single_player_game
    puts "You have selected Single Player mode."
    set_board_size         # Set the board dimensions
    set_ships              # Define the ships for the player
  
    @player_board = @player1_board 
  
    # Prompt for difficulty level in single-player mode
    puts "Select Difficulty: Enter 1 for Calm Seas (Easy), 2 for Rough Waters (Normal), 3 for War Zone Waters (Medium), 4 for Deep Abyss (Hard)"
    set_game_difficulty    # Set game difficulty level
  
    puts "Prepare for Battle!"
    place_computer_ships   # Places ships for the computer
    
    # Place player's ships on their board
    place_player_ships(@player1_board, "Player 1", @ships)
  
    take_turn              # Start the game loop
  end

  def setup_two_player_game
    puts "You have selected Two Player mode."
    set_board_size                     # Set board size for both players
    @player1 = Player.new("Player 1", @player1_board)
    @player2 = Player.new("Player 2", @player2_board)
    
    # Define ships for each player
    puts "Player 1, define your ships."
    set_ships                          # Set ships for Player 1, stored in @ships
  
    puts "Player 2, define your ships."
    set_ships_for_player2              # Set ships for Player 2, stored in @ships_player2
  
    puts "Players, prepare for battle!"
  
    # Place ships on each player’s board
    place_player_ships(@player1_board, "Player 1", @ships)
    place_player_ships(@player2_board, "Player 2", @ships_player2)
  
    take_turns                         # Start the game loop for two players
  end

  def set_board_size
    puts "Enter the board size (e.g., 4 for a 4x4 board, or 6 for a 6x6 board):"
    size = gets.chomp.to_i
    @player1_board = Board.new(size, size)
    @player2_board = Board.new(size, size)
    @computer_board = Board.new(size, size)
  end

  def set_ships
    @ships = []
    puts "Enter the number of ships:"
    @num_ships = gets.chomp.to_i

    @num_ships.times do |i|
      puts "Enter the name of ship ##{i + 1}:"
      name = gets.chomp

      length = nil
      loop do
        puts "Enter the length of #{name}:"
        length_input = gets.chomp
        if length_input.match?(/^\d+$/)
          length = length_input.to_i
          break
        else
          puts "Invalid length. Please enter an integer value."
        end
      end

      @ships << Ship.new(name, length)
    end
  end

  def set_ships_for_player2
    @ships_player2 = []
    (1..@num_ships).each do |i|
      puts "Enter the name of ship ##{i} for Player 2:"
      name = gets.chomp

      length = nil
      loop do
        puts "Enter the length of #{name}:"
        length_input = gets.chomp
        if length_input.match?(/^\d+$/)
          length = length_input.to_i
          break
        else
          puts "Invalid length. Please enter an integer value."
        end
      end
      @ships_player2 << Ship.new(name, length)
    end
  end

  def place_player_ships(board, player_name, ships)
    puts "#{player_name}, Now it's time to place your ships on the board!"
    ships.each do |ship|
      valid = false
      until valid
        puts "#{player_name}, Enter the coordinates for the #{ship.name} (#{ship.length} spaces):"
        coords = gets.chomp.upcase.split
        if valid_placement?(ship, coords, board)
         board.place(ship, coords)
          valid = true
        else
          puts "Those coordinates are invalid. Please try again."
        end
      end
    end
  end

  def place_computer_ships
    @ships.each do |ship|
      placed = false
      until placed
        coords = @computer_board.random_coordinates_for(ship)
        if valid_placement?(ship, coords, @computer_board)
          @computer_board.place(ship, coords)
          placed = true
        end
      end
    end
  end

  def take_turn
    if @two_player_mode
      until game_over?
        puts "Player 1's Turn:"
        player_turn(@player1, @player2.board)
        break if game_over?
  
        puts "Player 2's Turn:"
        player_turn(@player2, @player1.board)
        break if game_over?
      end
    else
      until game_over?
        puts "Your Turn:"
        player_turn(@player1, @computer_board)
        computer_turn unless game_over?
      end
    end
    end_game
  end

  def player_turn(player, opponent_board)
    puts "#{player.name}'s turn! Here's the opponent's board:"
    puts opponent_board.render(show_ships: false)

    puts "Enter the coordinate for your shot:"
    coordinate = gets.chomp.upcase

    if opponent_board.valid_coordinate?(coordinate) && !opponent_board.cells[coordinate].fired_upon?
      opponent_board.cells[coordinate].fire_upon
      puts feedback(coordinate, opponent_board)
    else
      puts "Invalid coordinate or already fired upon. Try again."
      player_turn(player, opponent_board)
    end
  end

  def feedback(coordinate, board)
    cell = board.cells[coordinate]
    if cell.nil?
      "Invalid shot"
    elsif cell.empty?
      "Miss!"
    elsif cell.ship.sunk?
      "Hit! You sunk the #{cell.ship.name}!"
    else
      "Hit!"
    end
  end

  def computer_turn
    puts "Computer's turn - choosing move based on difficulty..."
    coordinate = @computer_player.make_move
    puts "Computer chose coordinate #{coordinate}"
    @player_board.cells[coordinate].fire_upon
    puts "Opponent fired on #{coordinate}."
    puts feedback(coordinate, @player_board)
  end

  def all_ships_sunk?(board)
    board.cells.values.all? do |cell|
      cell.ship.nil? || cell.ship.sunk?
    end
  end

  def game_over?
    if @two_player_mode
      if all_ships_sunk?(@player1_board)
        @winner = "Player 2"
        true
      elsif all_ships_sunk?(@player2_board)
        @winner = "Player 1"
        true
      else
        false
      end
    else
      if all_ships_sunk?(@computer_board)
        @winner = "player"
        true
      elsif all_ships_sunk?(@player_board)
        @winner = "computer"
        true
      else
        false
      end
    end
  end

  def end_game
    if @two_player_mode
      puts "Congratulations, #{@winner} wins!"
    else
      if @winner == "player"
        puts "Congratulations, you won!"
      elsif @winner == "computer"
        puts "You lost! The computer won!"
      end
    end
    main_menu
  end
end

if __FILE__ == $0
  game = GameLogic.new
  game.start_game
end