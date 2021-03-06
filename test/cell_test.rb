require_relative "./test_helper"
require './lib/cell'

class CellTest < Minitest::Test
    def test_cell_exists
        cell = Cell.new

        assert_instance_of Cell, cell
    end 

    def test_cell_reports_if_a_ship_rests_upon_it
        cell = Cell.new
        
        refute cell.ship? 
        
        cell.state = :ship
        assert cell.ship?        
    end 

end 