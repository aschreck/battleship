require 'minitest/autorun'
require './lib/board'
class BoardTest < Minitest::Test

    def test_it_exists
        board = Board.new
        assert_instance_of Board, board
    end 

    def test_converts_input_letter_to_array_value
        board = Board.new
        
        assert_equal 0,0 , board.coordinate_converter('A1')
    
    end 
   
    def test_it_takes_shots
        skip
        board = Board.new
        board.take_a_shot('A2') 
        board.take_a_shot('B2')
        board.take_a_shot('C3')
        board.display_board_board
    end 
    
    def test_prepends_letter_to_map
        skip
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
   
    def test_it_display_boards_hits_and_misses
        skip
        board = Board.new
        board.place_a_ship('A2')
        board.take_a_shot('A2')
        board.place_a_ship('B1')
        board.take_a_shot('B1')
        board.place_a_ship('C3')
        board.take_a_shot('C3')
        board.take_a_shot('C4')

        # display_board =
        # '==========='
        # '. 1 2 3 4  '
        # 'A   H      '
        # 'B H        '
        # 'C     H M  '
        # 'D          '
        # '==========='
        

        board.display_board

    
    end

    def test_random_coordinates
        skip 
        board = Board.new
         puts board.computer_coordinate_selection 
         puts board.computer_coordinate_selection 
    end 

    def test_next_cell_builds_new_possibility_arrays
        
        board = Board.new
        char_array = ('A'..'D').to_a
        num_array = (1..4).to_a
        possibility_array1 = board.next_cell_possibility_builder(char_array, 'B')
        possibility_array2 = board.next_cell_possibility_builder(num_array, 3)
        edge_possibility1 = board.next_cell_possibility_builder(char_array, 'A')
        edge_possibility2 = board.next_cell_possibility_builder(char_array, 'D')

        assert_equal ['A', 'B', 'C'], possibility_array1
        assert_equal [2, 3, 4], possibility_array2
        assert_equal ['A', 'B'], edge_possibility1
        assert_equal ['C', 'D'], edge_possibility2
   
    end 
   
    def test_new_possibility_builder
        board = Board.new
        numbers = (1..4).to_a
        letters = ('A'..'D').to_a
        
        assert_equal [1, 2], board.next_cell_possibility_builder(numbers, 1)        
        assert_equal [1, 2, 3], board.next_cell_possibility_builder(numbers, 2)  
        assert_equal [2, 3, 4], board.next_cell_possibility_builder(numbers, 3)  
        assert_equal [3, 4], board.next_cell_possibility_builder(numbers, 4) 
        assert_equal ['A', 'B'], board.next_cell_possibility_builder(letters, 'A')  
        assert_equal ['A', 'B', 'C'], board.next_cell_possibility_builder(letters, 'B')  
        assert_equal ['B', 'C', 'D'], board.next_cell_possibility_builder(letters, 'C')  
        assert_equal ['C', 'D'], board.next_cell_possibility_builder(letters, 'D')  
    end 
    
    def test_computer_ship_placement
        board = Board.new
        board.computer_ship_placer(2)
        
        board.display_board
        
        
    end    
    
    
end 