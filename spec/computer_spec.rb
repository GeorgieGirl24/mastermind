require "computer"

RSpec.describe Computer do
  it 'exists and has attributes' do
    computer = Computer.new

    expect(computer).to be_an_instance_of Computer
    expect(computer.size).to eq 4
  end

  it 'can find four elements' do
    computer = Computer.new

    expect(computer.pattern.count).to eq 4
    expect(computer.pattern).to be_an String
  end
end
