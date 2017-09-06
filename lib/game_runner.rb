require './lib/board'
require './lib/game'

game = Game.new 
a = 1
b = 2
until a == b
    if game.phase == :welcome
        game.welcome_screen
    elsif game.phase == :ship_placement
        game.ship_placement_phase

    elsif game.phase == :main
        game.main_phase
    end 
end 