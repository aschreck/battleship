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
                        row_visual = row_visual + 'M'
                    else 
                        row_visual = row_visual + 'H'
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
            letter = coordinates[0]
            number = coordinates[1]
            
            letter_value = input_converter_for_shot(letter)
            number_value = number.to_i - 1 
            
            cell = @cells[letter_value][number_value]
            cell.hit = true

            
            cell.ship = 'destroyed' if cell.ship == true
                 
        
        end 
        
        def input_converter_for_shot(letter)
            letter = letter.upcase
            input_hash = {
                'A'=> 0,
                'B'=> 1,
                'C'=> 2,
                'D'=> 3
            }
            
            return input_hash[letter]
        end 
    end 