# Project Branch Setup

---
 # Team Member: ✅ Done
## Step 1: Set up Iteration Branches (1-4)

### Commands:

```ruby
# Create Iteration 1 branch
git checkout -b iteration-1-ships-and-cells

# Create Iteration 2 branch
git checkout -b iteration-2-the-board

# Create Iteration 3 branch
git checkout -b iteration-3-game-flow

# Create Iteration 4 branch
git checkout -b iteration-4-additional-features
```
#### After creating the iteration branches:

1. **Switch back to the main branch**:
```ruby 
git checkout main
```

2. **Stage and commit the iteration branches:**

```ruby
git add .
git commit -m "Set up iteration branches: iteration-1, iteration-2, iteration-3, iteration-4"
```
3. **Push each iteration branch to GitHub:**
#### Push each branch individually:
```ruby
git push -u origin iteration-1-ships-and-cells
```
```ruby
git push -u origin iteration-2-the-board
```
```ruby
git push -u origin iteration-3-game-flow
```
```ruby
git push -u origin iteration-4-additional-features
```
# Example for Ship Class Feature Branch
⚡️⚡️⚡️**Please Read this how you do the git flow this** ⚡️ ⚡️ ⚡️ 
#### Copy each command indivdually
```ruby
git checkout iteration-1-ships-and-cells
```
```ruby
git checkout -b feature/ship-class
```
```ruby
git checkout main
```
```ruby
git add .
```
```ruby
git commit -m "Set up feature branches for iteration 1: ship-class"
```
#### Push each branch individually:
```ruby
git push -u origin feature/ship-class
```
Follow the instruction below:

# Team Member: Qory
## Step 2: Set Up Feature Branches within Each Iteration (1-2)
-----
#### Iteration 1: Ships and Cells
1. **Switch to the iteration-1-ships-and-cells branch:**
```ruby
git checkout iteration-1-ships-and-cells
```

2. **Create the feature branches for Iteration 1:**
```ruby
git checkout -b feature/ship-class
```
```ruby
git checkout -b feature/cell-class
```
3. **Switch back to the main branch and commit the setup:**
```ruby
git checkout main
```
```ruby
git add .
```
```ruby
git commit -m "Set up feature branches for iteration 1: ship-class, cell-class"
```
4. **Push the feature branches for Iteration 1:**
#### Push each branch individually:
```ruby
git push -u origin feature/ship-class
```
```ruby
git push -u origin feature/cell-class
```
### Iteration 2: The Board
1. **Switch to the iteration-2-the-board branch:**
```ruby
git checkout iteration-2-the-board
```
2. **Create the feature branches for Iteration 2:**
```ruby
git checkout -b feature/board-class
```
```ruby
git checkout -b feature/validations
```

- Add code to your **board class**
3. **Sumbit to Feature Branch**
```ruby
git checkout feature/board-class
```
4. ** Commit & Push to Hub**
```ruby
git add .
```
```ruby
git commit -m "Set up feature branches for iteration 2: board-class, validations"
```
## Only for finished product Switch back to the main branch and commit the setup:
```ruby
git checkout main
```
```ruby
git add .
```
```ruby
git commit -m "Set up feature branches for iteration 2: board-class, validations"
```
4. **Push the feature branches for Iteration 2:**
#### Push each branch individually:
```ruby
git push -u origin feature/board-class
```
```ruby
git push -u origin feature/validations
```

# Team Member: Jillian
## Set Up Feature Branches within Each Iteration (3-4)
### Iteration 3: Game Flow

1. **Switch to the iteration-3-game-flow branch:**
```ruby
git checkout iteration-3-game-flow
```
2. **Create the feature branches for Iteration 3:**
```ruby
git checkout -b feature/game-logic
```
```ruby
git checkout -b feature/computer-player
```
3. **Switch back to the main branch and commit the setup:**
```ruby
git checkout main
```
```ruby
git add .
```
```ruby
git commit -m "Set up feature branches for iteration 3: game-logic, computer-player"
```
4. **Push the feature branches for Iteration 3:**
#### Push each branch individually:
```ruby
git push -u origin feature/game-logic
```
```ruby
git push -u origin feature/computer-player
```

### Iteration 4: Additional Features

1. **Switch to the iteration-4-additional-features branch:**
```ruby
git checkout iteration-4-additional-features
```

2. **Create the feature branches for Iteration 4:**
```ruby
git checkout -b feature/variable-board-size
```
```ruby
git checkout -b feature/custom-ships
```
```ruby
git checkout -b feature/intelligent-computer
```
```ruby
git checkout -b feature/ship-customization
```
```ruby
git checkout -b feature/fog-of-war
```
```ruby
git checkout -b feature/timed-rounds
```
```ruby
git checkout -b feature/achievements-and-rewards
```
```ruby
git checkout -b feature/battle-history-and-stats
```
3. **Switch back to the main branch and commit the setup:**
```ruby
git checkout main
```
```ruby
git add .
```
```ruby
git commit -m "Set up feature branches for iteration 4: ship-customization, fog-of-war, timed-rounds, achievements-and-rewards, battle-history-and-stats, variable-board-size, custom-ships, intelligent-computer"
```
4. **Push the feature branches for Iteration 4:**
#### Push each branch individually:
```ruby
git push -u origin feature/variable-board-size
```

```ruby
git push -u origin feature/custom-ships
```
```ruby
git push -u origin feature/intelligent-computer
```

```ruby
git push -u origin feature/ship-customization
```
```ruby
git push -u origin feature/fog-of-war
```
```ruby
git push -u origin feature/timed-rounds
```
```ruby
git push -u origin feature/achievements-and-rewards
```
```ruby
git push -u origin feature/battle-history-and-stats
```
