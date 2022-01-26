require 'pry'
require 'messages'

class Turn
  include Messages
  attr_reader :player_guess, :computer # :computer_pattern
  def initialize(player_guess, computer) #computer_pattern
    @player_guess = player_guess
    # @computer_pattern = computer_pattern
    @computer = computer
  end

  def evaluate_response(player_response)
    cheat if player_response == 'C' || player_response == 'CHEAT'
    quit if player_response == 'Q' || player_response == 'QUIT'
    start_turn
  end

  def cheat
    "This is a cheat"
    Messages.message_cheat(@computer.pattern)
    player_response = gets.chomp.upcase
    start_turn
  end

  def quit
    message_quit
    exit(true)
  end

  def start_turn

  end

  def evaluate_length
    if too_short?
      message_too_short
    elsif too_long?
      message_too_long
    end
  end

  def too_short?
    player_guess.length < @computer.number_characters[@computer.level.to_sym]
  end

  def too_long?
    player_guess.length > @computer.number_characters[@computer.level.to_sym]
  end

  def compare_player_computer
    @player_guess == @computer.pattern.join
  end

  def count_elements(element)
    # element needs to be an array
    element.inject(Hash.new(0)){ |h,k| h[k.capitalize] += 1;h }
    # return value is a hash
  end

  def seperate_counted_elements(element)#, type)
    # element must be a Hash
    type = determine_type(element)
    element.map do |letter, number|
      {letter => {type => number}}
    end
    # return value is an array
  end

  def compare_count_elements(player_elements, computer_elements)
    # elements need to be both hashes
    hash = {}
    player_elements.each do |element|
       hash[element.keys.first] = [element.values.first]
     end

    computer_elements.each do |element|
      if !hash[element.keys.first]
         hash[element.keys.first] = [element.values.first]
      else
        hash[element.keys.first] << element.values.first
      end
    end
    hash
  end

  def determine_type(element)
    if element.class == String || element.keys.join == player_guess
      :player
    else
      :computer
    end
  end

  def count_like_elements(elements)
    # elements must be a hash
    group_counted_elements(elements).values.map do |element|
      if element.count > 1
        if element.first == element.last
          element.last
        else
          element.find {|i| i >= i}
        end
      else
        0
      end
    end.sum
    # return value is an integer
  end

  def group_counted_elements(elements)
    # elements must be a hash
    hash = {}
    elements.map do |k,v|
      v.map do |element|
        if !hash[k]
          hash[k] = [element.values.sum]
        else
          hash[k] << element.values.sum
        end
      end
    end
    hash
  end
end
