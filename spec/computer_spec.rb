require 'pry'
require "computer"

RSpec.describe Computer do
  it 'exists and has attributes' do
    computer = Computer.new
    expect(computer).to be_an_instance_of Computer
    expect(computer.level).to eq 'beginner'
    expect(computer.letter_choices).to be_a Hash
    expect(computer.letter_choices.count).to eq 3
    expect(computer.letter_choices[:beginner]).to be_an Array
    expect(computer.letter_choices[:beginner]).to eq ['R', 'B', 'G', 'Y']
    expect(computer.number_characters.count).to eq 3
  end

  it 'can find four elements' do
    computer = Computer.new

    expect(computer.pattern.count).to eq 4
    expect(computer.pattern).to be_an Array
    expect(computer.pattern.first).to be_a String
    expect(computer.pattern).to_not include 'M'
    expect(computer.pattern).to_not include 'C'
    expect(computer.pattern).to_not include 'A'
    expect(computer.pattern).to_not include 'L'
  end

  it 'can find six elements' do
    computer = Computer.new('intermediate')

    expect(computer.pattern.count).to eq 6
    expect(computer.pattern).to be_an Array
    expect(computer.pattern.first).to be_a String
    expect(computer.pattern).to_not include 'X'
    expect(computer.pattern).to_not include 'C'
    expect(computer.pattern).to_not include 'A'
    expect(computer.pattern).to_not include 'L'
  end

  it 'can find eight elements' do
    computer = Computer.new('advanced')

    expect(computer.pattern.count).to eq 8
    expect(computer.pattern).to be_an Array
    expect(computer.pattern.first).to be_a String
    expect(computer.pattern).to_not include 'X'
    expect(computer.pattern).to_not include 'P'
    expect(computer.pattern).to_not include 'A'
    expect(computer.pattern).to_not include 'L'
  end

end
