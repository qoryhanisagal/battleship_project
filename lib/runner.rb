# lib/runner.rb

# Require necessary dependencies, including the main game logic and supporting classes
require_relative '../lib/game_logic'
require_relative '../lib/ship'
require_relative '../lib/cell'
require_relative '../lib/board'

# Initialize and start the GameLogic instance to manage the game
# QD - The GameLogic class should manage all primary game functions, including setup, turn-taking, and end-game conditions.
# JB - GameLogic is configured to interact with supporting classes like Ship, Board, and Cell to facilitate gameplay.

game = GameLogic.new
game.start_game


## For Iterations 1-3
# # The Battleship class manages the overall structure and flow of the game.
# class Battleship
#   attr_reader :player_board, :computer_board, :ships

#   # QD - Initializes the game with ships for each player and sets up boards.
#   def initialize
#     @ships = [Ship.new("Cruiser", 3), Ship.new("Submarine", 2)]
#     @player_board = Board.new       # Board for the human player.
#     @computer_board = Board.new     # Board for the computer.
#   end

#   ####START####
#   # QD - Starts the game with a welcome message and main menu.
#   def start_game
#     puts "Welcome to BATTLESHIP!"
#     main_menu
#   end

#   ####MAIN MENU####
#   # Main menu allows the player to start or quit the game.
#   def main_menu
#     puts "Enter p to play. Enter q to quit."
#     input = gets.chomp.downcase

#     case input
#     when "p"
#       play_game
#     when "q"
#       puts "Thank you for playing. Goodbye!"
#       exit
#     else
#       puts "Invalid input. Please enter 'p' to play or 'q' to quit."
#       main_menu
#     end
#   end

#   ####SETUP####
#   # Sets up the game by placing ships for both computer and player.
#   def play_game
#     puts "Let's get started!"
#     place_computer_ships
#     place_player_ships
#   end

#   # Places ships randomly on the computer's board.
#   def place_computer_ships
#     @ships.each do |ship|
#       placed = false
#       until placed
#         coords = @computer_board.random_coordinates_for(ship)  # Random coordinates
#         puts "Generated coordinates for #{ship.name}: #{coords.join(', ')}" # Log generated coordinates
#         if @computer_board.valid_placement?(ship, coords)
#           @computer_board.place(ship, coords)
#           placed = true
#         end
#       end
#     end
#   end

#   # Guides the player through placing their ships on the board.
#   def place_player_ships
#     puts "Now it's time to place your ships on the board!"
#     @ships.each do |ship|
#       valid = false
#       until valid
#         puts "Enter the coordinates for the #{ship.name} (#{ship.length} spaces):"
#         coords = gets.chomp.upcase.split
#         if @player_board.valid_placement?(ship, coords)
#           @player_board.place(ship, coords)
#           valid = true
#         else
#           puts "Those coordinates are invalid. Please try again."
#         end
#       end
#     end
#     take_turn
#   end

#   ####GAME PLAY/THE TURN####
#   # QD - Alternates turns until one player’s ships are sunk.
#   def take_turn
#     until game_over?
#       player_turn
#       computer_turn unless game_over?  # Prevents computer turn if player wins.
#     end
#     end_game
#   end

#   # Manages the player’s turn.
#   def player_turn
#     puts "Your turn! Here's the computer's board:"
#     puts @computer_board.render
#     puts "Enter the coordinate for your shot:"
#     coordinate = gets.chomp.upcase

#     if @computer_board.valid_coordinate?(coordinate) && !@computer_board.cells[coordinate].fired_upon?
#       @computer_board.cells[coordinate].fire_upon
#       puts feedback(@computer_board.cells[coordinate])
#     else
#       puts "Invalid coordinate or already fired upon. Try again."
#       player_turn
#     end
#   end

#   # Manages the computer’s turn.
#   def computer_turn
#     coordinate = @player_board.random_unfired_coordinate
#     @player_board.cells[coordinate].fire_upon
#     puts "Computer fired on #{coordinate}."
#     puts feedback(@player_board.cells[coordinate])
#   end

#   # Provides feedback on the result of a shot (miss, hit, sunk).
#   def feedback(cell)
#     if cell.empty?
#       "Miss!"
#     elsif cell.ship.sunk?
#       "Hit! You sunk the #{cell.ship.name}!"
#     else
#       "Hit!"
#     end
#   end

# # Checks if either player’s ships are all sunk, ending the game.
# def game_over?
#     # Check if all computer's ships are sunk (player win)
#     if @computer_board.cells.values.select(&:ship).all? { |cell| cell.ship.sunk? }
#       @winner = "player"
#       true
#     # Check if all player's ships are sunk (computer win)
#     elsif @player_board.cells.values.select(&:ship).all? { |cell| cell.ship.sunk? }
#       @winner = "computer"
#       true
#     else
#       false
#     end
# end

#   ####GAME OVER####
#   # Ends the game and announces the winner.
#   def end_game
#     if @winner == "player"
#       puts "Congratulations, you won!"
#     elsif @winner == "computer"
#       puts "You lost! The computer won!"
#     end
#     main_menu
#   end
# end

# # Starts the game when the script is run.
# # Initialize and start the game
# game = GameLogic.new
# game.start_game
# Battleship.new.start_game if __FILE__ == $PROGRAM_NAME
# # starts new game @ ruby lib/runner.rb