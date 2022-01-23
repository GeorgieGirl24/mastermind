require 'messages'

class Game
  include Messages
  def initialize

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
    evaluate_response(play_response)
  end

  def evaluate_response(player_response)
    cheat if player_response == 'C' || player_response == 'CHEAT'
    quit if player_response == 'Q' || player_response == 'QUIT'
    # elsif player_response == 'P' || player_response == 'PLAY'
    start_game(player_response)

    # end
  end

  def cheat
    "This is a cheat"
    message_cheat
    player_response = gets.chomp.upcase
    start_game(player_response)
  end

  def start_game(player_response)
    # require "pry";binding.pry

  end
end
