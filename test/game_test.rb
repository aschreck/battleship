require_relative "./test_helper"
require './lib/game'
require './lib/board'

class BoardTest < Minitest::Test

    def test_initializes_with_two_boards
        game = Game.new
        game.computer_board.display_board
        game.player_board.display_board
        
    end 

    def test_it_can_place_a_ship_within_the_board
        game = Game.new
        game.player_board.place_a_ship('A1')

        game.player_board.display_board
        
    end

end 


