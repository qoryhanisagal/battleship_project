require_relative '../lib/ship'
require_relative '../lib/cell'
require_relative '../lib/board'

class Battleship
    attr_reader :ships

    def initialize
        @ships = [Ship.new("Cruiser", 3), Ship.new("Submarine", 2)]
    end

    ####START####
    def start_game
        puts "Welcome to BATTLESHIP!"

        main_menu
    end

    ####MAIN MENU####
    def main_menu
        puts "Enter p to play. Enter q to quit."
        input = gets.chomp.downcase

        if input == "p"
            play_game
         elsif input == "q"
            puts "Thank you for playing. Goodbye!"
            exit
         else
            puts "Invalid input..."
            puts " Enter p to play. Enter q to quit."
        end
    end

    ####SETUP####
    def play_game
        puts "Let's get started!"
      
        place_computer_ships
        place_player_ships
    end

    def place_computer_ships
        comp_board = Board.new
        # will need a way to randomize ship placement on computer's board
    end
        
    def place_player_ships
        player_board = Board.new
        # player can now place ships on their new board
        
        take_turn
        #moves on to game play once code is run
    end

    ####GAME PLAY/THE TURN####
    def take_turn
        # display boards-- player can see their ships but NOT computer's 

        #player input coordinate choice

        #computer randomized coordinate choice

        #report result of player's shot

        #report result of computer's shot

        #loop until both of either computer or player's ships are sunk

        end_game
        #once someone's ships have sunk, take to final step of game
    end

    ####GAME OVER####
    def end_game
        #declare winner-- computer says "You won!" or "I won!"

        main_menu
        #after game is over, return player to main menu
    end

end

Battleship.new.start_game
#starts new game @ ruby lib/runner.rb