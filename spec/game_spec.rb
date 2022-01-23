require 'game'
RSpec.describe Game do
  it 'exsists and has attributes' do
    game = Game.new

    expect(game).to be_an_instance_of Game
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

  xit 'can quit the game' do
    game = Game.new

    expect(game.quit).to be_a String
  end

  xit 'can give an option to play the game' do
    game = Game.new

    expect(game.play).to be_a String
  end

  xit 'can evaluate the response of player with a quit' do
    game = Game.new

    expect(game.evaluate_response('Q')).to eq nil
  end

  it 'can evaluate the response of player with a cheat' do
    game = Game.new

    expect(game.evaluate_response('C')).to be_a String
  end

  it 'can evaluate the response of player with a play' do
    game = Game.new
    player_response = 'RRGB'
    expect(game.start_game(player_response)).to be_a String
  end
end
