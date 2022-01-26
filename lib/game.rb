require 'messages'
require 'computer'

class Game
  include Messages
  attr_reader :computer, :computer_pattern

  def initialize(level='beginner')
    @computer = Computer.new
    @computer_pattern = @computer.pattern
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
    # require "pry";binding.pry
    turn = Turn.new(play_response, @computer)
  end
end
