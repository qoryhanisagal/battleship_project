# Requirements for Iteration 4 - Additional Features

## New Features and Customizations

### Feature: Variable Board Size
- **Description**: Allow the user to specify the height and width of the board when starting a game.
- **Requirements**:
  - The user should be prompted to set the board size at game start.
  - Board size must be customizable but must adhere to gameplay rules (e.g., minimum and maximum sizes).
  - All validations, including ship placement and firing, should work with the new board dimensions.

### Feature: Custom Ships
- **Description**: Enable users to create custom ships by naming and assigning lengths to them.
- **Requirements**:
  - Prompt users to create custom ships with unique names and lengths.
  - Validate that custom ships are logically sized based on board dimensions.
  - Ensure all existing ship functionalities (hit, sunk, etc.) are compatible with custom ships.

### Feature: Intelligent Computer
- **Description**: Enhance the computer’s gameplay by allowing it to make educated guesses based on previous hits and misses.
- **Requirements**:
  - The computer should choose its next shot intelligently, considering the results of previous shots.
  - The targeting logic should be more advanced than random guessing to increase difficulty for the player.

---

## Spec Files for Iteration 4

### 1. **Board Spec** (`spec/board_spec.rb`):
- **Tests to Implement**:
  - Validate that the board correctly handles variable sizes.
  - Ensure all board functions adapt to non-standard dimensions.

### 2. **Ship Spec** (`spec/ship_spec.rb`):
- **Tests to Implement**:
  - Validate that users can create ships with custom names and lengths.
  - Ensure custom ships maintain functionality for health, `hit`, and `sunk?` methods.

### 3. **Computer Spec** (`spec/computer_spec.rb`):
- **Tests to Implement**:
  - Test the computer’s intelligent targeting system.
  - Confirm the computer avoids selecting previously fired-upon cells and effectively targets adjacent cells after a hit.

---

## Summary for Iteration 4

- **Primary Focus**: Implement advanced game features to enhance customization and challenge.
- **Classes Affected**:
  - `Board` class to accommodate variable board size.
  - `Ship` class to handle custom ship attributes.
  - New logic within the `Game` or `Computer` class to implement the intelligent computer feature.
- **Spec Files**:
  - `board_spec.rb` to cover variable board size.
  - `ship_spec.rb` to test custom ships.
  - `computer_spec.rb` to validate intelligent targeting logic.