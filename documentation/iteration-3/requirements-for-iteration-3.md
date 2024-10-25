# Requirements for Iteration 3

## New Classes for Iteration 3:

### 1. **Game Class**:
- **Purpose**: This class will manage the entire game flow, coordinating between the player and computer, and handling turns, win conditions, and transitions.
- **Key Methods**:
  - `start`: Starts the game and manages the main menu.
  - `setup`: Handles ship placements for both the player and the computer.
  - `turn`: Manages the flow of each turn for both players.
  - `check_winner`: Checks if any player has won the game.
  - `display_boards`: Displays the boards for both the player and the computer.

---

## Updates to Existing Classes:

### 1. **Board Class**:
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