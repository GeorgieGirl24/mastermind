require 'game'
require 'computer'
require 'messages'
require 'turn'
require 'pry'

RSpec.describe Turn do
  it 'exsists and has attributes' do
    player_guess = 'RGBY'
    # computer_pattern = 'GRBY'
    game = Game.new
    computer = game.computer
    turn = Turn.new(player_guess, computer)
  end

  it 'can evaluate a player_response with "C"' do
    game = Game.new
    player_guess = 'C'
    # computer_pattern = game.computer_pattern
    computer = game.computer
    turn = Turn.new(player_guess, computer)

    # expect(game.evaluate_response('C')).to be_a String
    expect(turn.evaluate_response('C')).to eq nil
  end

  xit 'can evaluate a player_response with "Q"' do
    game = Game.new
    player_guess = 'Q'
    # computer_pattern = game.computer_pattern
    computer = game.computer
    turn = Turn.new(player_guess, computer)

    # expect(game.evaluate_response('Q')).to be_a String
    expect(turn.evaluate_response('Q')).to eq nil
  end

  it 'can evaluate a too short guess' do
    game = Game.new
    player_guess = 'RGB'
    computer = game.computer
    turn = Turn.new(player_guess, computer)

    expect(turn.too_short?).to eq true
    expect(turn.too_long?).to eq false
  end

  it 'can evaluate a too short guess' do
    game = Game.new
    player_guess = 'RGBYG'
    computer = game.computer
    turn = Turn.new(player_guess, computer)

    expect(turn.too_long?).to eq true
    expect(turn.too_short?).to eq false
  end

  it 'can reply the message of too short' do
    game = Game.new
    player_guess = 'RGB'
    computer = game.computer
    turn = Turn.new(player_guess, computer)

    response = 'Please try again. Your response is too short.'
    expect(Messages.message_too_short).to eq response
  end

  it 'can reply the message of too long' do
    game = Game.new
    player_guess = 'RGB'
    computer = game.computer
    turn = Turn.new(player_guess, computer)

    response = 'Please try again. Your response is too long.'
    expect(Messages.message_too_long).to eq response
  end

  it 'can evaluate the length of a player response and a computer pattern' do
    player_guess = 'RGBY'
    computer = instance_double('Computer', pattern: ['R', 'R', 'R', 'R'])
    turn = Turn.new(player_guess, computer)

    expect(turn.compare_player_computer).to eq false
  end

  it 'can count the number of letters in a sequence' do
    player_guess = 'RGBY'
    computer = instance_double('Computer', pattern: ['R', 'R', 'R', 'R'])
    turn = Turn.new(player_guess, computer)

    computer_expected = { 'R' => 4 }
    expect(turn.count_elements(computer.pattern)).to eq computer_expected
    player_expected = { 'R' => 1, 'G' => 1, 'B' => 1, 'Y' => 1 }
    expect(turn.count_elements(player_guess.split(''))).to eq player_expected
  end

  it 'can count and seperate by type (player)' do
    player_guess = 'RGBY'
    computer = instance_double('Computer', pattern: ['R', 'R', 'R', 'R'],
                                           level: 'beginner',
                                           letter_choices: {'beginner': ['R', 'B', 'G', 'Y']},
                                            number_characters: {'beginner': 4}
    )
    turn = Turn.new(player_guess, computer)

    player_elements = turn.count_elements(player_guess.split(''))

    player_expected = [{"R"=>{:player=>1}}, {"G"=>{:player=>1}}, {"B"=>{:player=>1}}, {"Y"=>{:player=>1}}]
    expect(turn.seperate_counted_elements(player_elements)).to eq player_expected
  end

  it 'can count and seperate by type (computer)' do
    player_guess = 'RGBY'
    computer = instance_double('Computer', pattern: ['G', 'R', 'Y', 'R'],
                                           level: 'beginner',
                                           letter_choices: {'beginner': ['R', 'B', 'G', 'Y']},
                                            number_characters: {'beginner': 4}
    )
    turn = Turn.new(player_guess, computer)

    computer_elements = turn.count_elements(computer.pattern)

    computer_expected = [ { "G" => { :computer=> 1} } , { "R" => { :computer => 2} }, { "Y" => { :computer => 1} } ]
    expect(turn.seperate_counted_elements(computer_elements)).to eq computer_expected
  end

  it 'can figure out on the guess if its computer or player' do
    player_guess = 'RGBY'
    computer = instance_double('Computer', pattern: ['G', 'R', 'Y', 'R'],
                                           level: 'beginner',
                                           letter_choices: {'beginner': ['R', 'B', 'G', 'Y']},
                                            number_characters: {'beginner': 4}
    )
    turn = Turn.new(player_guess, computer)
    computer_expected = { 'G' => 1, 'R' => 2, 'Y' => 1 }
    player_expected = { 'R' => 1, 'G' => 1, 'B' => 1, 'Y' => 1 }

    expect(turn.determine_type(player_expected)).to eq :player
    expect(turn.determine_type(computer_expected)).to eq :computer
  end

  it 'can group letters that match' do
    player_guess = 'RGBY'
    computer = instance_double('Computer', pattern: ['R', 'R', 'R', 'R'],
                                           level: 'beginner',
                                           letter_choices: {'beginner': ['R', 'B', 'G', 'Y']},
                                            number_characters: {'beginner': 4}
    )
    turn = Turn.new(player_guess, computer)

    player_elements = turn.seperate_counted_elements(turn.count_elements(player_guess.split('')))
    computer_elements = turn.seperate_counted_elements(turn.count_elements(computer.pattern))
