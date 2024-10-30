# lib/modules/difficulty_handler.rb

module DifficultyHandler
  def set_difficulty(choice)
    case choice
    when 1
      @difficulty = :calm_seas
      puts "You selected Calm Seas (Easy). Let's get started!"
    when 2
      @difficulty = :rough_waters
      puts "You selected Rough Waters (Normal). Let's get started!"
    when 3
      @difficulty = :war_zone_waters
      puts "You selected War Zone Waters (Medium). Let's get started!"
    when 4
      @difficulty = :deep_abyss
      puts "You selected Deep Abyss (Hard). Let's get started!"
    else
      @difficulty = :war_zone_waters
      puts "Invalid selection. Defaulting to War Zone Waters (Medium)."
    end
  end

  # Method to determine move based on difficulty level.
  def difficulty_move
    case @difficulty
    when :calm_seas
      easy_move
    when :rough_waters, :war_zone_waters
      medium_move
    when :deep_abyss
      hard_move
    else
      medium_move # Default
    end
  end

  # Easy difficulty logic - only random moves
  def easy_move
    random_guess
  end

  # Medium difficulty logic - mix of targeting and random moves
  def medium_move
    @target_queue.empty? ? random_guess : @target_queue.shift
  end

  # Hard difficulty logic - advanced targeting strategy
  def hard_move
    @target_queue.empty? ? random_guess : next_guess(@board)
  end

  private
  
  # Method for generating a random unfired coordinate
  def random_guess
    @board.random_unfired_coordinate
  end

  def advanced_guess
    if @target_queue.empty?
      random_guess
    else
      # Guess in a more focused way based on adjacent cells of previous hits
      @target_queue.shift
    end
  end
end