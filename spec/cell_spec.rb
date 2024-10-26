# Spec file for testing the Cell class
require 'spec_helper'
require_relative '../lib/cell'
require_relative '../lib/ship'  # Ensures Ship class is available for testing in Cell

RSpec.configure do |config|
  config.formatter = :documentation
end

RSpec.describe Cell do
  # JB: Basic initialization test for Cell class
  describe '#initialize' do
    it 'exists and has a coordinate' do
      cell = Cell.new("B4")
      expect(cell).to be_a(Cell)
      expect(cell.coordinate).to eq("B4")
      expect(cell.ship).to be_nil
    end
  end

  # JB: Testing ship placement functionality
  describe '#place_ship' do
    it 'can place a ship' do
      cell = Cell.new("B4")
      cruiser = Ship.new("Cruiser", 3)
      cell.place_ship(cruiser)
      expect(cell.ship).to eq(cruiser)
      expect(cell.empty?).to be false
    end
  end

  # Qory: Testing fire_upon method and its effect on the ship's health
  describe '#fire_upon' do
    it 'can be fired upon and affect the ship' do
      cell = Cell.new("B4")
      cruiser = Ship.new("Cruiser", 3)
      cell.place_ship(cruiser)
      expect(cell.fired_upon?).to be false
      cell.fire_upon
      expect(cell.fired_upon?).to be true
      expect(cell.ship.health).to eq(2)
    end
  end

  # JB and Qory: Testing render states for Cell, including hit, miss, sunk, and hidden ship options
  describe '#render' do
    it 'renders different states' do
      cell_1 = Cell.new("B4")
      expect(cell_1.render).to eq(".")
      
      cell_1.fire_upon
      expect(cell_1.render).to eq("M")

      cell_2 = Cell.new("C3")
      cruiser = Ship.new("Cruiser", 3)
      cell_2.place_ship(cruiser)
      
      expect(cell_2.render).to eq(".")
      expect(cell_2.render(true)).to eq("S")

      cell_2.fire_upon
      expect(cell_2.render).to eq("H")

      # Ensure rendering shows "X" if ship is sunk
      cruiser.hit
      cruiser.hit
      expect(cell_2.render).to eq("X")
    end
=======
# spec/cell_spec.rb
require 'rspec'
require './lib/cell'
require './lib/ship'

RSpec.describe Cell do
  
  # Test 1: Initializing a Cell
  it 'exists and has a coordinate' do
    # Create a new Cell object with the coordinate "B4"
    cell = Cell.new("B4")

    # Check that the cell is an instance of Cell
    expect(cell).to be_a(Cell)

    # Verify that the coordinate of the cell is "B4"
    expect(cell.coordinate).to eq("B4")

    # Ensure the cell initially has no ship assigned (should be nil)
    expect(cell.ship).to be_nil

    # Verify that the cell has not been fired upon yet (should be false)
    expect(cell.fired_upon?).to eq(false)
  end

  # Test 2: Placing a Ship in the Cell
  it 'can place a ship' do
    # Initialize a Cell and a Ship
    cell = Cell.new("B4")
    cruiser = Ship.new("Cruiser", 3)

    # Place the ship in the cell
    cell.place_ship(cruiser)

    # Verify that the cell's ship attribute now holds the cruiser
    expect(cell.ship).to eq(cruiser)

    # Check that the cell is no longer empty (should return false)
    expect(cell.empty?).to eq(false)
  end

  # Test 3: Firing Upon the Cell
  it 'can be fired upon and affect the ship' do
    # Initialize a Cell and a Ship
    cell = Cell.new("B4")
    cruiser = Ship.new("Cruiser", 3)
    cell.place_ship(cruiser)  # Place the ship in the cell

    # Ensure the cell has not been fired upon initially
    expect(cell.fired_upon?).to eq(false)

    # Fire upon the cell
    cell.fire_upon

    # Check that the cell's fired_upon? method now returns true
    expect(cell.fired_upon?).to eq(true)

    # Verify that the ship's health has decreased (from 3 to 2)
    expect(cruiser.health).to eq(2)
  end

  # Test 4: Rendering the Cell
  it 'renders different states' do
    # Initialize two cells and a ship
    cell_1 = Cell.new("B4")
    cell_2 = Cell.new("C3")
    cruiser = Ship.new("Cruiser", 3)

    # Place the cruiser in cell_2
    cell_2.place_ship(cruiser)

    # Test rendering for cell_1, which is empty and unfired-upon
    expect(cell_1.render).to eq(".")

    # Test rendering for cell_2 with a ship, showing it due to reveal option
    expect(cell_2.render(true)).to eq("S")

    # Fire upon cell_1 (empty) and cell_2 (with cruiser)
    cell_1.fire_upon
    cell_2.fire_upon

    # Test rendering for cell_1 after being fired upon and found empty (miss)
    expect(cell_1.render).to eq("M")

    # Test rendering for cell_2 after being fired upon and hit (hit)
    expect(cell_2.render).to eq("H")

    # Hit the cruiser twice more to sink it, then check rendering
    cruiser.hit
    cruiser.hit
    expect(cell_2.render).to eq("X")  # Ship has been sunk
  end
end