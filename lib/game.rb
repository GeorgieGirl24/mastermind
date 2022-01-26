require 'messages'
require 'computer'

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
      # play
    # else
    require "pry";binding.pry
      turn.compare_count_elements(player_elements, computer_elements)
      @total_turns += 1
      meassage_wrong_guess(player_response)
    end
  end
end
