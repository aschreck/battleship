require 'minitest/autorun'
require './lib/board'
class BoardTest < Minitest::Test

    def test_it_exists
        board = Board.new
        assert_instance_of Board, board
    end 

    def test_converts_input_letter_to_array_value
        board = Board.new
        
        assert_equal 0, board.input_converter_for_shot('A')
    
    end 
   
    def test_it_takes_shots
        board = Board.new
        board.take_a_shot('A1') 
        board.take_a_shot('B2')
        board.take_a_shot('C3')
        board.display_board
    end 
    
    def test_prepends_letter_to_map
        board = Board.new
        array = ['a','b','c','d']
        letter1 = board.prepend_letter_to_map(array, 'a')
        letter2 = board.prepend_letter_to_map(array, 'b')
        letter3 = board.prepend_letter_to_map(array, 'c')
        letter4 = board.prepend_letter_to_map(array, 'd')
       
        assert_equal 'A ', letter1
        assert_equal 'B ', letter2
        assert_equal 'C ', letter3
        assert_equal 'D ', letter4

    end 
    def test_it_displays_hits_and_misses

    end

    
end 