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
                
                if !cell.hit && !cell.ship 
                    row_visual = row_visual + '  '
                elsif cell.hit && !cell.ship
                    row_visual = row_visual + 'M '
                elsif cell.ship 
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
        cell.hit = true

        
        cell.ship = 'destroyed' if cell.ship == true
                
    
    end 
    
    def coordinate_converter(coordinates)
        letter = coordinates[0]
        letter = letter.upcase
        
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
        
        cell.ship = true  if not cell.ship?
            
        
            

    end 

    def get_cell (coordinates)
        letter_value, number_value = coordinate_converter(coordinates)
        
        cell = @cells[letter_value][number_value]
    
        return cell

    end 
    
    
    
    def computer_ship_placer(ship_size)
        count = 0
        letters = ('A'..'D').to_a
        numbers = (1..4).to_a
        until count == ship_size
            coordinates = computer_coordinate_selection(letters, numbers) 
        
            cell = get_cell(coordinates)
            
            if not cell.ship?
                cell.ship = true
                count +=1
                chosen_letter = coordinates[0]
                chosen_number = coordinates[1].to_i
                
                letters = next_cell_possibility_builder(letters, chosen_letter)
                numbers = next_cell_possibility_builder(numbers, chosen_number)
                
                
            end 
        end 
        

    end 
    
    def computer_coordinate_selection(letters = ('A'..'D').to_a, numbers = (1..4).to_a) 
        #this needs possibility arrays from function below. 
        letter = letters.sample
        number = numbers.sample
        coordinates = letter + number.to_s
        
        return coordinates
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

    def valid_coordinates(coordinates) #in progress
        #I want this method to take an input coordinate and return a list of all possible
        #coordinates in their two digit form
        # letters = ('A'..'D').to_a
        # numbers = (1..4).to_a
        # coordinate_letter = coordinates[0]
        # coordinate_number = coordinates[1]

        # y_possibilities = next_cell_possibility_builder(letters, coordinate_letter)
        # x_possibilities = next_cell_possibility_builder(numbers, coordinate_number)
        #should return an array of all possible values along each axis.
        #Put all of the possible combinations together and then exclude ones
        #that differ in both letter and number.


        
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

        array_permutations = array1.flat_map do |x|   
            
            array2.flat_map do |y|
                x.to_s + y.to_s 
            end 
        end 
        array_permutations
    end 

end 