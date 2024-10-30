# Game Logic Code Setup Options

``` ruby
# lib/game_logic.rb

require_relative './board'
require_relative './ship'
require_relative './cell'
require_relative './modules/placement_validator'
require_relative './modules/renderer'
require_relative './modules/guessing_strategy'
require_relative './computer_player'

# QD - The GameLogic class manages the overall game flow, coordinating turns, placements, and win/loss checks.
# JB - This class integrates separate modules for better modularity, including placement validation, rendering, and intelligent guessing.

class GameLogic
  include PlacementValidator   # Manages ship placement validation
  include Renderer             # Manages board rendering for each turn
  include GuessingStrategy     # Provides intelligent guessing for the computer’s moves

  attr_reader :player_board, :computer_board, :computer_player, :ships, :winner

  # Initializes the game setup with boards and ships.
  # QD - Sets up player and computer boards and default ships, preparing game state.
  # JB - Ensures initial setup is isolated, making it easier to modify board size and ship types if needed.
  def initialize
    @player_board = Board.new
    @computer_board = Board.new
    @computer_player = ComputerPlayer.new(@computer_board)  # Instantiate the ComputerPlayer with the computer board
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
      select_difficulty
      play_game
    when "q"
      puts "Thank you for playing. Goodbye!"
      exit
    else
      puts "Invalid input. Please enter 'p' to play or 'q' to quit."
      main_menu
    end
  end
  
  ### Select Diificulty ####
  
  def select_difficulty
    puts "Select Difficulty: Enter 1 for Easy, 2 for Medium, 3 for Hard"
    difficulty = gets.chomp.to_i
    case difficulty
    when 1
      @computer_player.difficulty = :easy
    when 2
      @computer_player.difficulty = :medium
    when 3
      @computer_player.difficulty = :hard
    else
      puts "Invalid choice. Defaulting to Medium."
      @computer_player.difficulty = :medium
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

  ##### For Placing Computer Ships #####

  def place_computer_ships
    @ships.each do |ship|
      placed = false
      until placed
        coords = @computer_board.random_coordinates_for(ship)
        if valid_placement?(ship, coords, @computer_board)  # Pass board here
          @computer_board.place(ship, coords)
          placed = true
        end
      end
    end
  end

  # Allows the player to manually place ships on their board.
  # QD - Guides the player through ship placement, with validations to prevent invalid entries.
  # JB - Ensures ships are placed on valid coordinates, using placement feedback.

   ##### For Placing Player Ships #####

  def place_player_ships
    puts "Now it's time to place your ships on the board!"
    @ships.each do |ship|
      valid = false
      until valid
        puts "Enter the coordinates for the #{ship.name} (#{ship.length} spaces):"
        coords = gets.chomp.upcase.split
        if valid_placement?(ship, coords, @player_board)  # Pass board here
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

  def player_turn
    puts "Your turn! Here's the computer's board:"
    puts @computer_board.render(show_ships: false)  # Call render on @computer_board instance
    puts "Enter the coordinate for your shot:"
    coordinate = gets.chomp.upcase
  
    if @computer_board.valid_coordinate?(coordinate) && !@computer_board.cells[coordinate].fired_upon?
      @computer_board.cells[coordinate].fire_upon
      puts feedback(@computer_board.cells[coordinate])
    else
      puts "Invalid coordinate or already fired upon. Try again."
      player_turn
    end
  end

##### For Computer's Turn#####

# Manages the computer’s turn using an intelligent guessing strategy.
# QD - Computer uses the GuessingStrategy module to make educated shots.
# JB - Implements targeted guessing based on previous hits for more realistic AI behavior.
def computer_turn
  coordinate = @computer_player.make_move  # Calls the computer player to make its calculated move
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

# Determines if all ships on the specified board have been sunk.
# QD - Verifies all cells with ships are sunk to check for a win condition.
# JB - Used in `game_over?` to assess if any player has won the game.
def all_ships_sunk?(board)
  board.cells.values.all? do |cell|
    cell.ship.nil? || cell.ship.sunk?
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
# Let's Get this Party Started!!

if __FILE__ == $0
  game = GameLogic.new
  game.start_game
end
```

