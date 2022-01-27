module Messages
  def message_welcome_introduction
    p "Welcome to MASTERMIND"
    p "Would you like to (p)lay, read the (i)nstructions, or (q)uit?"
    print "> "
    # puts
  end

  def message_instructions
    p 'The goal here is for you to guess the order of the colors that I have selected'
    p 'In this game, there are 4 colors that you may choose from. In order to select'
    p 'A color, press "(r)ed" or "(b)lue" or "(g)reen" or "(y)ellow".'
    p 'There can only four letter guessed, for a viable guess.'
    p 'Please only select the letters that are listed above.'
  end

  def message_quit
    p 'Goodbye!'
  end

  def message_play(level='beginner')
    p "I have generated a #{level} sequence with four elements made up of:"
    p '(r)ed, (g)reen, (b)lue, and (y)ellow. Use (q)uit at any time to end the game.'
  end

  def message_guess
    print "What's your guess? "
  end

  def self.message_cheat(computer_pattern)
    p "This is my secret '#{computer_pattern.join}'. Use with discression!"
    print 'What is your guess? '
  end

  def self.message_too_short
    p '🚨 Please try again. Your response is too short. 🚨'
  end

  def self.message_too_long
    p '🚨 Please try again. Your response is too long. 🚨'
  end

  def message_wrong_guess(player_response, placed_correct_elements, number_correct_positions)
    # p "#{ player_response } has #{ placed_correct_elements } of the correct elements with #{ number_correct_positions } in the correct positions."
    p "#{ player_response } has #{ number_correct_positions } of the correct elements with #{ placed_correct_elements } in the correct positions."
  end

  def message_number_of_turns(total_turns)
    p "You've taken #{total_turns} guesses"
  end

  def message_next_guess
    print "What's your next guess? "
  end

  def message_winner(total_turns)
    p "🎉You've guessed my secret code in #{ total_turns } guesses!🎉"
    print 'Would you care to play again? [y/n] '
  end

  def message_replay
    p 'As a reminder of how this is played...'
  end
end
