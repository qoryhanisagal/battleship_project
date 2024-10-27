# Git Workflow Reminder
 
## Slogans

**"Branch out, check in, add up, commit to push!"**

**"To branch is to begin, to add is to commit, to push is to conquer."**

---

## Steps Breakdown

1. **Branch out** - Check your branch to see where you are.
   ```ruby
   git branch
   ```
2. **Check in** - Switchto the correct branch if needed.
    ```ruby
    git checkout <branch-name>
    ```
3. **Add up** - Stage your changes.
    ```ruby
    git add <file-path>
    ```
4. **Commit to push** - Commit your changes, then push them to GitHUb.

    ```ruby
    git commit -m "Your commit message here"
    git push origin <branch-name>
    ```


## Branch, Checkout, Add, Commit, Push (BCACP)

- **B** - Branch: Check where you are.
- **C** - Checkout: Switch if needed
- **A** - Add: Stage  your changes.
- **C** - Commit: Record your changes.
- **P** - Push: Send your work to GitHub# Game Logic Notes

## *from Iteration 3 Functionality Checklist:*
## Functionality Checklist
This checklist summarizes all of the functionality you are expected to build. This will be used to assess the completion of your project:
### Main Menu: *JB- Done!*
- *User is shown the main menu where they can play or quit*

### Setup:
1. Computer can place ships randomly in valid locations
1. User can enter valid sequences to place both ships
1. Entering invalid ship placements prompts user to enter valid placements

### Turn:
1. User board is displayed showing hits, misses, sunken ships, and ships
1. Computer board is displayed showing hits, misses, and sunken ships
1. Computer chooses a random shot
1. Computer does not fire on the same spot twice
1. User can choose a valid coordinate to fire on
1. Entering invalid coordinate prompts user to enter valid coordinate
1. Both computer and player shots are reported as a hit, sink, or miss
1. User is informed when they have already fired on a coordinate
1. Board is updated after a turn

### End Game:
1. Game ends when all the user’s ships are sunk ~OR~ Game ends when all the computer’s ships are sunk
1. Game reports who won
1. Game returns user back to the Main Menu


-------------------------
-------------------------

## *from Chat GPT:*

"Game logic" in coding refers to the rules, mechanics, and systems that dictate how a game operates. It encompasses the algorithms and processes that manage game state, player interactions, game progression, and the overall behavior of the game. Here are some key components of game logic:

### Key Components of Game Logic:

1. **Rules and Mechanics**:
   - Defines how the game operates, including scoring, win/loss conditions, and game flow (e.g., turn-based actions, time limits).

2. **Game State Management**:
   - Keeps track of the current state of the game, including player positions, scores, inventory, and other dynamic elements.

3. **Player Interactions**:
   - Handles how players interact with the game world, including input processing (keyboard, mouse, touch), movement, and actions (e.g., attacking, building).

4. **Game Events**:
   - Manages events that can occur during gameplay, such as power-ups, achievements, or triggering cutscenes.

5. **AI Behavior**:
   - If applicable, dictates how non-player characters (NPCs) or enemies behave and react to player actions.

6. **Collision Detection**:
   - Determines when objects in the game world interact (e.g., a character colliding with an obstacle or an enemy).

7. **Game Progression**:
   - Controls how the game advances, including level transitions, experience points, and unlocking new features.

### Examples:
- In a turn-based strategy game, game logic would include the rules for movement, combat, and how turns are taken.
- In a platformer, it would involve character jumping mechanics, gravity effects, and how enemies react to the player's presence.

### Implementation:
Game logic can be implemented in various programming languages and frameworks, often involving:
- **Classes and Objects**: To represent game entities (e.g., players, enemies, items).
- **Functions and Methods**: To encapsulate behaviors (e.g., moving a character, checking win conditions).
- **State Management**: Using data structures to store the current state of the game.

### Conclusion:
In summary, game logic is a critical aspect of game development that defines how the game functions and ensures that gameplay is engaging, fair, and fun. It requires careful planning and implementation to create a cohesive gaming experience.