require 'minitest/autorun'
require './lib/game'
require './lib/board'

class BoardTest < Minitest::Test

    def test_initializes_with_two_boards
        game = Game.new
        game.computer_board.display_board
        game.player_board.display_board
        
    end 


end 


