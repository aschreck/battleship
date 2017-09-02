require 'minitest/autorun'
require './lib/cell'

class CellTest < Minitest::Test
    def test_cell_exists
        cell = Cell.new

        assert_instance_of Cell, cell
    end 
end 