
# Requirements for Iteration 3

## New Classes for Iteration 3:

### 1. **Game Class**:
- **Purpose**: Manages the entire game flow, coordinating between the player and computer, handling turns, win conditions, and transitions.
- **Key Methods**:
  - `start`: Starts the game and manages the main menu options to play or quit.
  - `setup`: Manages ship placements for both the player and the computer.
  - `turn`: Handles each turn, including displaying boards, processing player input, and generating computer moves.
  - `check_winner`: Checks if any player has won by sinking all opponent ships.
  - `display_boards`: Displays both player and computer boards with hits, misses, and sunken ships.

---

## Updates to Existing Classes:

### 1. **Board Class**:
   - **New Method**:
     - `valid_fire_coordinates?`: Ensures the player can only fire at valid, non-repeated coordinates.
   - **Update**:
     - `fire_upon`: Tracks if a cell has already been fired upon(invalid), providing feedback if it has(valid).
     

### 2. **Cell Class**:
   - **Update**:
     - `render`: Now differentiates between player and computer boards, showing hidden ships for the computer.

---

## Spec Files for Iteration 3

### 1. **Game Spec** (`spec/game_spec.rb`):
- **Tests to Implement**:
  - Game flow from start to finish, ensuring the game initiates with a welcome message and offers options to play or quit.
  - Verification that ship placements are correct for both the player and computer.
  - Turn alternation, allowing players to make valid moves and generating computer moves.
  - Win conditions to end the game when all ships are sunk for either player.
  - Display functionality for both boards, ensuring hits, misses, and sunken ships show correctly.

### 2. **Additional Tests in Board Spec** (`spec/board_spec.rb`):
- **New Tests**:
  - Validate that players can only fire at valid, unselected coordinates.
  - Ensure repeated attempts to fire on the same cell are handled correctly.

### 3. **Additional Tests in Cell Spec** (`spec/cell_spec.rb`):
- **New Tests**:
  - Confirm that `render` displays the correct state for both player and computer boards.


