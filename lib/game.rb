require_relative 'messages'
require_relative 'color'
require_relative 'computer'
require_relative 'turn'

class Game
  include Messages
  include Color
  attr_reader :computer,
              :computer_pattern,
              :total_turns

  def initialize(level='beginner')
    @computer = Computer.new(level)
    @computer_pattern = @computer.pattern
    @total_turns = 0
  end

  def welcome
    message_welcome_introduction
    start_response = gets.chomp.upcase
    evaluate(start_response)
  end

  def level_choice
    message_level_choice
    player_level_choice = gets.chomp.downcase
    if (player_level_choice != 'b' || player_level_choice != 'beginner') &&
      (player_level_choice == 'i' || player_level_choice == 'intermediate') ||
      (player_level_choice == 'a' || player_level_choice == 'advanced')
      if player_level_choice == 'i' || player_level_choice == 'intermediate'
        @computer = Computer.new('intermediate')
        @computer_pattern = @computer.pattern
        play('intermediate', @computer.number_characters[:intermediate])
      else
        @computer = Computer.new('advanced')
        @computer_pattern = @computer.pattern
        play('advanced', @computer.number_characters[:advanced])
      end
    else
      evaluate_level(player_level_choice)
    end
  end

  def instructions
    message_instructions
    message_guess
    play_response = gets.chomp.upcase
    start_game(play_response)
  end

  def quit
    message_quit
    exit(true)
  end

  def play(level='beginner', number_characters=4)
    message_play(level, number_characters)
    message_guess
    play_response = gets.chomp.upcase
    start_game(play_response)
  end

  def cheat
    Messages.message_cheat(@computer.pattern)
    player_response = gets.chomp.upcase
    start_game(player_response)
  end

  def evaluate_level(player_response)
    if player_level_choice == 'i' || player_level_choice == 'intermediate'
      'intermediate'
    elsif player_level_choice == 'a' || player_level_choice == 'advanced'
      'advanced'
    else
      message_level_error
      level_choice
    end
  end

  def evaluate(player_response)
    if player_response == 'I' || player_response == 'INSTRUCTION'
      instructions
    elsif player_response == 'Q' || player_response == 'QUIT'
      quit
    elsif player_response == 'C' || player_response == 'CHEAT'
      cheat
    elsif player_response == 'P' || player_response == 'PLAY'
      level_choice
    elsif player_response.length != @computer.number_characters[@computer.level.to_sym]
      evaluate_length(player_response)
      player_response = gets.chomp.upcase
      start_game(player_response)
    end
  end

  def evaluate_length(player_response)
    if too_short?(player_response)
      Messages.message_too_short
      message_guess
    elsif too_long?(player_response)
      Messages.message_too_long
      message_guess
    end
  end

  def too_short?(player_response)
    player_response.length < @computer.number_characters[@computer.level.to_sym]
  end

  def too_long?(player_response)
    player_response.length > @computer.number_characters[@computer.level.to_sym]
  end

  def start_game(player_response)
    while player_response != @computer_pattern.join
      evaluate(player_response)
      turn = Turn.new(player_response, @computer)
      player_elements = turn.count_elements(player_response.split(''))
      computer_elements = turn.count_elements(@computer.pattern)

      compared_counts = turn.compare_count_elements(player_elements, computer_elements)
      guessed_correct_elements = turn.number_correct_elements
      number_correct_positions = turn.count_like_elements(compared_counts)
      @total_turns += 1

      message_wrong_guess(player_response, guessed_correct_elements, number_correct_positions)
      message_number_of_turns(@total_turns)
      message_next_guess
      player_response = gets.chomp.upcase
    end

    matched_pair
  end

  def matched_pair
    @total_turns += 1
    message_winner(@total_turns)
    play_again = gets.chomp.upcase
    if play_again == 'Y' || play_again == 'YES'
      message_replay
      level_choice
      game = Game.new
      game.play
    else
      quit
    end
  end

  def replay
    message_level_choice
    player_level_choice = gets.chomp.downcase
    if player_level_choice == 'i' || player_level_choice == 'intermediate'
      game = Game.new('intermediate')
      game.play('intermediate', @computer.number_characters[:intermediate])
    elsif player_level_choice == 'i' || player_level_choice == 'intermediate'
      game = Game.new('advanced')
      game.play('advanced', @computer.number_characters[:advanced])
    elsif player_level_choice == 'b' || player_level_choice == 'beginner'
      game = Game.new
      game.play
    else
    evaluate_level(player_level_choice)
    end
  end
end
