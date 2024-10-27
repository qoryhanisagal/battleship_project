require_relative '../lib/ship'
require_relative '../lib/cell'
require_relative '../lib/board'
# require_relative '../lib/player'
# holding spot for player creation

class Battleship
    def initialize
        @board = Board.new
        # @player = Player.new
        #holding place for new player
        
    end

    ## Start Game & Main Menu
    def start_game
        puts "Welcome to BATTLESHIP!"

        main_menu
    end

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

    def play_game
        puts "Let's get started!"

    end

end

Battleship.new.start_game