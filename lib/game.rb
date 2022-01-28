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
    @computer = Computer.new
    @computer_pattern = @computer.pattern
    @total_turns = 0
  end

  def welcome
    message_welcome_introduction
    start_response = gets.chomp.upcase
    evaluate(start_response)
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

  def play
    message_play
    message_guess
    play_response = gets.chomp.upcase
    start_game(play_response)
  end

  def cheat
    Messages.message_cheat(@computer.pattern)
    player_response = gets.chomp.upcase
    start_game(player_response)
  end

  def evaluate(player_response)
    if player_response == 'I' || player_response == 'INSTRUCTION'
      instructions
    elsif player_response == 'Q' || player_response == 'QUIT'
      quit
    elsif player_response == 'C' || player_response == 'CHEAT'
      cheat
    elsif player_response == 'P' || player_response == 'PLAY'
      play
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
      game = Game.new
      game.play
    else
      quit
    end
  end
end
