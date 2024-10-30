# lib/game_logic.rb
# Two Player Mode
require_relative './board'
require_relative './ship'
require_relative './cell'
require_relative './modules/placement_validator'
require_relative './modules/renderer'
require_relative './modules/guessing_strategy'
require_relative './modules/two_player_mode'
require_relative './computer_player'

# QD - The GameLogic class manages the overall game flow, coordinating turns, placements, and win/loss checks.
# JB - This class integrates separate modules for better modularity, including placement validation, rendering, and intelligent guessing.

class GameLogic
  include PlacementValidator   # Manages ship placement validation
  include Renderer             # Manages board rendering for each turn
  include GuessingStrategy     # Provides intelligent guessing for the computer’s moves
  include TwoPlayerMode        # Provides options for Two Player Mode

  attr_reader :player_board, :computer_board, :computer_player, :ships, :winner

  # Initializes the game setup with boards and ships.
  # QD - Sets up player and computer boards and default ships, preparing game state.
  # JB - Ensures initial setup is isolated, making it easier to modify board size and ship types if needed.
  def initialize
    @player1_board = Board.new
    @player2_board = Board.new
    @computer_board = Board.new
    @computer_player = ComputerPlayer.new(@computer_board)  # Instantiate the ComputerPlayer with the computer board
    @ships = [Ship.new("Cruiser", 3), Ship.new("Submarine", 2)]
    @winner = nil
    @two_player_mode = false # Changes based on game mode
    @player_board = @player1_board  # Makes `@player_board` available for single-player- mode
  end

  #### START GAME ####
  # QD - Displays a welcome message and initiates the main menu for player interaction.
  # JB - Allows players to start a new game or exit.
  def start_game
    puts "Welcome to BATTLESHIP!"
    main_menu
  end

    #### GAME SETUP ####
  # QD - Begins the game by setting up ship placements for both player and computer.
  # JB - Manages separate board setups, ensuring each player’s board is configured before gameplay.
  def play_game
    puts "Prepare for Battle!"
    place_computer_ships
    place_player_ships
    take_turn
  end

    ### Set Difficulty for the Game ####
  # QD - Prompts the player for difficulty and sets it on the ComputerPlayer instance.
  # JB - Delegates difficulty management to DifficultyHandler through ComputerPlayer.
  def set_game_difficulty
    puts "Select Difficulty: Enter 1 for Calm Seas (Easy), 2 for Rough Waters (Normal), 3 for War Zone Waters (Medium), 4 for Deep Abyss (Hard)"
    difficulty_choice = gets.chomp.to_i
    @computer_player.set_difficulty(difficulty_choice)  # Uses DifficultyHandler to set difficulty in ComputerPlayer
  end
  
  #### MAIN MENU ####
  # QD - Provides options to start or quit the game.
  # JB - Takes input from the player to either begin the game or end the session.
  def main_menu
    puts "Choose game mode: Enter 1 for Single Player, 2 for Two Player, or 'q' to quit."
    input = gets.chomp.downcase

    case input
    when "1"
      @two_player_mode = false # Handles single-player setup, including board size, ships, and difficulty
      setup_single_player_game                # Starts the game in single-player mode
      take_turn
    when "2"
      # Handles two-player setup from TwoPlayerMode, including board and ships
      @two_player_mode = true   
      setup_two_player_game     # Calls method from TwoPlayerMode to set up two-player mode
      take_turns                # Calls method from TwoPlayerMode to handle turns for two players
    when "q"
      puts "Sorry to see you Leave. Thank you for playing. Goodbye!"
      exit
    else
      puts "Invalid input. Please enter '1' for Single Player, '2' for Two Player, or 'q' to quit."
      main_menu
    end
  end

#### SINGLE PLAYER SETUP ####
# Sets up the single-player game with board size, ship setup, and difficulty.
def setup_single_player_game
  puts "You have selected Single Player mode."
  set_board_size         # Set board dimensions
  set_ships              # Allow user to define ships
  
  @player_board = player1_board 

  # Prompts difficulty level for single-player
  puts "Select Difficulty: Enter 1 for Calm Seas (Easy), 2 for Rough Waters (Normal), 3 for War Zone Waters (Medium), 4 for Deep Abyss (Hard)"
  set_game_difficulty    # Set game difficulty level

  puts "Prepare for Battle!"
  place_computer_ships   # Places ships for the computer
  place_player_ships(@player_board)     # Allows player to place ships
  take_turn # Begins gameplay loop
end

#### TWO PLAYER SETUP ####
# Sets up the two-player game, typically from TwoPlayerMode module.
def setup_two_player_game
  puts "You have selected Two Player mode."
  set_board_size         # Both players will use the same board size
  set_ships              # Players define ships, or default ships can be set up for both players
  
  puts "Players, prepare for battle!"
  place_player_ships     # Prompts each player to place ships

  take_turns             # Starts the turn loop for two-player mode
