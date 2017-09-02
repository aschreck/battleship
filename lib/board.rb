 require './lib/cell'
 #board is going to manage 1) the board itself. 2) where ships are. 
    # 3) mechanics of the shooting phase, altering properties of the cells
    class Board
        attr_accessor :cells
        def initialize 
            @cells = Array.new(4) {Array.new(4) {Cell.new}}
        end 
    end 