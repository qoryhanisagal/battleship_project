# Requirements for Iteration 1

## Required Classes for Iteration 1:

### 1. **Ship Class**:
   - This class represents a ship in the game, tracking its health and state (e.g., sunk or not).
   - **Methods**:
     - `name`: Returns the name of the ship.
     - `length`: Returns the length of the ship.
     - `health`: Returns the remaining health of the ship (which starts at the ship’s length).
     - `hit`: Reduces the health of the ship when hit.
     - `sunk?`: Returns `true` if the ship has no remaining health.

### 2. **Cell Class**:
   - This class represents a single cell on the game board. Each cell can either be empty or contain a ship.
   - **Methods**:
     - `coordinate`: Returns the cell’s coordinate (e.g., "A1").
     - `empty?`: Checks if the cell is empty or contains a ship.
     - `place_ship`: Places a ship in the cell.
     - `fired_upon?`: Checks if the cell has already been fired upon.
     - `fire_upon`: Marks the cell as fired upon, hitting the ship if present.
     - `render`: Displays the status of the cell (`"."` for unvisited, `"M"` for miss, `"H"` for hit, `"X"` for sunken ship).

---

## Spec Files for Iteration 1:

### 1. **Ship Spec**:
   - The Ship class needs a comprehensive set of tests to verify:
     - Ship creation with the correct name and length.
     - The `hit` method reduces the ship’s health.
     - The `sunk?` method returns `true` when the ship has no remaining health.

### 2. **Cell Spec**:
   - The Cell class should be thoroughly tested for:
     - Correct behavior when placing a ship in a cell.
     - The `fire_upon` method, ensuring it correctly modifies the cell’s state.
     - The `render` method, displaying the correct status of the cell.

---

## Ship Class (Already covered in previous breakdown):

- The Ship class manages the health of the ship, and each ship can be hit and eventually sunk.
- **Interaction Covered**:
  - When a ship is placed on a cell, the cell can interact with the ship via the `fire_upon` method, reducing the ship’s health by calling the `hit` method.
  - `sunk?` method returns `true` if the ship’s health is zero.

---

## Cell Class (Including additional details):

The Cell class is responsible for managing when it has been fired upon, damaging the ship if it has one, and rendering the appropriate display based on the cell’s state.

### Key Methods:

1. **`place_ship(ship)`**:
   - Places the given ship into the cell.
   - Associates the ship object with the cell, making it interactable when fired upon.

2. **`fire_upon`**:
   - This method changes the cell’s state to indicate that it has been fired upon.
   - If the cell contains a ship, it will call the ship’s `hit` method, reducing its health.

3. **`fired_upon?`**:
   - Returns `true` or `false` based on whether the cell has been fired upon.

4. **`render(reveal_ship = false)`**:
   - This method returns the correct string representation of the cell:
     - `"."` if the cell has not been fired upon.
     - `"M"` if the cell has been fired upon and it does not contain a ship.
     - `"H"` if the cell has been fired upon and contains a ship.
     - `"X"` if the ship in the cell has been sunk.
   - The optional argument `reveal_ship` allows the method to display an `"S"` if the cell contains a ship and hasn’t been fired upon, useful for debugging or showing ship placement.

---

## Spec Files for Cell Class (Updated for New Interaction Patterns):

The Cell spec will need to cover the following:

### 1. **Ship Placement**:
   - Ensure `place_ship` correctly assigns a ship to a cell.
   - Verify that a ship placed in a cell interacts with the `fire_upon` method, reducing the ship’s health.

### 2. **Fire Upon Behavior**:
   - Check that `fire_upon` modifies the cell state and reduces the ship’s health (if a ship is present).
   - Verify that the `fired_upon?` method returns `true` once the cell has been fired upon.

### 3. **Rendering the Cell**:
   - Test the `render` method for different cases:
     - `"."` for an unfired-upon cell.
     - `"M"` for a miss (cell fired upon with no ship).
     - `"H"` for a hit (cell fired upon with a ship).
     - `"X"` for a sunken ship.
     - `"S"` for revealing a ship without firing upon it (optional argument set to `true`).