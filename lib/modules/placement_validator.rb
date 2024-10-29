# lib/modules/placement_validator.rb
# lib/modules/placement_validator.rb

module PlacementValidator
  # Validates ship placement based on length, alignment, and lack of overlap.
  # QD - Verifies that placement aligns with rules and checks cells for overlap.
  # JB - Ensures that a ship’s placement adheres to board constraints.
  def valid_placement?(ship, coordinates, board)
    return false unless ship.length == coordinates.length
    return false unless consecutive_coordinates?(coordinates)
    return false if overlapping_ships?(coordinates, board)
    
    true
  end

  # Checks if any cells are already occupied by another ship.
  # QD - Avoids overlap by examining each cell for an existing ship.

  def overlapping_ships?(coordinates, board)
  # Checks for overlapping ships by accessing the correct cells on the board.
    coordinates.any? { |coord| @board.cells[coord]&.ship }  # Access @board.cells
  end

  # Checks if coordinates are consecutive and align in a row or column.
  # QD - Validates that coordinates form a straight line, ensuring correct alignment.
  # JB - Confirms ships are placed in either a horizontal or vertical line.
  def consecutive_coordinates?(coordinates)
    letters = coordinates.map { |coord| coord[0] }
    numbers = coordinates.map { |coord| coord[1].to_i }

    same_row = letters.uniq.size == 1 && consecutive?(numbers)
    same_column = numbers.uniq.size == 1 && consecutive?(letters)

    same_row || same_column
  end

  # Determines if elements in an array are consecutive.
  # QD - Used for validating consecutive rows or columns.
  # JB - Checks that each element is in direct sequence with the previous.
  def consecutive?(elements)
    if elements.all? { |el| el.is_a?(Integer) }
      elements.each_cons(2).all? { |a, b| b == a + 1 }
    else
      elements.map { |el| el.ord }.each_cons(2).all? { |a, b| b == a + 1 }
    end
  end
end