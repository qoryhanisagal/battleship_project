# Iteration 1 - Ships and Cells

## Iteration Logic

### Overview:
- **Iteration Objective**: Build foundational classes for the Battleship game, specifically the `Ship` and `Cell` classes.
- **Primary Interactions**: Place ships on cells, fire upon cells, and track ship health and cell states.
- **Key Methods**: Each class in this iteration will implement essential methods to set up and interact with the board.

---

### Class Logic and Methods

1. **Ship Class** (`lib/ship.rb`):
   - **Purpose**: Represents a single ship on the board, tracking its health and state (sunk or afloat).
   - **Key Methods**:
     - `initialize`: Sets up `name`, `length`, and `health` of the ship.
     - `hit`: Reduces the ship’s `health` by 1 when called.
     - `sunk?`: Returns `true` if `health` is zero.
   - **Spec File**: `spec/ship_spec.rb`

2. **Cell Class** (`lib/cell.rb`):
   - **Purpose**: Represents a single cell on the game board, which can be empty or contain a ship.
   - **Key Methods**:
     - `initialize`: Sets up the cell with a `coordinate` and initializes `@ship` to `nil`.
     - `place_ship`: Places a ship in the cell.
     - `fire_upon`: Sets the cell as fired upon and reduces ship `health` if it contains one.
     - `fired_upon?`: Checks if the cell has been fired upon.
     - `render`: Displays the cell’s state based on conditions (e.g., hit, miss, sunk).
   - **Spec File**: `spec/cell_spec.rb`

---

### Expected Interactions:

1. **Placing a Ship**:
   - `Cell#place_ship(ship)` associates a ship with the cell and changes its state from empty.

2. **Firing Upon a Cell**:
   - `Cell#fire_upon` marks the cell as fired upon and calls `hit` on the ship, if present.

3. **Rendering Cell State**:
   - `Cell#render` provides visual feedback to show if a cell has been fired upon, hit, missed, or if the ship is sunk.

---

# Iteration 1 - Ships and Cells

## Iteration Logic

### Overview:
- **Iteration Objective**: Build foundational classes for the Battleship game, specifically the `Ship` and `Cell` classes.
- **Primary Interactions**: Place ships on cells, fire upon cells, and track ship health and cell states.
- **Key Methods**: Each class in this iteration will implement essential methods to set up and interact with the board.

---

## Class Logic and Methods

### 1. **Ship Class** (`lib/ship.rb`)
- **Purpose**: Represents a single ship on the board, tracking its health and state (sunk or afloat).
- **Key Methods**:
  - `initialize`: Sets up ship `name`, `length`, and `health`.
  - `hit`: Reduces the ship’s health by 1 when called.
  - `sunk?`: Returns `true` if `health` is zero.
- **Spec File**: `spec/ship_spec.rb`

### 2. **Cell Class** (`lib/cell.rb`)
- **Purpose**: Represents a single cell on the game board, which can be empty or contain a ship.
- **Key Methods**:
  - `initialize`: Sets up the cell with a `coordinate` and initializes `@ship` to `nil`.
  - `place_ship`: Places a ship in the cell.
  - `fire_upon`: Sets the cell as fired upon and reduces ship health if it contains one.
  - `fired_upon?`: Checks if the cell has been fired upon.
  - `render`: Displays the cell’s state based on conditions (e.g., hit, miss, sunk).
- **Spec File**: `spec/cell_spec.rb`

---

## Test-Driven Development (TDD) Process

### Test Failures and Fixes

#### Test 1: `Cell#initialize` - Cell Exists and Has a Coordinate

- **Failure**:
  ```ruby
  Failure/Error: expect(cell).to be_a(Cell)
  
  NameError:
    uninitialized constant Cell
    ```
    
- **Failure Reason**: The Cell class was not yet defined, leading to a NameError when attempting to create a Cell instance.
- **Fix**: Defined the Cell class in `lib/cell.rb` with an `initialize` method that takes a coordinate and sets `@ship` to `nil`.

#### Test 2: `Cell#place_ship` - Can Place a Ship in a Cell

- **Failure**:
  ```ruby
  Failure/Error: cruiser = Ship.new("Cruiser", 3)
  
  NameError:
    uninitialized constant Ship
    ```

- **Failure Reason**: The Ship class was not defined, leading to an error when attempting to place a ship in a cell.
- **Fix**: Defined the Ship class in lib/ship.rb with an initialize method to accept name and length, and set initial health to the ship’s length.

#### Test 3: `Cell#fire_upon` - Cell Can Be Fired Upon and Affect the Ship

- **Failure**:
  ```ruby
  Failure/Error: cell.fire_upon
  
  NoMethodError:
    undefined method `fire_upon` for #<Cell:0x00007fe0b19f3b88>
    ```
- **Failure Reason**: The fire_upon method was missing from the Cell class, so the test could not call this method on a cell instance.
- **Fix**: Added a fire_upon method to the Cell class, which sets @fired_upon to true and calls hit on the ship if one is present.
#### Test 4: `Cell#render` - Cell Renders Different States

- **Failure**:
  ```ruby
  Failure/Error: expect(cell.render).to eq(".")
  
  NoMethodError:
    undefined method `render` for #<Cell:0x00007fcd0a08f3d0>
    ```

- **Failure Reason**: The render method was missing, so the test could not render cell states.
- **Fix**: Implemented the render method in Cell, displaying "." for unvisited cells, "M" for misses, "H" for hits, and "X" if the ship is sunk.

