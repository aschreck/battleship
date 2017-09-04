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
                    
                    if not cell.hit
                        row_visual = row_visual + '  '
                    elsif cell.hit && !cell.ship
                        row_visual = row_visual + 'M '
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
            #pass coordinates into converter
            letter_value, number_value = coordinate_converter(coordinates)

            cell = @cells[letter_value][number_value]
            if cell.ship = 'false'
                cell.ship = 'true'
            end  

        end 

        def computer_ship_placer(type)
            
            #randomly generate a coordinate and the arrays used to select it. 
            coordinates, letter_array, number_array = computer_coordinate_selection
 #Phase 1     #put down a ship—function has built in conversion
            place_a_ship(coordinates)
            
            next_letter_array = next_cell_possibility_builder(letter_array)
            next_number_array = next_cell_possibility_builder(number_array) 
            next_coordinates = computer_coordinate_selection(next_letter_array, next_number_array)

        end 
       
        def computer_coordinate_selection(letters = ('A'..'D').to_a, numbers = (1..4).to_a)
            #this needs possibility arrays from function below. 
            letter = letters.sample
            number = numbers.sample
            coordinates = letter + number.to_s
            
            return coordinates, letters, numbers
        end 


        def next_cell_possibility_builder (array, input)
            #given an array and coordinates, this function
            #returns an array of possible next placement locations
            #on that axis. 
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
    end 