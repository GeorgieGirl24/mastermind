require 'pry'
require_relative 'messages'

class Turn
  include Messages
  attr_reader :player_guess, :computer
  def initialize(player_guess, computer)
    @player_guess = player_guess
    @computer = computer
  end

  def compare_player_computer
    @player_guess == @computer.pattern.join
  end

  def count_elements(element)
    # element needs to be an array
    element.inject(Hash.new(0)){ |h,k| h[k.capitalize] += 1;h }
    # return value is a hash
  end

  def seperate_counted_elements(element)
    # element must be a Hash
    type = determine_type(element)
    hash = {}
    element.map do |letter, number|
      hash[letter] = {type => number}
    end
    hash
    # return value is an hash
  end

  def compare_count_elements(player_elements, computer_elements)
    # elements need to be both hashes
    count_computer_element(computer_elements, count_player_element(player_elements))
    # return value is a hash
  end

  def count_player_element(player_elements)
    hash = {}
    player_elements.each do |letter, number|
      hash[letter] = [number]
    end
    hash
  end

  def count_computer_element(computer_elements, count_player_elements)
    hash = count_player_elements
    computer_elements.each do |letter, number|
      if !hash[letter]
        hash[letter] = [number]
      else
        hash[letter] << number
      end
    end
    hash
  end

  def determine_type(element)
    test = []
    element.map do |letter, number|
      number.times do
        test << letter
      end
    end
    if test.join == player_guess
      :player
    else
      :computer
    end
  end

  def count_like_elements(elements)
    # elements must be a hash
    temp = elements.map do |letter, numbers|
      if numbers.count > 1
        if numbers.first == numbers.last
          numbers.last
        else
          numbers.min
        end
      else
        0
      end
    end.sum
    temp
    # return value is an integer
  end

  def group_counted_elements(elements)
    # elements must be a hash
    hash = {}
    elements.map do |k,v|
      v.map do |element|
        if !hash[k]
          hash[k] = [v.sum]
        else
          hash[k] << v.sum
        end
      end
    end
    hash
  end

  def number_correct_elements
    compared = @player_guess.split('').zip(computer.pattern)
    compared.count do |set|
      set[0] == set[1]
    end
  end
end
