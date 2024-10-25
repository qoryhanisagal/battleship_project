# Requirements for Iteration 2

## Required Classes for Iteration 2:

### 1. **Board Class** (New Class):
- The Board class is responsible for managing the game board, tracking cells, placing ships, validating coordinates, and rendering the board.
  
  **Methods**:
  - `cells`: A hash storing the board’s cells, where the key is the coordinate (e.g., "A1") and the value is a `Cell` object.
  - `valid_coordinate?(coordinate)`: Checks if a given coordinate exists on the board.
  - `valid_placement?(ship, coordinates)`: Verifies that the ship can be placed at the given coordinates.
  - `place(ship, coordinates)`: Places the ship on the board at the given coordinates.
  - `render(reveal_ships = false)`: Renders the board, showing the state of each cell, with the option to reveal ships.

---

## Spec Files for Iteration 2:

### 1. **Board Spec**:
   - The Board class will need tests for:
     - Cell tracking for a 4x4 grid.
     - Coordinate validation for valid/invalid inputs.
     - Ship placement validation: correct number of coordinates, consecutive and no overlap.
     - Correct ship placement on the board.
     - Proper rendering of the board.

---

## Updates to Iteration 1 Classes:

### 1. **Ship Class**:
   - No changes required.

### 2. **Cell Class**:
   - Potential updates:
     - `place_ship`: Ensure it handles overlapping ships and errors.
     - `render`: Minor updates to ensure interaction with the board's rendering.

---

## Spec Files for Updated Classes:

### 1. **Cell Spec** (Updated):
   The Cell spec will need to include:
   - Interaction with the board and prevention of ship overlap.
   - Proper interaction between placed ships and the board.