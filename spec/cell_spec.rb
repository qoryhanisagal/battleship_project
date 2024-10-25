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
  end
end