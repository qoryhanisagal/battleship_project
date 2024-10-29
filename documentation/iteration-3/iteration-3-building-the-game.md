# Iteration 3 - Game Flow

## Iteration Logic

### Overview:
- **Iteration Objective**: Combine the foundational `Ship`, `Cell`, and `Board` classes to create a playable version of the game.
- **Primary Interactions**: Implement the game flow, including setting up the main menu, managing turns, tracking win conditions, and coordinating gameplay between the player and computer.
- **Key Methods**: The `Game` class will manage game flow, player actions, and transitions.

---

### Core Feature Class: `Game` Class

- **File**: `lib/game.rb`
- **Purpose**: The `Game` class manages the entire game flow, coordinating between the player and computer, handling turns, win conditions, and transitions.

**Key Methods in the `Game` Class**:
1. **`start`**: Displays a welcome message and presents options to play or quit.
2. **`setup`**: Handles ship placements for both the player and the computer.
3. **`turn`**: Manages each turn for both players, including displaying boards, allowing player input, and selecting computer moves.
4. **`check_winner`**: Checks if any player has won the game by sinking all opposing ships.
5. **`display_boards`**: Shows the boards for both the player and computer, displaying cell states like hits, misses, and sunk ships.

---

### Updates to Existing Classes

1. **`Board` Class**:
   - **New Method**:
     - `valid_fire_coordinates?`: Ensures the user can only fire at valid, non-repeated coordinates.
   - **Update**:
     - `fire_upon`: Tracks if the cell has already been fired upon and returns a message if it has.

2. **`Cell` Class**:
   - **Update**:
     - `render`: Now accounts for displaying both the player’s and computer’s boards, with hidden ships for the computer.

3. **`Board Spec` (`spec/board_spec.rb`)**:
   - **Additional Tests**:
     - Tests that players can only fire at valid, non-repeated coordinates.
     - Ensures repeated fire attempts on the same cell are handled gracefully.

4. **`Cell Spec` (`spec/cell_spec.rb`)**:
   - **Additional Tests**:
     - Tests that `render` displays the correct state for both player and computer boards.

# Iteration 3: Error Documentation

## Summary
This document captures the errors, debugging insights, and solutions encountered during Iteration 3. Each error is detailed with its cause, trial-and-error attempts, and the final solution.

---

### 1. Error: Misinterpretation of Player and Computer Boards

**Error Details**
- **Issue**: The game logic misinterpreted player and computer board states, causing incorrect winner declarations.
- **Symptom**: The game declared the computer as the winner even when the player had clearly sunk all of the computer’s ships.

**Cause**
- Mismanagement of separate board states for player and computer, causing confusion in the `game_over?` logic and `end_game` announcements.

**Solution**
- **Solution Implemented**: Set up distinct checks in the `game_over?` method to determine if all computer ships were sunk or if all player ships were sunk, assigning a `@winner` variable to handle the state.
- **Final Outcome**: Corrected win/loss logic by adding an `@winner` instance variable, allowing the game to declare the correct winner.

---

### 2. Error: Computer Firing on Already Fired Coordinates

**Error Details**
- **Issue**: The computer sometimes targeted previously fired-upon cells, disrupting game flow.
- **Symptom**: Repeated misses or hits on the same cell.

**Cause**
- The `random_unfired_coordinate` method did not correctly track previously fired-upon cells.

**Solution**
- **Solution Implemented**: Updated `random_unfired_coordinate` to check that coordinates hadn’t already been fired upon, ensuring unique targeting each turn.
- **Final Outcome**: Game flow improved as the computer fired on unique, valid cells.

---

### 3. Error: Invalid Ship Placement

**Error Details**
- **Issue**: Errors were raised when trying to place player ships at specific coordinates.
- **Symptom**: Repeated messages like “Those coordinates are invalid” even though the coordinates seemed valid.

**Cause**
- The `valid_placement?` method lacked flexibility and failed to accommodate certain placements.

**Solution**
- **Solution Implemented**: Enhanced the `valid_placement?` method to be more comprehensive, ensuring that it allowed valid placements based on ship size and alignment rules.
- **Final Outcome**: The player could successfully place ships at intended coordinates without error messages.

---

### 4. Error: Incorrect Feedback Messages

**Error Details**
- **Issue**: Feedback messages were incorrect, especially after sinking a ship.
- **Symptom**: The game sometimes provided incorrect feedback about “sunk” ships.

**Cause**
- Overlaps in feedback logic within the `feedback` method.

**Solution**
- **Solution Implemented**: Rewrote the `feedback` method to prioritize “sunk” messages after checking for hits or misses.
- **Final Outcome**: Improved accuracy in feedback, providing players with the correct result of each shot.

---

## Checklist for Iteration 3

- **Primary Class**: `Game` class in `lib/game.rb`
- **Spec File**: `spec/game_spec.rb` for testing game flow, setup, turn management, and win conditions.
- **Updates to Existing Classes**:
  - `Board` class: `valid_fire_coordinates?` and updated `fire_upon` method.
  - `Cell` class: updated `render` method for board display.
- **Additional Tests**: Expanded `board_spec.rb` and `cell_spec.rb` for validation and rendering in gameplay.
