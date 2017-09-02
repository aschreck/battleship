 require './lib/cell'
 #board is going to manage 1) the board itself. 2) where ships are. 
    # 3) mechanics of the shooting phase, altering properties of the cells
    class Board
        attr_accessor :cells
        def initialize 
            @cells = Array.new(4) {Array.new(4) {Cell.new}}
        end 
    
        def display_board
            #I have 4 arrays that each represent a row
            #iterate through each sub array
            puts "==========="
            puts ". 1 2 3 4"
            text_array = cells.map do |row|
                row_visual = ''
                row.each do |cell|
                    #case no hit 
                    if not cell.hit
                        row_visual = row_visual + ' '
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

        def take_a_shot(coordinates)

        end 


    end 