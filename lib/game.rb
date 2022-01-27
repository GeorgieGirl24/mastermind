require_relative 'messages'
require_relative 'computer'
require_relative 'turn'

class Game
  include Messages
  attr_reader :computer, :computer_pattern, :total_turns

  def initialize(level='beginner')
    @computer = Computer.new
    @computer_pattern = @computer.pattern
    @total_turns = 0
  end

  def welcome
    message_welcome_introduction
    start_response = gets.chomp.upcase
    if start_response == 'I' || start_response == 'INTRODUCTION'
      instructions
    elsif start_response == 'Q' || start_response == 'QUIT'
      quit
    elsif start_response == 'P' || start_response == 'PLAY'
      play
    end
  end

  def instructions
    message_instructions
  end

  def quit
    message_quit
    exit(true)
  end

  def play
    message_play
    play_response = gets.chomp.upcase
    start_game(play_response)
    # evaluate_response(play_response)
  end

  def start_game(player_response)
    while player_response != @computer_pattern.join
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
    if player_response == @computer_pattern.join
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
end
