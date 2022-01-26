require 'game'
require 'messages'

RSpec.describe Game do
  it 'exsists and has attributes' do
    game = Game.new

    expect(game).to be_an_instance_of Game
    expect(game.computer).to be_an_instance_of Computer
  end

  it 'can give a welcome message' do
    game = Game.new

    # expect(game.welcome).to be_a String
    expect(game.welcome).to eq nil
  end

  it 'can give instructions for the game' do
    game = Game.new

    expect(game.instructions).to be_a String
  end

  it 'can quit the game' do
    game = Game.new

    expect(game.quit).to be_a String
  end

  it 'can give an option to play the game' do
    game = Game.new

    # expect(game.play).to be_a String
    expect(game.play).to eq nil
  end

  it 'can evaluate the response of player with a quit' do
    game = Game.new

    expect(game.evaluate_response('Q')).to eq nil
  end

  it 'can evaluate the response of player with a cheat' do
    game = Game.new

    # expect(game.evaluate_response('C')).to be_a String
    expect(game.evaluate_response('C')).to eq nil
  end

  it 'can evaluate the response of player with a play' do
    game = Game.new
    player_response = 'RRGB'
    # expect(game.start_game(player_response)).to be_a String
    expect(game.start_game(player_response)).to eq nil
  end

  it 'can print out a cheat to the screen' do
    message = Messages
    game = Game.new
    computer_pattern = ['RRGB']

    # response = "This is my secret '#{computer_pattern.join}'. Use with discression!/nWhat is your guess?"
    response = "What is your guess?"
    expect(message.message_cheat(computer_pattern)).to eq response
  end
end
