require './lib/cell'
#board is going to manage 1) the board itself. 2) where ships are. 
    # 3) mechanics of the shooting phase, altering properties of the cells
class Board
    attr_accessor :cells
    def initialize 
        @cells = Array.new(4) {Array.new(4) {Cell.new}}
    end 

    
    def display_board
        
        puts "==========="
        puts ". 1 2 3 4"
        
        text_array = cells.map do |row| #don't need this map
            
            row_visual = ''
            row_visual = row_visual + prepend_letter_to_map(@cells, row ) 
            
            row.each do |cell|
                
                if cell.state == :empty && cell.hit == :no
                    row_visual = row_visual + '  '
                elsif cell.state == :empty && cell.hit == :yes
                    row_visual = row_visual + 'M '
                elsif cell.state == :ship && cell.hit == :no
                    row_visual = row_visual + 'S '
                else 
                    row_visual = row_visual + 'H '
                end 
            end 
            
            puts row_visual   
        
        end  
        
        puts "==========="
    end 

    def prepend_letter_to_map(array, row)
        index_value = array.index(row)
        
        if index_value == 0
            return 'A '
        elsif index_value == 1
            return 'B '
        elsif index_value == 2
            return 'C '
        else 
            return 'D '
        end 

    end 

    
    def take_a_shot(coordinates)
        #add edge case for invalid input 
        
    
        letter_value, number_value = coordinate_converter(coordinates)
        cell = @cells[letter_value][number_value]
        cell.hit = :yes

        
        cell.state == :destroyed if cell.state == :ship
            
    
    end 
    
    def coordinate_converter(coordinates)
        letter = coordinates[0]
        letter = letter.upcase if letter.class == String
        
        number_value = coordinates[1].to_i - 1
        
        input_hash = {
            'A'=> 0,
            'B'=> 1,
            'C'=> 2,
            'D'=> 3
        }
        
        return input_hash[letter],number_value
    end 

    
    def place_a_ship(coordinates)
        
        cell = get_cell(coordinates)
        
        cell.state == :ship if cell.state == :empty
            
        
    end 

    def get_cell (coordinates)
        letter_value, number_value = coordinate_converter(coordinates)
        
        cell = @cells[letter_value][number_value]
    
        return cell

    end 
    
    
    
    def computer_ship_placer(ship_size)
        count = 0
        available_cells = generate_all_cells
        until count == ship_size
            #choose a coordinate from a single array. 
            coordinates = computer_coordinate_selection(available_cells) 
            
            cell = get_cell(coordinates)
            
            unless cell.ship?
                cell.state = :ship
                count +=1
                #redefine available_cells to go back into the loop.
                available_cells = coordinate_to_possible_coordinates(coordinates)
                
                
                
            end 
        end 
        

    end 
    
   
    def computer_coordinate_selection(array)
        selection = array.sample
        selection
    end 

    def computer_shot
        all_cells = generate_all_cells
        selection = computer_coordinate_selection(all_cells)
        take_a_shot(selection)
    end 
   

    def generate_all_cells
        letters = ('A'..'D').to_a
        numbers = (1..4).to_a
        all_cells = array_permutations(letters, numbers)
    end 

    def next_cell_possibility_builder (array, input)

        input = input.to_i if input == '1' || input == '2' || input == '3' || input == '4'
        
        n = array.index(input)
        
    
        
        if n == 0
            new_array = array[0..1]
        elsif n == 3
            new_array = array[2..3]
        else
            new_array = array[n-1..n+1]
        end 
        
        return new_array

    end  

    

    def coordinate_to_possibilities(coordinates, letters = ('A'..'D').to_a, numbers = (1..4).to_a)
        #take a coordinate, and return all the possible next positions. 
        
        letter = coordinates[0]
        number = coordinates[1]
        
        #this will give me two arrays that contain the possibilities by axis. 
        letter_axis_possibilities = next_cell_possibility_builder(letters, letter)
        number_axis_possibilities = next_cell_possibility_builder(numbers, number)

        return letter_axis_possibilities, number_axis_possibilities
    end 
    
    def array_permutations(array1, array2)
        #letter array should always go first
        array_permutations = array1.flat_map do |x|   
            
            array2.flat_map do |y|
                x.to_s + y.to_s 
            end 
        end 
        array_permutations
    end 

    def eliminate_invalid_coordinates(possibility_array, original_coordinate)
        lean_array = []
        possibility_array.each do |coordinate| #will be a 2 char string
            diff_count = 0
            original_letter = original_coordinate[0]
            original_number = original_coordinate[1]
            letter = coordinate[0]
            number = coordinate[1]
            diff_count += 1 unless original_letter == letter
            diff_count += 1 unless original_number == number

            lean_array << coordinate if diff_count == 1
        end 
        return lean_array
    end


    def coordinate_to_possible_coordinates(coordinates)
        return if coordinates == ''
        letter_possibilities, number_possibilities = coordinate_to_possibilities(coordinates)
        bloated_possibles = array_permutations(letter_possibilities, number_possibilities)
        lean_possibles = eliminate_invalid_coordinates(bloated_possibles, coordinates)
        
        return lean_possibles
    end 

    def coordinates_valid?(coordinates) #take in a pair of coordinates
        return if coordinates == ''
        coordinate_array = coordinates.split(' ')
        possible_coordinates = coordinate_to_possible_coordinates(coordinate_array[0])
        #check if the second coordinate is among those possible coordinates
        return possible_coordinates.include?(coordinate_array[1])

    end

    def count_ships
        count = 0
        @cells.each do |row|
            row.each {|cell| count += 1 if cell.state == :ship && cell.hit == :no}
        end 
        count
    end


end 