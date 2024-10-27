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

---

### Spec File for `Game` Class

- **File**: `spec/game_spec.rb`
- **Purpose**: Tests the overall game flow, player and computer setup, turn-taking, and win conditions.

**Key Tests in `game_spec.rb`**:
1. **Game Start and Menu Options**:
   - Ensures the game starts with a welcome message and offers options to play or quit.
2. **Setup Phase**:
   - Verifies that ships are placed correctly for both player and computer.
3. **Turn Management**:
   - Tests that turns alternate between player and computer.
   - Ensures player can select valid coordinates and computer moves are generated correctly.
4. **Win Condition**:
   - Confirms that the game ends when one player sinks all the opposing ships.
5. **Display Boards**:
   - Tests board display for hits, misses, and sunk ships, showing player and computer boards.

---

### Updates to Other Spec Files

1. **`Board Spec` (`spec/board_spec.rb`)**:
   - **Additional Tests**:
     - Tests that players can only fire at valid, non-repeated coordinates.
     - Ensures repeated fire attempts on the same cell are handled gracefully.

2. **`Cell Spec` (`spec/cell_spec.rb`)**:
   - **Additional Tests**:
     - Tests that `render` displays the correct state for both player and computer boards.

---

## Checklist for Iteration 3

- **Primary Class**: `Game` class in `lib/game.rb`
- **Spec File**: `spec/game_spec.rb` for testing game flow, setup, turn management, and win conditions.
- **Updates to Existing Classes**:
  - `Board` class: `valid_fire_coordinates?` and updated `fire_upon` method.
  - `Cell` class: updated `render` method for board display.
- **Additional Tests**: Expanded `board_spec.rb` and `cell_spec.rb` for validation and rendering in gameplay.
