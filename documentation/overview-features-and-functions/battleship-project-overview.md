# Battleship Project Overview

## Team Members:
- Jillian
- Qory

## Game Objective:
Create a playable version of Battleship using a REPL interface. The game will feature a single human player playing against a computer player.

## Game Setup:
- Both the human player and the computer will have a 4x4 board.
- Each player will have two ships:
  - Cruiser (3 cells)
  - Submarine (2 cells)

## Gameplay:
- Players take turns firing shots at the opponent’s board.
- The board will indicate hits (H), misses (M), and sunken ships (X).

## End Condition:
The game is won when either the player or the computer sinks both enemy ships.

---

# Project Outline

## Import Statements and Initial Setup
**Explanation:** Import necessary modules and classes, including board, cell, placement validation, and computer player, to enable game functionality.

## Class Definitions and Module Inclusions
**Explanation:** Define the primary `GameLogic` class and include supporting modules such as `PlacementValidator`, `Renderer`, `GuessingStrategy`, and `TwoPlayerMode` for enhanced modularity and functionality.

## Initialize Boards and Set up Variables
**Explanation:** Initialize the boards and required instance variables (e.g., `@player1_board`, `@player2_board`, `@computer_board`) and set up the two-player mode variable and default ship configurations.

## Main Menu and Game Mode Selection
**Explanation:** Display a main menu where players select either single-player or two-player mode, or quit the game.

## Single-Player Mode (`setup_single_player_game`)
**Explanation:** Setup specific to single-player mode, including board size, ship placement, and game difficulty selection.

## Two-Player Mode (`setup_two_player_game`)
**Explanation:** Setup specific to two-player mode, allowing both players to choose board size, ships, and their placements.

## Board Setup: `set_board_size`
**Explanation:** Prompt players to enter the board size, configuring both player boards to the chosen dimensions.

## Ship Placement: `set_ships`
**Explanation:** Allow players to define custom ships by entering names and lengths, with validation for ship length input.

## Ship Placement on the Board: `place_player_ships`
**Explanation:** Guide each player through placing their ships on their board, using validation for valid and available coordinates.

## Initiating Turns: `take_turn` and `player_turn`
**Explanation:** Define the primary game loop for alternating turns between players in two-player mode or between the player and computer in single-player mode.

## Player’s Turn: `player_turn`
**Explanation:** Manage each player's turn, including displaying the opponent’s board, prompting for coordinates, and validating the shot's outcome.

## Computer Turn: `computer_turn`
**Explanation:** Handle the computer’s turn using intelligent guessing based on the selected difficulty, utilizing the `GuessingStrategy` module.

## Feedback Method
**Explanation:** Provide feedback to the player on the shot outcome, indicating a miss, hit, or sunk ship status.

## Game Over Check
**Explanation:** Verify win/loss conditions by checking if all ships on one of the player’s or computer’s board have been sunk.

## Sunk? `all_ships_sunk?`
**Explanation:** Confirm if all ships on a given board have been sunk, used in the `game_over?` method for determining the end of the game.

## Start Game (`start_game`)
**Explanation:** Display a welcome message and initiate the main menu for player interaction.

## Game Setup (`play_game`)
**Explanation:** Set up initial ship placements for both players (or player and computer) and prepare for the main gameplay loop.

## Game Difficulty: `set_game_difficulty`
**Explanation:** Prompt the player to choose a difficulty level, which will adjust the computer’s strategy accordingly.

## End Game Method
**Explanation:** Announce the winner and reset or exit the game based on the player’s choice at the end of the game.

## Modules

### `PlacementValidator`
**Explanation:** Validate the placement of ships on the board, ensuring coordinates meet game rules.

### `Renderer`
**Explanation:** Render the board to display shots, hits, and misses, depending on game progress.

### `GuessingStrategy`
**Explanation:** Manage the computer’s move choices, incorporating difficulty levels to make calculated guesses.

### `TwoPlayerMode`
**Explanation:** Facilitate two-player gameplay, managing turn-taking and player-specific functionalities.

## Evaluation Rubric

### Functionality:
- **Exceeds Expectations**: 2 of the features in Iteration 4 are complete.
- **Meets Expectations**: All of the functionality in Iteration 3 is complete.
- **Approaching Expectations**: Some functionality in Iteration 3 is incomplete.
- **Below Expectations**: Game cannot execute ship placement or Iteration 2 is incomplete.

### Object-Oriented Programming:
- **Exceeds Expectations**: Project includes at least one additional class that adheres to SRP and acts as a crucial piece in the function of the program.
- **Meets Expectations**: Project includes at least one additional class, and the correct number of Board, Cell, and Ship objects are created. Most code is contained within classes.
- **Approaching Expectations**: Project includes an additional class, but object creation may be unnecessary or incomplete.
- **Below Expectations**: Project does not include a class not outlined in the spec or fails to use objects appropriately.

### Test-Driven Development:
- **Exceeds Expectations**: Includes an additional test file that fully tests a class.
- **Meets Expectations**: No more than 2 tests fail to verify expected behavior. Most methods are unit/integration tested.
- **Approaching Expectations**: More than 2 tests fail, or certain methods are not tested.
- **Below Expectations**: Half the methods are not tested or do not accurately verify behavior.

### Version Control:
- **Exceeds Expectations**: Project includes at least 10 pull requests with comments and 30 commits. Balanced contribution between partners.
- **Meets Expectations**: Project includes at least 10 pull requests and 30 commits.
- **Approaching Expectations**: Project includes fewer pull requests or commits.
- **Below Expectations**: Less than 20 commits or 5 pull requests.

