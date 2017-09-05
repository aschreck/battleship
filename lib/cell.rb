class Cell
    attr_accessor :ship, :hit
    #I need cell to store whether there's a ship and whether that ship has been hit 
    def initialize
        @ship = false
        @hit = false
    end 

    def ship?   
        if @ship == false
            false
        else
            true  
        end 
        
    end 

end 