# Options Before Two Player Mode
```ruby
# lib/game_logic.rb

require_relative './board'
require_relative './ship'
require_relative './cell'
require_relative './modules/placement_validator'
require_relative './modules/renderer'
require_relative './modules/guessing_strategy'
require_relative './computer_player'

# QD - The GameLogic class manages the overall game flow, coordinating turns, placements, and win/loss checks.
# JB - This class integrates separate modules for better modularity, including placement validation, rendering, and intelligent guessing.

class GameLogic
  include PlacementValidator   # Manages ship placement validation
  include Renderer             # Manages board rendering for each turn
  include GuessingStrategy     # Provides intelligent guessing for the computer’s moves

  attr_reader :player_board, :computer_board, :computer_player, :ships, :winner

  # Initializes the game setup with boards and ships.
  # QD - Sets up player and computer boards and default ships, preparing game state.
  # JB - Ensures initial setup is isolated, making it easier to modify board size and ship types if needed.
  def initialize
    @player_board = Board.new
    @computer_board = Board.new
    @computer_player = ComputerPlayer.new(@computer_board)  # Instantiate the ComputerPlayer with the computer board
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
      set_board_size      # Prompts the user to set the board size.
      set_ships           # Prompts the user to set up the ships.
      set_game_difficulty   # Allows the user to select the game difficulty.
      play_game           # Starts the game after setup.
    when "q"
      puts "Thank you for playing. Goodbye!"
      exit
    else
      puts "Invalid input. Please enter 'p' to play or 'q' to quit."
      main_menu
    end
  end

  #### SET BOARD SIZE ####
  # QD - Prompts the player to enter the desired board size.
  # JB - Adjusts the board size for both player and computer based on input.
  def set_board_size
    puts "Enter the board size (e.g., 4 for a 4x4 board, or 6 for a 6x6 board):"
    size = gets.chomp.to_i
    @player_board = Board.new(size, size)
    @computer_board = Board.new(size, size)
  end

  #### SET SHIPS ####
  # QD - Allows players to define their own ships by entering names and lengths.
  # JB - Creates custom ships based on player input for more personalized gameplay.
  def set_ships
    @ships = []
    puts "Enter the number of ships:"
    ship_count = gets.chomp.to_i
    ship_count.times do |i|
      puts "Enter the name of ship ##{i + 1}:"
      name = gets.chomp
      puts "Enter the length of #{name}:"
      length = gets.chomp.to_i
      @ships << Ship.new(name, length)
    end
  end

  ### Set Difficulty for the Game ####
  # QD - Prompts the player for difficulty and sets it on the ComputerPlayer instance.
  # JB - Delegates difficulty management to DifficultyHandler through ComputerPlayer.
  def set_game_difficulty
    puts "Select Difficulty: Enter 1 for Calm Seas (Easy), 2 for Rough Waters (Normal), 3 for War Zone Waters (Medium), 4 for Deep Abyss (Hard)"
    difficulty_choice = gets.chomp.to_i
    @computer_player.set_difficulty(difficulty_choice)  # Uses DifficultyHandler to set difficulty in ComputerPlayer
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
        if valid_placement?(ship, coords, @computer_board)
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
        if valid_placement?(ship, coords, @player_board)
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
      computer_turn unless game_over?
    end
    end_game
  end

  def player_turn
    puts "Your turn! Here's the computer's board:"
    puts @computer_board.render(show_ships: false)
    puts "Enter the coordinate for your shot:"
    coordinate = gets.chomp.upcase
  
    if @computer_board.valid_coordinate?(coordinate) && !@computer_board.cells[coordinate].fired_upon?
      @computer_board.cells[coordinate].fire_upon
      puts feedback(@computer_board.cells[coordinate])
    else
      puts "Invalid coordinate or already fired upon. Try again."
      player_turn
    end
  end

  ##### For Computer's Turn #####
  # Manages the computer’s turn using an intelligent guessing strategy.
  # QD - Computer uses the GuessingStrategy module to make educated shots.
  # JB - Implements targeted guessing based on previous hits for more realistic AI behavior.
  def computer_turn
    coordinate = @computer_player.make_move  # Calls the computer player to make its calculated move
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

  # Determines if all ships on the specified board have been sunk.
  # QD - Verifies all cells with ships are sunk to check for a win condition.
  # JB - Used in `game_over?` to assess if any player has won the game.
  def all_ships_sunk?(board)
    board.cells.values.all? do |cell|
      cell.ship.nil? || cell.ship.sunk?
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

# Start the game if this file is run directly
if __FILE__ == $0
  game = GameLogic.new
  game.start_game
end
```
# Understanding the  `length_input.match?(/^\d+$/)`
#### Purpose of length_input.match?(/^\d+$/) in Set Ships (Iteration 4)
 Problem: 
