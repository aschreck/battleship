require_relative "./test_helper"
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
   
        board = Board.new
        board.take_a_shot('A2') 
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

        board.display_board
    end

    def test_random_coordinates
        board = Board.new
        possible_shots = %w(A1 B2 C3 D4)
        shot = board.computer_coordinate_selection(possible_shots)

        assert possible_shots.include?(shot)         
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
    
    
    def test_array_permutations
     
        board = Board.new
        numbers = (1..2).to_a
        letters = ('A'..'B').to_a
        array = board.array_permutations(letters, numbers)
        expected_array = ['A1', 'A2', 'B1', 'B2']
        
        assert_equal expected_array, array 
    end 
    
    def test_takes_coordinates_and_returns_all_possibilities
     
        board = Board.new
        letter_axis_possibilities, number_axis_possibilities = board.coordinate_to_possibilities('A3')
        
        assert_equal ['A', 'B'], letter_axis_possibilities
        assert_equal [2, 3, 4], number_axis_possibilities
    end 
    
    def test_array_permutations_can_return_list_of_all_possible_coordinates_not_arrays
        
        board = Board.new
        letter_axis_possibilities, number_axis_possibilities = board.coordinate_to_possibilities('A3')
        bloated_possible = board.array_permutations(letter_axis_possibilities, number_axis_possibilities)
        
        assert_equal ['A2','A3', 'A4', 'B2', 'B3', 'B4'], bloated_possible
    end 
    
    def test_eliminate_impossible_coordinates
        
        board = Board.new
        letter_axis_possibilities, number_axis_possibilities = board.coordinate_to_possibilities('A3')
        bloated_possible = board.array_permutations(letter_axis_possibilities, number_axis_possibilities)
        
        
        assert_equal ['A2', 'A4', 'B3'] , board.eliminate_invalid_coordinates(bloated_possible, 'A3')
        
    end 
    
    def test_it_generates_all_possible_cells
        skip
        board = Board.new
        
        all_cells = ['A1','A2','A3','A4','B1','B2','B3','B4','C1','C2','C3','C4','D1','D2','D3','D4']
        assert_equal all_cells, board.generate_all_cells
    end 
    
    def test_input_coordinate_return_array_of_real_possibilities
        
        board = Board.new
        possibilities = board.coordinate_to_possible_coordinates('B2')
        assert_equal ['A2','B1', 'B3', 'C2'],possibilities
    end 
    
    def test_computer_ship_placement
        board = Board.new
        board.computer_ship_placer(2)
        board.computer_ship_placer(3)
        
        board.display_board
    end    

    def test_can_determine_if_player_ship_selections_are_valid
        board = Board.new
        assert board.coordinates_valid?('A1 A2')
        refute board.coordinates_valid?('A1 B2')
    end 

    def test_it_can_count_ships
        board = Board.new

        board.computer_ship_placer(2)

        assert_equal 2, board.count_ships 

    end 
    
    def test_it_can_count_a_whole_board
        board = Board.new

        board.computer_ship_placer(2)
        board.computer_ship_placer(3)

        assert_equal 5, board.count_ships

    end 

    def test_shooting_ships_reduces_the_count
        board = Board.new

        board.cells[0][0].state = :ship
        board.cells[0][1].state = :ship

        assert_equal 2, board.count_ships
        board.take_a_shot('A1')
        board.take_a_shot('A2')

        assert_equal 0, board.count_ships

    end 

    def test_computer_randomly_shoots
        board = Board.new
        
        board.computer_shot
        board.computer_shot
        board.display_board
    end 


end