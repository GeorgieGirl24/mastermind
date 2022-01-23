module Messages
  def message_welcome_introduction
    p "Welcome to MASTERMIND"
    p "Would you like to (p)lay, read the (i)nstructions, or (q)uit?"
    p "> "
    puts
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

  def message_play
    p 'I have generated a beginner sequence with four elements made up of:'
    p '(r)ed, (g)reen, (b)lue, and (y)ellow. Use (q)uit at any time to end the game.'
    p "What's your guess?"
  end

  def message_cheat
    p 'This is the cheat!'
    p 'What is your guess?'
  end
end