#### SET SHIPS ####
# QD - Allows players to define their own ships by entering names and lengths.
# JB - Ensures ships are created with valid lengths by adding integer validation for length input.
``` ruby
def set_ships
  # Initialize an empty array to store ship objects created by the player
  @ships = []
  
  # Prompt the player to enter the number of ships they would like to create
  puts "Enter the number of ships:"
  ship_count = gets.chomp.to_i  # Converts input to an integer to determine the loop count
  
  # Loop for each ship to prompt for ship details (name and length)
  ship_count.times do |i|
    # Ask for the name of the ship
    puts "Enter the name of ship ##{i + 1}:"
    name = gets.chomp  # Stores ship name input from the player

    # Length validation loop
    # Initializes length as nil, setting up to validate it in the next steps
    length = nil
    loop do
      # Prompt the player to enter the length of the ship
      puts "Enter the length of #{name}:"
      length_input = gets.chomp  # Temporarily stores the input as a string for validation
      
      # Check if the input is a valid positive integer
      if length_input.match?(/^\d+$/)
        # Converts the validated input to an integer and assigns it to length
        length = length_input.to_i
        break  # Exits the loop once a valid length is entered
      else
        # Provides feedback if the input is invalid, asking for integer-only input
        puts "Invalid length. Please enter an integer value."
      end
    end

    # After validation, create a new Ship object and add it to the @ships array
    @ships << Ship.new(name, length)
  end
end
```
This line is a way to check that the player’s input for the ship length is:

1.	A **positive whole number** (no decimals or negative numbers).
2.	Contains **only digits** (no letters or special characters).

#### Breaking Down the Regular Expression /^\d+$/
**Per VS Code Extension and Ruby Docs**

Regular expressions (regex) can be intimidating at first, but they’re just patterns used to match text. Here’s what each part of /^\d+$/ means:

- ^: This symbol means “start of the string.” It ensures we’re matching from the very beginning of the input.
- \d: This represents “any digit” (0 through 9). In regex, \d is shorthand for any digit.
- +: This means “one or more” of the previous item. So \d+ means “one or more digits.”
- $: This means “end of the string,” ensuring we’re matching up to the end.

#### Putting it together:

- /^\d+$/ matches a string that:
- Starts (^) with one or more digits (\d+).
- Ends with those digits ($), with no extra characters before or after.

In simpler terms, it’s a way to confirm that the input is only a whole number, like 2, 15, or 123.

## In Qorys' brain: 

### Party Rules (or, “What the Regex Checks For”)

1.	Only people who arrive alone (one uninterrupted group) are allowed in.
2.	Each person must be a positive whole number (like 2, 15, or 123). No decimals, negative numbers, or letters are allowed.

### Breaking Down the Criteria

Let’s see how the bouncer applies each rule.

- ^ **(The “Start” Rule):**
The bouncer checks each guest as they start arriving, making sure they come in a single group with no gaps.
- \d **(The “Only Digits” Rule):**
The bouncer only allows people who are pure digits (like 0, 1, 2, 3…9) through the door. If someone tries to get in with letters, symbols, or spaces, they’re turned away.
- + **(The “One or More Digits” Rule):**
The bouncer expects to see at least one digit—so empty strings can’t get in. It’s okay if more than one digit arrives, but it has to be at least one.
- $ **(The “End” Rule):**
Once the person is inside, the bouncer ensures no extra characters follow them. If anyone tries to sneak in with extra stuff tacked onto the end, they’re stopped.

**So, What’s the Result?**

With all these checks, only guests who are positive whole numbers—like 2, 15, or 123—make it past the bouncer. People with letters ("abc"), negative signs ("-4"), or spaces ("12 34") are turned away, as they don’t meet the strict criteria of starting and ending as digits only.

