require 'rspec'
require './lib/ship'

RSpec.configure do |config|
  config.formatter = :documentation
end

# RSpec test suite for the Ship class, which represents a ship with a name, length, and health.
RSpec.describe Ship do
  # JB - Before each test, set up a new Ship instance (Cruiser with length 3) for testing.
  before :each do
    @cruiser = Ship.new("Cruiser", 3)
  end

  # QD - Test to check if Ship object is created and has expected attributes.
  describe '#initialize' do
    it 'exists' do
      # Checks that a new Ship instance is created and not nil.
      expect(@cruiser).to be_a(Ship)
    end

    it 'has a name' do
      # Ensures the ship's name is correctly stored as "Cruiser".
      expect(@cruiser.name).to eq("Cruiser")
    end

    it 'has a length' do
      # Confirms that the ship's length is correctly stored as 3.
      expect(@cruiser.length).to eq(3)
    end

    it 'has health equal to its length initially' do
      # Verifies that the ship's health starts at 3, matching its length.
      expect(@cruiser.health).to eq(3)
    end
  end

  # JB - Test for the sunk? method, which checks if the ship is fully damaged (health is zero).
  describe '#sunk?' do
    it 'returns false when ship has health' do
      # Ensures the ship is not sunk initially.
      expect(@cruiser.sunk?).to be false
    end

    it 'returns true when health reaches zero' do
      # Reduces the ship's health to zero and confirms it is considered sunk.
      @cruiser.hit
      @cruiser.hit
      @cruiser.hit
      expect(@cruiser.sunk?).to be true
    end
  end

  # QD - Test for the hit method, which reduces the ship’s health by 1.
  describe '#hit' do
    it 'reduces health by one when hit' do
      # Checks that the health decreases from 3 to 2 after a hit.
      @cruiser.hit
      expect(@cruiser.health).to eq(2)
    end

    it 'does not reduce health below zero' do
      # Hits the ship until health would theoretically be negative, verifying it stays at zero.
      3.times { @cruiser.hit }
      expect(@cruiser.health).to eq(0)
      @cruiser.hit
      expect(@cruiser.health).to eq(0)
    end
  end
end