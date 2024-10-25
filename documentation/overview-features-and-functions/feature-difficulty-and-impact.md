# Feature Difficulty and Impact

We will discuss which of the following features to implement.

---

## 1. Achievements and Rewards (Least Difficult):
- **Difficulty**: Low
- **Reason**: This feature involves adding a system to track player milestones and achievements during the game. It can be implemented as an independent system without modifying existing game mechanics.
- **Impact**: This would add a layer of satisfaction and motivation for players, rewarding them for strategic play or completing challenges.
- **Core Functionality**: The feature doesn’t interfere with core gameplay mechanics. It simply tracks actions and outcomes to reward the player.

---

## 2. Battle History and Stats:
- **Difficulty**: Low to Medium
- **Reason**: Tracking stats like hits, misses, win/loss records, and games played is straightforward. It requires logging game data and displaying it in a readable format after each match.
- **Impact**: Adds a statistical element to the game, making it more engaging for players who enjoy tracking their performance and improving over time.
- **Core Functionality**: This feature enhances the game without altering gameplay mechanics. It only logs data from actions already happening in the game.

---

## 3. Timed Rounds:
- **Difficulty**: Medium
- **Reason**: This feature would add a time element to each round, requiring players to act within a specific time limit. While the logic itself is simple, implementing a countdown that integrates seamlessly with the turn-based system may require adjustments to the game flow.
- **Impact**: Timed rounds increase urgency and challenge, forcing players to make quicker decisions. It changes the pace of the game but doesn’t impact the strategy fundamentally.
- **Core Functionality**: The core gameplay (firing, placing ships, etc.) remains the same, but adding a timer adds an extra layer of challenge without altering fundamental rules.

---

## 4. Ship Customization:
- **Difficulty**: Medium
- **Reason**: Allowing players to customize the names and sizes of their ships adds complexity. This requires modifications to the setup phase, where players can input custom data, and additional validation to ensure that ships are balanced and gameplay remains fair.
- **Impact**: Enhances personalization and strategic depth as players choose their fleet.
- **Core Functionality**: The core game rules stay intact, but the customization adds variability to the initial setup phase.

---

## 5. Fog of War:
- **Difficulty**: Medium to High
- **Reason**: This feature would involve hiding parts of the board and revealing them gradually based on player actions (e.g., firing or using special abilities). Implementing this requires modifying the Board class and the `render` method to manage hidden areas and dynamically reveal them during gameplay.
- **Impact**: Adds suspense and strategic depth, as players won’t be able to see the full board until they scout or hit certain areas. It creates an element of uncertainty.
- **Core Functionality**: Although it affects how the board is displayed, the underlying mechanics of firing, hitting, and sinking ships remain unchanged.

---

## 6. Ship Abilities (Most Difficult):
- **Difficulty**: High
- **Reason**: Adding abilities to ships, such as a submarine’s ability to “dive” or a cruiser’s ability to use extra firepower, would require modifying the Ship class to include special abilities. This also requires changes to how turns are processed (e.g., activating abilities on a turn), managing cooldowns, and balancing the abilities to avoid disrupting gameplay.
- **Impact**: This feature adds a significant layer of strategy, as players will need to decide when to use their ship abilities for maximum effect.
- **Core Functionality**: The base rules of the game remain, but introducing abilities may alter the strategy in a way that requires careful balancing to ensure the game remains fair and fun.

---

## Summary of Difficulty and Impact:
1. **Achievements and Rewards** – Low difficulty, adds motivation without changing gameplay.
2. **Battle History and Stats** – Low to medium difficulty, adds tracking for performance.
3. **Timed Rounds** – Medium difficulty, adds urgency but keeps core gameplay intact.
4. **Ship Customization** – Medium difficulty, enhances personalization but keeps the core intact.
5. **Fog of War** – Medium to high difficulty, adds suspense while retaining core mechanics.
6. **Ship Abilities** – High difficulty, changes strategy but needs careful balancing to ensure core gameplay isn’t disrupted.

---

Each feature enhances the game experience in its own way, but none of them alter the fundamental rules or core mechanics. Instead, they add layers of complexity, personalization, and strategic depth, making the game more engaging while preserving its original structure.