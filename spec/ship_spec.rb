# Spec file for testing the Ship class
require 'spec_helper'
require_relative '../lib/ship'

RSpec.configure do |config|
  config.formatter = :documentation
end

RSpec.describe Ship do
  # JB: Initial setup and basic tests for the Ship class initialization
  describe '#initialize' do
    it 'exists' do
      cruiser = Ship.new('Cruiser', 3)

      expect(cruiser).to be_a Ship
    end

    it 'has a name' do
      cruiser = Ship.new('Cruiser', 3)

      expect(cruiser.name).to eq 'Cruiser'
    end

    it 'has a length' do
      cruiser = Ship.new('Cruiser', 3)

      expect(cruiser.length).to eq 3
    end

    it 'has health equal to its length initially' do
      cruiser = Ship.new('Cruiser', 3)

      expect(cruiser.health).to eq 3
    end
  end

  # JB: Added hit test to reduce health upon a hit
  # QORY: Added test for safeguard on health not going below zero
  describe '#hit' do
    it 'reduces health by one when hit' do
      cruiser = Ship.new('Cruiser', 3)
      cruiser.hit
      expect(cruiser.health).to eq 2
    end

    it 'does not reduce health below zero' do
      cruiser = Ship.new('Cruiser', 3)
      
      3.times { cruiser.hit }  # Bringing health to zero
      cruiser.hit  # Extra hit after sunk
      
      expect(cruiser.health).to eq 0
    end
  end

  # JB: Added test to confirm ship sinks when health reaches zero
  describe '#sunk?' do
    it 'returns true when the ship is sunk (health is zero)' do
      cruiser = Ship.new('Cruiser', 3)
      
      3.times { cruiser.hit }  # Hitting until sunk
      
      expect(cruiser.sunk?).to be true
    end

    it 'returns false when the ship is not yet sunk' do
      cruiser = Ship.new('Cruiser', 3)
      
      2.times { cruiser.hit }  # Health still above zero
      
      expect(cruiser.sunk?).to be false
    end
  end
end