### Presentation & Professional Development:
- **Exceeds Expectations**: All reflection questions answered thoughtfully with suggestions for future improvements.
- **Meets Expectations**: All questions are answered thoughtfully.
- **Approaching Expectations**: 1 reflection or presentation point is not thoughtfully answered.
- **Below Expectations**: More than 1 reflection question is skipped or not answered thoughtfully.

---

## Written Reflection:

### Questions:
1. Iteration 3 did not provide an interaction pattern. How did you approach designing this iteration? If you did not get to Iteration 3, reflect on how you think you would’ve approached the design and problem-solving process.
2. If you had one more day to work on this project, what would you work on?
3. Describe the pairing techniques you used while working on this project.
4. Describe how feedback was shared over the course of this project.

---

## Presentation Points:

### Demonstration of Functional Completeness:
- Run the `.rb` file and demonstrate gameplay in the terminal.
- Highlight edge case handling in the demonstration.

### Technical Quality & Organization of Code:
- Describe how the game was structured. What classes were created? Explain the responsibility of each class.
- Highlight a design decision that you are particularly proud of.

### Code Refactoring:
- Identify a section of code that you’d like to refactor and explain how you’d improve it.
- Address any uncertainties about specific parts of your code.

### Test Coverage:
- Provide examples of unit and integration tests.
- Run your test suite and open a coverage report (e.g., SimpleCov if implemented).

### Pairing & Version Control:
- Describe the pairing technique used.
- Review GitHub insights: how many pull requests, commits, and how balanced the contributions were.
- Highlight a PR that demonstrates good commenting and partner review workflow.


# Presentation Points

## Demonstration of Functional Completeness

1. **Running the Game and Walkthrough:**
   - We will demonstrate starting the game in both single-player and two-player modes, showcasing how the game transitions between each mode.
   - We'll display the board setup and illustrate how taking turns works, allowing for basic gameplay interactions and providing insight into how the game flow is managed.

2. **Edge Case Handling:**
   - **Invalid Inputs:** Our game handles invalid inputs such as incorrect coordinates, duplicate shots, and improper ship placements, demonstrating the system’s resilience and responsiveness.
   - **Win Condition Check:** We will show the game ending by announcing the winner as soon as all ships on either the player’s or the computer’s board are sunk, ensuring the win condition is well-defined and clear.

---

## Technical Quality & Organization of Code

1. **Class Structure Overview:**
   - **GameLogic:** Manages the main game flow, including menu navigation and game setup for both single-player and two-player modes.
   - **Board:** Represents the game board, responsible for creating the grid and managing ship placement, making this component crucial for tracking game progress.
   - **Cell:** Manages individual cell states, indicating whether a cell is empty, hit, or occupied by a ship.
   - **Ship:** Handles ship properties like name and length, as well as its status (sunk or afloat).
   - **ComputerPlayer:** Manages the computer’s moves, using a dynamic guessing strategy to adjust difficulty as needed.

2. **Modules Used:**
   - **PlacementValidator:** Ensures ship placements are valid and prevent overlap, helping maintain the integrity of the board.
   - **Renderer:** Manages board display to make the game visually understandable.
   - **GuessingStrategy:** Implements intelligent guesses for the computer player based on difficulty, providing a responsive and challenging experience.

3. **Design Decision Highlight:**
   - One of our key design choices was the **Guessing Strategy Module** for the computer’s moves. This feature dynamically adjusts difficulty, enhancing the game experience by making the computer's strategy more challenging and engaging for players.

---

## Code Refactoring

1. **Identified Refactoring Opportunities:**
   - We focused on areas where functionality could be modularized for clarity and reuse. For example, **Ship Placement Validation** in the PlacementValidator module was refactored to avoid duplicated checks by breaking down larger methods into smaller, reusable ones.
   - **Refactored Methods:** We created methods like `valid_placement?`, `within_bounds?`, and `no_overlap?` to streamline validation checks, making the code easier to understand and maintain.

2. **Addressing Remaining Uncertainties:**
   - We acknowledge that some logic and performance could still benefit from further optimization. Moving forward, user feedback and additional testing may reveal new areas for improvement.

---

## Test Coverage

1. **Examples of Unit and Integration Tests:**
   - **Unit Tests:** We created comprehensive tests for individual classes, such as the Cell class (testing `fire_upon` behavior) and the Ship class (testing the `sunk?` status).
   - **Integration Tests:** We also developed integration tests for key methods like `take_turn`, which interacts across multiple classes (GameLogic, Board, and Cell), to ensure a cohesive and reliable game flow.

2. **Running the Test Suite:**
   - Using SimpleCov, we ran a full test suite, achieving a high coverage percentage across our classes and methods, demonstrating our commitment to a robust and thoroughly tested codebase.

---

## Pairing & Version Control

1. **Pairing Technique:**
   - We employed a **driver-navigator** pairing approach, where one person coded while the other reviewed. This allowed us to maintain a strong collaborative effort, with both of us contributing ideas and solutions throughout development.

2. **GitHub Insights:**
   - **Pull Requests:** We maintained an active pull request process, ensuring each significant code change was reviewed, documented, and discussed.
   - **Contribution Balance:** Both of us contributed evenly, as seen through balanced commit histories, pull request reviews, and comments.
   - **PR Highlight:** One of our notable pull requests was well-documented, with meaningful comments and issue resolutions that show our attention to detail and commitment to collaboration.