end

  #### SET BOARD SIZE ####
  # QD - Prompts the player to enter the desired board size.
  # JB - Adjusts the board size for both player and computer based on input.
  def set_board_size
    puts "Enter the board size (e.g., 4 for a 4x4 board, or 6 for a 6x6 board):"
    size = gets.chomp.to_i
    @player1_board = Board.new(size, size)
    @player2_board = Board.new(size, size)
    @computer_board = Board.new(size, size)
  end

  #### SET SHIPS ####
  # Allows players to define their own ships by entering names and lengths.
  def set_ships
    @ships = []
    puts "Enter the number of ships:"
    ship_count = gets.chomp.to_i

    ship_count.times do |i|
      puts "Enter the name of ship ##{i + 1}:"
      name = gets.chomp

      # Validates that the entered length is an integer
      length = nil
      loop do
        puts "Enter the length of #{name}:"
        length_input = gets.chomp
        if length_input.match?(/^\d+$/)  # Checks if input is a positive integer
          length = length_input.to_i
          break
        else
          puts "Invalid length. Please enter an integer value."
        end
      end

      @ships << Ship.new(name, length)
    end
  end

  ### Ship Place in the Board ####
  # Allows the player to manually place ships on their board.
  # QD - Guides the player through ship placement, with validations to prevent invalid entries.
  # JB - Ensures ships are placed on valid coordinates, using placement feedback.
  def place_player_ships
    puts "Now it's time to place your ships on the board!"
    @ships.each do |ship|
      valid = false
      until valid
        puts "Enter the coordinates for the #{ship.name} (#{ship.length} spaces):"
        coords = gets.chomp.upcase.split
        if valid_placement?(ship, coords, @player1_board)
          @player1_board.place(ship, coords)
          valid = true
        else
          puts "Those coordinates are invalid. Please try again."
        end
      end
    end
  end

  ### Random Ship Placement ###
  # Places ships for the computer on random, valid coordinates.
  # QD - Uses the valid_placement? method to ensure placements are correct.
  # JB - Randomizes ship placement to increase replayability.
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

  #### GAMEPLAY ####
  #### TAKE TURNS ####
  # Alternates turns between the player, computer, ot two player until one player's ships are sunk.
  # QD - Manages turn-based gameplay, switching between player and computer actions.
  # JB - Ends gameplay loop when win/loss conditions are met.
  # QD - Alternates turns based on the selected game mode.
  def take_turn
    if @two_player_mode
      # Two-player mode
      until game_over?
        puts "Player 1's Turn:"
        player_turn(@player1_board, @player2_board) # Player 1's turn
        break if game_over?

        puts "Player 2's Turn:"
        player_turn(@player2_board, @player1_board)# Player 2's turn
        break if game_over?
      end
    else
      # Single-player mode
      until game_over?
        player_turn(@player_board, @computer_board) # Single player's turn
        computer_turn unless game_over?
      end
    end
    end_game
  end

#### PLAYER TURN (Used in Both Modes) ####
def player_turn(player_board, opponent_board)
  # Determine if it's Player 1 or Player 2's turn in Two Player Mode
  player = player_board == @player1_board ? "Player 1" : "Player 2"
  puts "#{player}'s turn! Here's the opponent's board:"

  # Render the opponent's board without showing ships
  puts opponent_board.render(show_ships: false)
  puts "Enter the coordinate for your shot:"
  coordinate = gets.chomp.upcase

  # Check if the coordinate is valid and has not been fired upon
  if opponent_board.valid_coordinate?(coordinate) && !opponent_board.cells[coordinate].fired_upon?
    opponent_board.cells[coordinate].fire_upon
    puts feedback(opponent_board.cells[coordinate])
  else
    puts "Invalid coordinate or already fired upon. Try again."
    player_turn(player_board, opponent_board) # Recursive call for retry
  end
end
  #### COMPUTER TURN (Single Player Only) ####
  # Manages the computer’s turn, using intelligent guessing based on difficulty.
  # QD - Executes computer's move with calculated guessing strategy for a realistic AI.
  # JB - Uses DifficultyHandler to dynamically select a move based on set difficulty.
  def computer_turn
  puts "Computer's turn - choosing move based on difficulty..." # JB - Debugging statement
  coordinate = @computer_player.make_move  # Calls the computer player to make its calculated move
  puts "Computer chose coordinate #{coordinate}"  # QD - Confirm the selected coordinate
  @player_board.cells[coordinate].fire_upon
  puts "Opponent fired on #{coordinate}."
  puts feedback(@player_board.cells[coordinate])
  end
  
  # Provides feedback based on the shot outcome (miss, hit, or sunk).
  # QD - Returns a message indicating the result of the player’s or computer’s shot.
  # JB - Differentiates between hits, misses, and sunk ships to inform the player accurately.
  def feedback(cell)
    if cell.empty?
      "Miss!"
    elsif cell.ship.sunk?
      "Hit! You sunk the #{cell.ship.name}!"
    else
      "Hit!"
    end
  end

  #### WIN/LOSS CHECKS ####
  # Determines if all ships on the specified board have been sunk.
  # QD - Verifies all cells with ships are sunk to check for a win condition.
  # JB - Used in `game_over?` to assess if any player has won the game.
  def all_ships_sunk?(board)
    board.cells.values.all? do |cell|
      cell.ship.nil? || cell.ship.sunk?
    end
  end

#### GAME OVER CHECK ####
  # Determines if all ships of one player are sunk, ending the game.
  # QD - Sets @winner based on which board has all ships sunk.
  # JB - Manages win/loss conditions by verifying the state of each board’s ships.
  # QD - Verifies all cells with ships are sunk to check for a win condition.
  # JB - Used in `game_over?` to assess if any player has won the game.
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
      # Single-player mode checks
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
  #### END GAME ####
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

# Start the game if this file is run directly
if __FILE__ == $0
  game = GameLogic.new
  game.start_game
end