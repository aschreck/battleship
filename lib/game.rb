class Game

    def initialize 
        @player_board = Board.new
        @computer_board = Board.new
        @phase = :welcome
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

    

end 

