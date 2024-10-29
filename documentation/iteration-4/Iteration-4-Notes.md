# Outline for Implementing ComputerPlayer Class
1. Class Initialization and Attribute Setup

- Objective: Create a class responsible for managing the computer’s intelligent move logic.
- Attributes:
	- @board: This holds the game board for the computer’s moves.
	- @hit_tracking: An array to store the coordinates of successful hits, guiding the AI’s next moves.
	- Steps:
		- 1.	Define ComputerPlayer and initialize it with a board parameter.
		- 2.	Assign @board to the input board and initialize @hit_tracking as an empty array to keep track of successful hit coordinates.
 ```ruby
class ComputerPlayer
  attr_reader :board, :hit_tracking

  def initialize(board)
    @board = board
    @hit_tracking = []  # Stores coordinates of successful hits to guide next shots.
  end
end
```

2. Primary Method: calculate_next_move

- Objective: Calculate the computer’s next move based on previous hits. If there are successful hits in @hit_tracking, it targets adjacent cells; otherwise, it picks a random cell.
- Steps:
	- 1.	Inside calculate_next_move, check if @hit_tracking is empty.
	- 2.	If empty, call random_unfired_coordinate to pick a random cell.
	- 3.	If @hit_tracking has entries, call guess_adjacent_cells to select an adjacent cell near a previous hit.
 ```ruby
def calculate_next_move
  if @hit_tracking.empty?
    random_unfired_coordinate
  else
    guess_adjacent_cells
  end
end
```
3. Helper Method: fire_upon

- Objective: Fire upon a specific coordinate and update @hit_tracking based on the outcome.
- Steps:
	- 1.	Accept a coordinate parameter and locate the corresponding Cell object in @board.
	- 2.	Call fire_upon on this cell.
	- 3.	If it’s a hit but the ship isn’t fully sunk, add the coordinate to @hit_tracking.
	- 4.	If a ship is sunk after this shot, clear @hit_tracking to reset the tracking for the next ship.
 ```ruby
def fire_upon(coordinate)
  cell = @board.cells[coordinate]
  cell.fire_upon
  @hit_tracking << coordinate if cell.hit? && !cell.ship.sunk?
  @hit_tracking.clear if cell.ship&.sunk?
end
```
4. Supporting Method: random_unfired_coordinate

- Objective: Generate a random coordinate that has not been fired upon.
- Steps:
	- 1.	Filter @board.cells to get all cells that haven’t been fired upon.
	- 2.	Select a random cell from the list of unfired cells and return its coordinate.
 ```ruby
def random_unfired_coordinate
  unfired_cells = @board.cells.values.reject(&:fired_upon?)
  unfired_cells.sample.coordinate
end
```
5. Supporting Method: guess_adjacent_cells

- Objective: Identify adjacent cells around successful hits to maximize hit potential on remaining ship sections.
- Steps:
	- 1.	Initialize an empty array adjacent to store potential targets.
	- 2.	For each coordinate in @hit_tracking, determine adjacent cells in four directions (right, left, up, down).
	- 3.	Ensure each adjacent cell is within bounds and unfired, and add it to adjacent.
	- 4.	If there are valid adjacent cells, return a random one. Otherwise, fall back to random_unfired_coordinate.
 ```ruby
def guess_adjacent_cells
  adjacent = []

  @hit_tracking.each do |coord|
    row = coord[0]
    col = coord[1].to_i

    potential_targets = [
      "#{row}#{col + 1}",          # Right
      "#{row}#{col - 1}",          # Left
      "#{(row.ord + 1).chr}#{col}", # Down
      "#{(row.ord - 1).chr}#{col}"  # Up
    ]

    potential_targets.each do |target|
      adjacent << target if @board.valid_coordinate?(target) && !@board.cells[target].fired_upon?
    end
  end

  adjacent.empty? ? random_unfired_coordinate : adjacent.sample
end
```

6. Final Integration and Testing

- Objective: Once the ComputerPlayer class is complete, integrate it with the main game logic.
- Steps:
	- 1.	Instantiate ComputerPlayer in Battleship and ensure it uses calculate_next_move to fire upon strategic coordinates.
	- 2.	Test extensively to confirm the computer targets adjacent cells after a hit and does not re-fire on previously fired cells.