# require "pry";binding.
    expected = {"R"=>[{:player=>1}, {:computer=>4}], "G"=>[{:player=>1}], "B"=>[{:player=>1}], "Y"=>[{:player=>1}]}
    expect(turn.compare_count_elements(player_elements, computer_elements)).to eq expected
  end

  it 'can count how many letters match' do
    player_guess = 'RGBY'
    computer = instance_double('Computer', pattern: ['G', 'R', 'G', 'Y'],
                                           level: 'beginner',
                                           letter_choices: {'beginner': ['R', 'B', 'G', 'Y']},
                                            number_characters: {'beginner': 4}
    )
    turn = Turn.new(player_guess, computer)
    player_elements = turn.seperate_counted_elements(turn.count_elements(player_guess.split('')))
    computer_elements = turn.seperate_counted_elements(turn.count_elements(computer.pattern))
# require "pry";binding.
    compared_groups = turn.compare_count_elements(player_elements, computer_elements)
    expect(turn.count_like_elements(compared_groups)).to eq 3
  end

  it 'can group counted elements' do
    player_guess = 'RGBY'
    computer = instance_double('Computer', pattern: ['G', 'R', 'G', 'Y'],
                                           level: 'beginner',
                                           letter_choices: {'beginner': ['R', 'B', 'G', 'Y']},
                                            number_characters: {'beginner': 4}
    )
    turn = Turn.new(player_guess, computer)

    player_elements = turn.seperate_counted_elements(turn.count_elements(player_guess.split('')))
    computer_elements = turn.seperate_counted_elements(turn.count_elements(computer.pattern))

    compared_groups = turn.compare_count_elements(player_elements, computer_elements)
    expect(turn.group_counted_elements(compared_groups)).to be_a Hash
    expected = {"R"=>[1, 1], "G"=>[1, 2], "B"=>[1], "Y"=>[1, 1]}
    expect(turn.group_counted_elements(compared_groups)).to eq expected
  end

  it 'can count how many elements are in the correct position' do
    player_guess = 'RGBY'
    computer = instance_double('Computer', pattern: ['G', 'R', 'G', 'Y'],
                                           level: 'beginner',
                                           letter_choices: {'beginner': ['R', 'B', 'G', 'Y']},
                                            number_characters: {'beginner': 4}
    )
    turn = Turn.new(player_guess, computer)

    expect(turn.number_correct_elements.class).to eq Integer
    expect(turn.number_correct_elements).to eq 1
    expect(turn.number_correct_elements).to_not eq 3
  end

  it 'can set the element into a hash with' do
    player_guess = 'RGBY'
    computer = instance_double('Computer', pattern: ['G', 'R', 'G', 'Y'],
                                           level: 'beginner',
                                           letter_choices: {'beginner': ['R', 'B', 'G', 'Y']},
                                            number_characters: {'beginner': 4}
    )
    turn = Turn.new(player_guess, computer)

    player_elements = turn.seperate_counted_elements(turn.count_elements(player_guess.split('')))
    computer_elements = turn.seperate_counted_elements(turn.count_elements(computer.pattern))

    player_expected = { "R"=>[{:player=>1}],
                        "G"=>[{:player=>1}],
                        "B"=>[{:player=>1}],
                        "Y"=>[{:player=>1}]
                      }
    computer_expected = { "R"=>[{:player=>1}, {:computer=>1}],
                          "G"=>[{:player=>1}, {:computer=>2}],
                          "B"=>[{:player=>1}],
                          "Y"=>[{:player=>1}, {:computer=>1}]
                        }
    expect(turn.count_player_element(player_elements)).to eq player_expected
    expect(turn.count_computer_element(computer_elements, player_expected)).to eq computer_expected
  end
end
