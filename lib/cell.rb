class Cell
    attr_accessor :state, :hit
    #I need cell to store whether there's a ship and whether that ship has been hit 
    def initialize
        @state = :empty
        @hit = :no
    end 

    def ship?   
        if @state == :ship
            true
        else
            false
        end 
        
    end 

end 