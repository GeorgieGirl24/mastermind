require 'game'
require 'messages'
require 'turn'

RSpec.describe Game do
  it 'exsists and has attributes' do
    game = Game.new

    expect(game).to be_an_instance_of Game
    expect(game.computer).to be_an_instance_of Computer
    expect(game.computer_pattern).to be_an_instance_of Array
    expect(game.total_turns).to eq 0
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

    # expect(game.play).to be_a String
    expect(game.play).to eq nil
  end

  xit 'can evaluate the response of player with a quit' do
    game = Game.new

    expect(game.evaluate_response('Q')).to eq nil
  end

  xit 'can evaluate the response of player with a cheat' do
    game = Game.new

    # expect(game.evaluate_response('C')).to be_a String
    expect(game.evaluate_response('C')).to eq nil
  end

  xit 'can evaluate the response of player with a play' do
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

  it 'can keep track of how many turns have happened in the game' do
    computer_instance = instance_double('Computer', pattern: ['G', 'R', 'G', 'Y'],
                                           level: 'beginner',
                                           letter_choices: {'beginner': ['R', 'B', 'G', 'Y']},
                                           number_characters: {'beginner': 4}
    )
    player_response1 = 'RRRR'
    # game = instance_double('Game', computer: computer_instance,
    #                                computer_pattern: computer_instance.pattern,
    #                                total_turns: 0,
    #                                start_game: player_response1)
    game = Game.new
    # turn = Turn.new(player_response1, computer_instance)
    game.start_game(player_response1)
    # require "pry";binding.pry
    expect(game.total_turns).to eq 1
  end
end
