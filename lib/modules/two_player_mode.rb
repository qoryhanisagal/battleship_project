# lib/modules/two_player_mode.rb

module TwoPlayerMode
  def setup_two_player_game
    puts "Welcome to Two-Player Battleship!"
    @player1 = Player.new("Player 1", @board_size)
    @player2 = Player.new("Player 2", @board_size)
    setup_ships(@player1)
    setup_ships(@player2)
  end

  def take_turns
    loop do
      player_take_turn(@player1, @player2)
      break if @player2.all_ships_sunk?

      player_take_turn(@player2, @player1)
      break if @player1.all_ships_sunk?
    end
    declare_winner
  end

  private

  def setup_ships(player)
    puts "#{player.name}, place your ships."
    # Logic for setting up ships for each player
  end

  def player_take_turn(player, opponent)
    puts "#{player.name}'s turn!"
    display_boards(player, opponent)

    puts "#{player.name}, enter your shot:"
    coordinate = gets.chomp.upcase
    player.fire_shot(opponent.board, coordinate)
    puts feedback(opponent.board.cells[coordinate])
  end

  def declare_winner
    if @player1.all_ships_sunk?
      puts "Congratulations, #{@player2.name} wins!"
    else
      puts "Congratulations, #{@player1.name} wins!"
    end
  end

  def display_boards(player, opponent)
    puts "Here's your board:"
    puts player.board.render(show_ships: true)
    puts "#{opponent.name}'s board (Hidden):"
    puts opponent.board.render(show_ships: false)
  end
end