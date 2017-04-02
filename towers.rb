# Tower of Hanoi
# We have 3 rings and 3 discs of increasing size
# We need a method of moving the top-most disc to another ring that does not
#   already have a smaller ring on top.
# We need to keep track of where each disc is and / or the disc configuration
#   of each ring. The rings can have 3 possible size values on the bottom stack,
#   2 on the middle, and only 1 on top.
# We must make sure that the user enters an integer between 1 and 3 on the from
#   and to inputs.
# We must render some kind of visual representation after each move.

puts "Welcome to Tower of Hanoi!"
puts "Your goal is to move the tower from the left-most ring to the middle or right."
puts "You can only move the top-most disc, and only onto a ring that does not contain a smaller disc than the one you are moving."

def start_game_loop
  puts "How many discs would you like to use?"
  max_value = gets.chomp.to_i
  pegs = [[1.upto(max_value).to_a.reverse],[],[]]
  until pegs[1] == 1.upto(max_value).to_a.reverse || pegs[2] == 1.upto(max_value).to_a.reverse do
    render(pegs)
    puts "Please enter the number of the ring you would like to move FROM, followed by the ring to move TO (ie 1,3). Enter q to quit:"
    user_input = gets.chomp.split(",")
    if user_input == ["q"]
      puts "Thanks for playing!"
      break
    else
      if check_if_legal(user_input[0].to_i,user_input[1].to_i,pegs)
        pegs = move_disc(user_input[0].to_i,user_input[1].to_i,pegs)
      else
        next
      end
    end
  end
  puts "A winner is you!"
end

def render(pegs)
  print pegs
  puts ""
end

def check_if_legal(from,to,pegs)
  if from < 1 || to < 1 || from > 3 || to > 3
    puts "Invalid entry. Please enter a ring number between 1 and 3"
    return false
  end
  if pegs[to].nil?
    return true
  elsif pegs[to].empty? || pegs[to].last > pegs[from].last
    return true
  else
    puts "Invalid entry. Larger blocks cannot be moved on top of smaller blocks."
  end
end

def move_disc(from,to,pegs)
  current_disc = pegs[from].pop
  pegs[to] << current_disc
  return pegs
end

start_game_loop

# until right_peg == 1.upto(max_value).to_a.reverse do
#   current_move = left_peg.pop
#   if right_peg.empty? && current_move == max_value
#     right_peg << current_move
#   elsif right_peg.empty? && current_move != max_value
#     middle_peg << current_move


  # if user_input == "1,2"
  #   current_disc = left_peg.pop
  #   middle_peg.push(current_disc)
  # elsif user_input == "1,3"
  #   current_disc = left_peg.pop
  #   right_peg.push(current_disc)
  # elsif user_input == "2,1"
  #   current_disc = middle_peg.pop
  #   left_peg.push(current_disc)
  # elsif user_input == "2,3"
  #   current_disc = middle_peg.pop
  #   right_peg.push(current_disc)
  # elsif user_input == "3,1"
  #   current_disc = right_peg.pop
  #   left_peg.push(current_disc)
  # elsif user_input == "3,2"
  #   current_disc = right_peg.pop
  #   middle_peg.push(current_disc)
