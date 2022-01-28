require 'pry'
class Computer
  attr_reader :level, :pattern, :letter_choices, :number_characters
  def initialize(level='beginner')
    @level = level
    @letter_choices = {
                        'beginner': ['R', 'B', 'G', 'Y'],
                        'intermediate': ['R', 'B', 'G', 'Y', 'M'],
                        'advanced': ['R', 'B', 'G', 'Y', 'M', 'C']
    }
    @number_characters = {
                          'beginner': 4,
                          'intermediate': 6,
                          'advanced': 8
    }
    @pattern = pattern_maker
  end

  def pattern_maker
    the_pattern = []
    until the_pattern.length == @number_characters[level.to_sym] do
       the_pattern << @letter_choices[level.to_sym].sample
    end
    the_pattern
  end
end
