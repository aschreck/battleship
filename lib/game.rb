require './lib/board'

class Game
    attr_accessor :player_board, :computer_board, :phase
    def initialize
        @player_board = Board.new
        @computer_board = Board.new
        @phase = 'welcome'
    end 

    def welcome_screen
        puts """
        Welcome to BATTLESHIP

        Would you like to (p)lay, read the (i)nstructions, 
        or (q)uit?
        >"
        input = gets.chomp.downcase
        
        if input == 'p' || input == 'play'
            #transition into ship-placement phase. 
            @phase = :place_ships
        elsif input == 'i' || input == 'instructions'
            #move to instruction page
        elsif input == 'q' || input == 'quit'
            #close the program
        else
            puts 'Invalid input!'
        end 
    end 

    def ship_placement_phase
        @computer_board.computer_ship_placer(2)
        @computer_board.computer_ship_placer(3)
        puts computer_ship_message
        
        first_ship_placement = gets.chomp.upcase
      
    
    end 
    




    def computer_ship_message
        message = """
        I have laid out my ships on the grid.
        You now need to layout your two ships.
        The first is two units long and the
        second is three units long.
        The grid has A1 at the top left and D4 at the bottom right.

        Enter the squares for the two-unit ship:
        """

    end 
end 

