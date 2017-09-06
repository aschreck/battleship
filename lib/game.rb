require './lib/board'

class Game
    attr_accessor :player_board, :computer_board, :phase
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
            @phase = :ship_placement
        elsif input == 'i' || input == 'instructions'
            #move to instruction page
        elsif input == 'q' || input == 'quit'
            exit
        else
            puts 'Invalid input!'
        end 
    end 

    def ship_placement_phase
        @computer_board.computer_ship_placer(2)
        @computer_board.computer_ship_placer(3)
        puts computer_ship_message
        #ask the player for her tiles
        
        first_ship_placement = ''
        until @player_board.coordinates_valid?(first_ship_placement)
            puts "Enter the squares for the two unit ship."
        first_ship_placement = gets.chomp.upcase
        #check if these coordinates are valid 
        
            if @player_board.coordinates_valid?(first_ship_placement)
                coordinate_array = first_ship_placement.split(' ')
                first_coordinate = coordinate_array[0]
                second_coordinate = coordinate_array[1]
                
                @player_board.place_a_ship(first_coordinate)
                @player_board.place_a_ship(second_coordinate) 
            end 
        
        end 
        
        second_ship_placement = ''
        until @player_board.coordinates_valid?(second_ship_placement)
        puts "Please enter the squares for your second ship"
            second_ship_placement = gets.chomp.upcase
            if @player_board.coordinates_valid?(second_ship_placement)
                coordinate_array = second_ship_placement.split(' ')
                first_coordinate = coordinate_array[0]
                second_coordinate = coordinate_array[1]
                @player_board.place_a_ship(first_coordinate)
                @player_board.place_a_ship(second_coordinate) 
            end
        end 
        @phase = :main
    end 
    
    def main_phase
        victor = :nobody
        count = 0
        #the player is shooting at the computer board and vice_versa
        until victor == :human || victor == :computer
        #player shooting phase
        @computer_board.display_board
        puts "Man the gunwales! It's time to take a shot! Enter your coordinate:"
        print ">"
        player_shot = gets.chomp
        @computer_board.take_a_shot(player_shot)

        #computer shooting phase
        @player_board.computer_shot
        #check if anyone's count == 0    
            
        victor = :human if @computer_board.count_ships == 0
        victor = :computer if @player_board.count_ships == 0
        count += 1
        end 
        
        if victor == :human
            puts "Congratulations! You defeated the computer in #{count} turns!"
            exit
        else 
            puts "Bummer. You were defeated by the dumbest AI imaginable in #{count} turns."
            exit
        end 

    end 



    def computer_ship_message
        message = """
        I have laid out my ships on the grid.
        You now need to layout your two ships.
        The first is two units long and the
        second is three units long.
        The grid has A1 at the top left and D4 at the bottom right.
        """
    end 
end 

