# lib/game_logic.rb

require_relative './board'
require_relative './ship'
require_relative './cell'
require_relative './modules/placement_validator'
require_relative './modules/renderer'
require_relative './modules/guessing_strategy'

# QD - The GameLogic class manages the overall game flow, coordinating turns, placements, and win/loss checks.
# JB - This class integrates separate modules for better modularity, including placement validation, rendering, and intelligent guessing.

class GameLogic
  include PlacementValidator   # Manages ship placement validation
  include Renderer             # Manages board rendering for each turn
  include GuessingStrategy     # Provides intelligent guessing for the computer’s moves

  attr_reader :player_board, :computer_board, :ships, :winner

  # Initializes the game setup with boards and ships.
  # QD - Sets up player and computer boards and default ships, preparing game state.
  # JB - Ensures initial setup is isolated, making it easier to modify board size and ship types if needed.
  def initialize
    @player_board = Board.new
    @computer_board = Board.new
    @ships = [Ship.new("Cruiser", 3), Ship.new("Submarine", 2)]
    @winner = nil
  end

  #### START GAME ####
  # QD - Displays a welcome message and initiates the main menu for player interaction.
  # JB - Allows players to start a new game or exit.
  def start_game
    puts "Welcome to BATTLESHIP!"
    main_menu
  end

  #### MAIN MENU ####
  # QD - Provides options to start or quit the game.
  # JB - Takes input from the player to either begin the game or end the session.
  def main_menu
    puts "Enter p to play. Enter q to quit."
    input = gets.chomp.downcase

    case input
    when "p"
      play_game
    when "q"
      puts "Thank you for playing. Goodbye!"
      exit
    else
      puts "Invalid input. Please enter 'p' to play or 'q' to quit."
      main_menu
    end
  end

  #### GAME SETUP ####
  # QD - Begins the game by setting up ship placements for both player and computer.
  # JB - Manages separate board setups, ensuring each player’s board is configured before gameplay.
  def play_game
    puts "Let's get started!"
    place_computer_ships
    place_player_ships
    take_turn
  end

  # Places ships for the computer on random, valid coordinates.
  # QD - Uses the valid_placement? method to ensure placements are correct.
  # JB - Randomizes ship placement to increase replayability.
  def place_computer_ships
    @ships.each do |ship|
      placed = false
      until placed
        coords = @computer_board.random_coordinates_for(ship)
        if valid_placement?(ship, coords)
          @computer_board.place(ship, coords)
          placed = true
        end
      end
    end
  end

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
        if valid_placement?(ship, coords)
          @player_board.place(ship, coords)
          valid = true
        else
          puts "Those coordinates are invalid. Please try again."
        end
      end
    end
  end

  #### GAMEPLAY ####
  # Alternates turns between the player and computer until one player's ships are sunk.
  # QD - Manages turn-based gameplay, switching between player and computer actions.
  # JB - Ends gameplay loop when win/loss conditions are met.
  def take_turn
    until game_over?
      player_turn
      computer_turn unless game_over?  # Prevents extra computer turn if player wins
    end
    end_game
  end

  # Manages the player’s turn by allowing them to fire at the computer’s board.
  # QD - Displays the computer's board state and takes player input for the shot.
  # JB - Ensures valid coordinates are targeted and avoids repeated shots on the same cell.
  def player_turn
    puts "Your turn! Here's the computer's board:"
    puts render(@computer_board, show_ships: false)
    puts "Enter the coordinate for your shot:"
    coordinate = gets.chomp.upcase

    if valid_coordinate?(coordinate, @computer_board) && !@computer_board.cells[coordinate].fired_upon?
      @computer_board.cells[coordinate].fire_upon
      puts feedback(@computer_board.cells[coordinate])
    else
      puts "Invalid coordinate or already fired upon. Try again."
      player_turn
    end
  end

  # Manages the computer’s turn using an intelligent guessing strategy.
  # QD - Computer uses the GuessingStrategy module to make educated shots.
  # JB - Implements targeted guessing based on previous hits for more realistic AI behavior.
  def computer_turn
    coordinate = next_guess(@player_board) # From GuessingStrategy module
    @player_board.cells[coordinate].fire_upon
    puts "Computer fired on #{coordinate}."
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
  # Determines if all ships of one player are sunk, ending the game.
  # QD - Sets @winner based on which board has all ships sunk.
  # JB - Manages win/loss conditions by verifying the state of each board’s ships.
  def game_over?
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

  #### END GAME ####
  # Ends the game and announces the winner.
  # QD - Displays the final game result and returns to the main menu.
  # JB - Concludes the game loop and resets for potential new games.
  def end_game
    if @winner == "player"
      puts "Congratulations, you won!"
    elsif @winner == "computer"
      puts "You lost! The computer won!"
    end
    main_menu
  end
end