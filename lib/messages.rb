require "colorize"
require 'pry'

module Messages
  def message_welcome_introduction
    puts "Welcome to MASTERMIND".white
    puts "Would you like to (p)lay, read the (i)nstructions, or (q)uit?"
    print "> "
    # puts
  end

  def message_instructions
    # binding.pry
    puts 'The goal here is for you to guess the order of the colors that I have selected'
    puts 'In this game, there are 4 colors that you may choose from. In order to select'
    puts "a color, press #{ "(r)ed".colorize(:red) } or #{ "(b)lue".blue } or #{ "(g)reen".green } or #{ "(y)ellow".yellow }."
    puts 'There can only four letter guessed, for a viable guess.'
    puts 'Please only select the letters that are listed above.'
  end

  def message_quit
    puts 'Goodbye!'
    puts
  end

  def message_play(level='beginner')
    puts "I have generated a #{level} sequence with four elements made up of:"
    puts "#{ "(r)ed".colorize(:red) }, #{ "(g)reen".green }, #{ "(b)lue".blue }, and #{ "(y)ellow".yellow }. Use (q)uit at any time to end the game."
  end

  def message_guess
    print "What's your guess? "
  end

  def self.message_cheat(computer_pattern)
    puts "This is my secret '#{computer_pattern.join}'. Use with discression!"
    print 'What is your guess? '
  end

  def self.message_too_short
    puts '🚨 Please try again. Your response is too short. 🚨'
  end

  def self.message_too_long
    puts '🚨 Please try again. Your response is too long. 🚨'
  end

  def message_wrong_guess(player_response, placed_correct_elements, number_correct_positions)
    # p "#{ player_response } has #{ placed_correct_elements } of the correct elements with #{ number_correct_positions } in the correct positions."
    puts "#{ player_response } has #{ number_correct_positions } of the correct elements with #{ placed_correct_elements } in the correct positions."
  end

  def message_number_of_turns(total_turns)
    puts "You've taken #{total_turns} guesses"
    puts
  end

  def message_next_guess
    print "What's your next guess? "
  end

  def message_winner(total_turns)
    puts
    puts "🎉 You've guessed my secret code in #{ total_turns } guesses! 🎉".bold
    print 'Would you care to play again? [y/n] '
  end

  def message_replay
    puts 'As a reminder of how this is played...'
  end
end
