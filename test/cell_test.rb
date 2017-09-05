require 'minitest/autorun'
require './lib/cell'

class CellTest < Minitest::Test
    def test_cell_exists
        cell = Cell.new

        assert_instance_of Cell, cell
    end 

    def test_cell_reports_if_a_ship_rests_upon_it
        cell = Cell.new
        
        refute cell.ship? 
        
        cell.ship = true
        assert cell.ship?
        
    end 

end 