# lib/modules/placement_validator.rb

# PlacementValidator module contains methods to validate ship placements on the board.
module PlacementValidator
  # QD - Validates if a ship placement is allowed based on length, alignment, and overlap.
  # JB - Ensures ships are placed in a line (either horizontally or vertically) and do not overlap.
  
  # Checks if the placement length matches the ship length.
  def valid_placement_length?(ship, coordinates)
    ship.length == coordinates.length
  end

  # Checks if the coordinates are consecutive and aligned in a row or column.
  def consecutive_coordinates?(coordinates)
    letters = coordinates.map { |coord| coord[0] }
    numbers = coordinates.map { |coord| coord[1].to_i }

    same_row = letters.uniq.size == 1 && consecutive?(numbers)
    same_column = numbers.uniq.size == 1 && consecutive?(letters)

    same_row || same_column
  end

  # Determines if elements in an array are consecutive.
  def consecutive?(elements)
    if elements.all? { |el| el.is_a?(Integer) }
      elements.each_cons(2).all? { |a, b| b == a + 1 }
    else
      elements.map { |el| el.ord }.each_cons(2).all? { |a, b| b == a + 1 }
    end
  end

  # Checks if any of the given coordinates already have ships to prevent overlapping.
  def overlapping_ships?(coordinates, cells)
    coordinates.any? { |coord| cells[coord]&.ship }
  end

  # Main method to validate a ship placement.
  def valid_placement?(ship, coordinates, cells)
    valid_placement_length?(ship, coordinates) &&
      consecutive_coordinates?(coordinates) &&
      !overlapping_ships?(coordinates, cells)
  end
end