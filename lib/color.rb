require 'colorize'
require 'pry'
module Color
  def color_check_response(player_response)
    temp = player_response.split('').map do |letter|
      if letter == "R"
        letter.red
      elsif letter == "G"
        letter.green
      elsif letter == "B"
        letter.blue
      elsif letter == "Y"
        letter.yellow
      elsif letter == "M"
        letter.magenta
      elsif letter == "C"
        letter.cyan
      end
    end.join
  end

  def color_number_correct_elements(number_elements)
    if number_elements == "0"
      number_elements.white.bold
    elsif number_elements == "1"
      number_elements.light_yellow.bold
    elsif number_elements == "2"
      number_elements.yellow.bold
    elsif number_elements == "3"
      number_elements.light_green.bold
    elsif number_elements == "4"
      number_elements.cyan.bold
    elsif number_elements == "5"
      number_elements.white.on_red
    elsif number_elements == "6"
      number_elements.white.on_red
    elsif number_elements == "7"
      number_elements.white.on_red
    elsif number_elements == "8"
      number_elements.white.on_red
    end
    # binding.pry
  end

  def color_level_set(level)
    if level == 'beginner'
      "#{ "(r)ed".colorize(:red) }, #{ "(g)reen".green }, #{ "(b)lue".blue }, and #{ "(y)ellow".yellow }"
    elsif level == 'intermediate'
      "#{ "(r)ed".colorize(:red) }, #{ "(g)reen".green }, #{ "(b)lue".blue }, #{ "(y)ellow".yellow } and #{ "(m)agenta".magenta }"
    elsif level == 'advanced'
      "#{ "(r)ed".colorize(:red) }, #{ "(g)reen".green }, #{ "(b)lue".blue }, #{ "(y)ellow".yellow }, #{ "(m)agenta".magenta } and #{ "(c)yan".cyan }"
    end
  end

  def color_correct_positions(placed_correct_elements)
    if placed_correct_elements == "0"
      placed_correct_elements.white.bold
    elsif placed_correct_elements == "1"
      placed_correct_elements.light_yellow.bold
    elsif placed_correct_elements == "2"
      placed_correct_elements.yellow.bold
    elsif placed_correct_elements == "3"
      placed_correct_elements.light_green.bold
    elsif placed_correct_elements == "4"
      placed_correct_elements.cyan.bold
    elsif placed_correct_elements == "5"
      placed_correct_elements.white.on_red
    elsif placed_correct_elements == "6"
      placed_correct_elements.white.on_red
    elsif placed_correct_elements == "7"
      placed_correct_elements.white.on_red
    elsif placed_correct_elements == "8"
      placed_correct_elements.white.on_red
    end
  end

  def color_total_turns(total_turns)
    if total_turns <= "5"
      total_turns.light_yellow.bold
    elsif total_turns > "5" && total_turns <= "10"
      total_turns.yellow.bold
    elsif total_turns > "10" && total_turns <= "15"
      total_turns.white.bold
    elsif total_turns > "15" && total_turns <= "20"
      total_turns.gray.bold
    elsif total_turns > "20" && total_turns <= "25"
      total_turns.yellow.bold
    elsif total_turns > "25" && total_turns <= "30"
      total_turns.magenta.bold
    else
      total_turns.red.bold
    end
  end
end
