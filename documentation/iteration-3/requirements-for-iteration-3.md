<<<<<<< HEAD
# Requirements for Iteration 3 - Game Flow
=======
# Requirements for Iteration 3
>>>>>>> 88bce5054a25d12c5d3c1bba99e1719135526ab6

## New Classes for Iteration 3:

### 1. **Game Class**:
<<<<<<< HEAD
- **Purpose**: Manages the entire game flow, coordinating between the player and computer, handling turns, win conditions, and transitions.
- **Key Methods**:
  - `start`: Starts the game and manages the main menu options to play or quit.
  - `setup`: Manages ship placements for both the player and the computer.
  - `turn`: Handles each turn, including displaying boards, processing player input, and generating computer moves.
  - `check_winner`: Checks if any player has won by sinking all opponent ships.
  - `display_boards`: Displays both player and computer boards with hits, misses, and sunken ships.
=======
- **Purpose**: This class will manage the entire game flow, coordinating between the player and computer, and handling turns, win conditions, and transitions.
- **Key Methods**:
  - `start`: Starts the game and manages the main menu.
  - `setup`: Handles ship placements for both the player and the computer.
  - `turn`: Manages the flow of each turn for both players.
  - `check_winner`: Checks if any player has won the game.
  - `display_boards`: Displays the boards for both the player and the computer.
>>>>>>> 88bce5054a25d12c5d3c1bba99e1719135526ab6

---

## Updates to Existing Classes:

### 1. **Board Class**:
<<<<<<< HEAD
   - **New Method**:
     - `valid_fire_coordinates?`: Ensures the player can only fire at valid, non-repeated coordinates.
   - **Update**:
     - `fire_upon`: Tracks if a cell has already been fired upon, providing feedback if it has.

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

---
=======
- **New Method**:
  - `valid_fire_coordinates?`: Ensures that the user can only fire at valid and non-repeated coordinates.
  
- **Update**:
  - `fire_upon`: This method must now track whether the player has already fired on a given cell and return a message if the cell has been fired upon before.

### 2. **Cell Class**:
- **Update**:
  - The `render` method should now account for displaying both the player's and the computer's boards (with hidden ships for the computer).

---

## Spec Files for Iteration 3:

### 1. **Game Spec**:
- **Tests to Implement**:
  - Test the flow of the game from start to end.
  - Test ship placements for both the player and the computer.
  - Ensure turns alternate correctly between the player and the computer.
  - Ensure win conditions are checked and the game ends appropriately.

### 2. **Updates to Board Spec**:
- **New Tests**:
  - Test that the player can only fire at valid coordinates.
  - Ensure that repeated firing on the same cell is handled gracefully.

### 3. **Updates to Cell Spec**:
- **New Tests**:
  - Test that the `render` method displays the correct state for both the player's and computer's boards.
>>>>>>> 88bce5054a25d12c5d3c1bba99e1719135526ab6