This is why the code length_input.match?(/^\d+$/) ensures we’re only letting valid, positive, whole numbers through!

# Role Two Player:

`` ruby
# lib/game_logic.rb
#Two Player Mode
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
    @player_board = Board.new
    @computer_board = Board.new
    @computer_player = ComputerPlayer.new(@computer_board)  # Instantiate the ComputerPlayer with the computer board
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
    puts "Choose game mode: Enter 1 for Single Player, 2 for Two Player, or 'q' to quit."
    input = gets.chomp.downcase

    case input
    when "1"
      setup_single_player_game # Handles single-player setup, including board size, ships, and difficulty
      play_game                # Starts the game in single-player mode
    when "2"
      setup_two_player_game    # Handles two-player setup from TwoPlayerMode, including board and ships
      take_turns               # Starts the game in two-player mode
    when "q"
      puts "Sorry to see you Leave.Thank you for playing. Goodbye!"
      exit
    else
      puts "Invalid input. Please enter '1' for Single Player, '2' for Two Player, or 'q' to quit."
      main_menu
    end
  end

  #### SINGLE PLAYER SETUP ####
  # JB - Sets up the single-player game with board size, ship setup, and difficulty.
  def setup_single_player_game
    set_board_size         # Set board dimensions
    set_ships              # Allow user to define ships
    set_game_difficulty    # Set game difficulty level
  end

  #### TWO PLAYER SETUP ####
  # QD - Sets up the two-player game, typically from TwoPlayerMode module.
  def setup_two_player_game
    set_board_size         # Both players will use the same board size
    set_ships              # Players define ships, or default ships can be set up for both players
  end

  #### SET BOARD SIZE ####
  # QD - Prompts the player to enter the desired board size.
  # JB - Adjusts the board size for both player and computer based on input.
  def set_board_size
    puts "Enter the board size (e.g., 4 for a 4x4 board, or 6 for a 6x6 board):"
    size = gets.chomp.to_i
    @player_board = Board.new(size, size)
    @computer_board = Board.new(size, size)
  end

#### SET SHIPS ####
# Allows players to define their own ships by entering names and lengths.
# Ensures ships are created with valid lengths by adding validation to prevent invalid input.
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

  ### Set Difficulty for the Game ####
  # QD - Prompts the player for difficulty and sets it on the ComputerPlayer instance.
  # JB - Delegates difficulty management to DifficultyHandler through ComputerPlayer.
  def set_game_difficulty
    puts "Select Difficulty: Enter 1 for Calm Seas (Easy), 2 for Rough Waters (Normal), 3 for War Zone Waters (Medium), 4 for Deep Abyss (Hard)"
    difficulty_choice = gets.chomp.to_i
    @computer_player.set_difficulty(difficulty_choice)  # Uses DifficultyHandler to set difficulty in ComputerPlayer
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
        if valid_placement?(ship, coords, @player_board)
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
      computer_turn unless game_over?
    end
    end_game
  end

  def player_turn
    puts "Your turn! Here's your opponent's board:"
    puts @computer_board.render(show_ships: false)
    puts "Enter the coordinate for your shot:"
    coordinate = gets.chomp.upcase
  
    if @computer_board.valid_coordinate?(coordinate) && !@computer_board.cells[coordinate].fired_upon?
      @computer_board.cells[coordinate].fire_upon
      puts feedback(@computer_board.cells[coordinate])
    else
      puts "Invalid coordinate or already fired upon. Try again."
      player_turn
    end
  end

  ##### For Computer's Turn #####
  # Manages the computer’s turn using an intelligent guessing strategy.
  # QD - Computer uses the GuessingStrategy module to make educated shots.
  # JB - Implements targeted guessing based on previous hits for more realistic AI behavior.
  def computer_turn
    coordinate = @computer_player.make_move  # Calls the computer player to make its calculated move
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

  # Determines if all ships on the specified board have been sunk.
  # QD - Verifies all cells with ships are sunk to check for a win condition.
  # JB - Used in `game_over?` to assess if any player has won the game.
  def all_ships_sunk?(board)
    board.cells.values.all? do |cell|
      cell.ship.nil? || cell.ship.sunk?
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

# Start the game if this file is run directly
if __FILE__ == $0
  game = GameLogic.new
  game.start_game
end
```