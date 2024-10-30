# spec/game_logic_spec.rb

require_relative '../lib/game_logic'
require_relative '../lib/board'
require_relative '../lib/ship'
require_relative '../lib/cell'
require_relative '../lib/computer_player'

RSpec.describe GameLogic do
  let(:game) { GameLogic.new }
  
  describe '#initialize' do
    it 'initializes with player and computer boards and ships' do
      expect(game.player1_board).to be_a(Board)
      expect(game.player2_board).to be_a(Board)
      expect(game.computer_board).to be_a(Board)
      expect(game.computer_player).to be_a(ComputerPlayer)
      expect(game.ships).to all(be_a(Ship))
      expect(game.winner).to be_nil
    end
  end

  describe '#start_game' do
    it 'displays the welcome message and calls main_menu' do
      expect(game).to receive(:puts).with("Welcome to BATTLESHIP!")
      expect(game).to receive(:main_menu)
      game.start_game
    end
  end

  describe '#main_menu' do
    before do
      allow(game).to receive(:puts)
      allow(game).to receive(:exit)
    end

    it 'starts single-player mode if input is "1"' do
      allow(game).to receive(:gets).and_return("1\n")
      expect(game).to receive(:setup_single_player_game)
      expect(game).to receive(:take_turn)
      game.main_menu
    end

    it 'starts two-player mode if input is "2"' do
      allow(game).to receive(:gets).and_return("2\n")
      expect(game).to receive(:setup_two_player_game)
      expect(game).to receive(:take_turns)
      game.main_menu
    end

    it 'exits if input is "q"' do
      allow(game).to receive(:gets).and_return("q\n")
      expect(game).to receive(:puts).with("Sorry to see you Leave. Thank you for playing. Goodbye!")
      game.main_menu
    end
  end

  describe '#setup_single_player_game' do
    it 'sets up single-player game, board size, ships, and difficulty' do
      allow(game).to receive(:puts)
      allow(game).to receive(:set_board_size)
      allow(game).to receive(:set_ships)
      allow(game).to receive(:set_game_difficulty)
      expect(game).to receive(:place_computer_ships)
      expect(game).to receive(:place_player_ships).with(game.player1_board)
      expect(game).to receive(:take_turn)
      game.setup_single_player_game
    end
  end

  describe '#setup_two_player_game' do
    it 'sets up the two-player game and prepares both players' do
      allow(game).to receive(:puts)
      allow(game).to receive(:set_board_size)
      allow(game).to receive(:set_ships)
      expect(game).to receive(:place_player_ships)
      expect(game).to receive(:take_turns)
      game.setup_two_player_game
    end
  end

  describe '#set_board_size' do
    it 'sets the board size for both players and computer' do
      allow(game).to receive(:puts)
      allow(game).to receive(:gets).and_return("4\n")
      game.set_board_size
      expect(game.player1_board.cells.length).to eq(16)
      expect(game.player2_board.cells.length).to eq(16)
      expect(game.computer_board.cells.length).to eq(16)
    end
  end

  describe '#set_ships' do
    it 'creates ships based on user input' do
      allow(game).to receive(:puts)
      allow(game).to receive(:gets).and_return("2\n", "Alpha", "2\n", "Bravo", "3\n")
      game.set_ships
      expect(game.ships.length).to eq(2)
      expect(game.ships.first.name).to eq("Alpha")
      expect(game.ships.first.length).to eq(2)
      expect(game.ships.last.name).to eq("Bravo")
      expect(game.ships.last.length).to eq(3)
    end
  end

  describe '#place_computer_ships' do
    it 'places ships randomly on the computer board' do
      allow(game).to receive(:valid_placement?).and_return(true)
      expect { game.place_computer_ships }.to change { game.computer_board.render(true) }
    end
  end

  describe '#take_turn' do
    context 'when in two-player mode' do
      before { game.instance_variable_set(:@two_player_mode, true) }
      
      it 'alternates turns between player 1 and player 2 until game over' do
        allow(game).to receive(:puts)
        allow(game).to receive(:player_turn)
        allow(game).to receive(:game_over?).and_return(false, false, true)
        
        expect(game).to receive(:player_turn).with(game.player1_board, game.player2_board).once
        expect(game).to receive(:player_turn).with(game.player2_board, game.player1_board).once
        game.take_turn
      end
    end

    context 'when in single-player mode' do
      before { game.instance_variable_set(:@two_player_mode, false) }

      it 'alternates between player and computer turns until game over' do
        allow(game).to receive(:puts)
        allow(game).to receive(:player_turn)
        allow(game).to receive(:computer_turn)
        allow(game).to receive(:game_over?).and_return(false, false, true)

        expect(game).to receive(:player_turn).with(game.player_board, game.computer_board).once
        expect(game).to receive(:computer_turn).once
        game.take_turn
      end
    end
  end

  describe '#game_over?' do
    it 'returns true if all ships on one player’s board are sunk' do
      allow(game).to receive(:all_ships_sunk?).and_return(true)
      expect(game.game_over?).to be true
    end
  end

  describe '#end_game' do
    it 'displays the correct win message' do
      allow(game).to receive(:main_menu)
      game.instance_variable_set(:@winner, "Player 1")
      expect(game).to receive(:puts).with("Congratulations, Player 1 wins!")
      game.end_game
    end
  end
end