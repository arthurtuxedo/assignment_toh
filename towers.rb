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
  # Ask player to input the number of discs. If the answer is not between 1 and 8, loop until it is.
  max_value = 0
  until max_value >= 1 && max_value <= 8
    puts "How many discs would you like to use? (1-8)"
    max_value = gets.chomp.to_i
  end
  # Set the three pegs to arrays that contain discs 1-8. At beginning, all discs are on pegs[0], largest on bottom
  pegs = [1.upto(max_value).to_a.reverse,[],[]]
  # Keep looping the game until all discs are in order on the middle or right peg, which is our victory condition
  until pegs[1] == 1.upto(max_value).to_a.reverse || pegs[2] == 1.upto(max_value).to_a.reverse do
    # Call our render function to show the user the current arrangement of discs.
    render(pegs)
    # Ask the user the peg numbers to move the top disc from and to. Split the response into an array that will be passed as arguments for later functions.
    puts "Please enter the number of the peg you would like to move FROM, followed by the peg to move TO (ie 1,3). Enter q to quit:"
    user_input = gets.chomp.split(",")
    if user_input == ["q"]
      player_quit = true
      break
    else
      #First we check if the requested move is legal. If so, then we move the disc to the specified peg.
      if check_if_legal(user_input[0].to_i,user_input[1].to_i,pegs)
        pegs = move_disc(user_input[0].to_i,user_input[1].to_i,pegs)
      else
        #If the move is not legal, we use the next command to cycle back through the loop.
        next
      end
    end
  end
  if player_quit; puts "A quitter is you!" else puts "A winner is you!" end
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
  if pegs[from-1].empty?
    puts "Invalid entry. Ring #{from} does not contain a disc."
    return false
  elsif pegs[to-1].empty? || pegs[to-1].last > pegs[from-1].last
    # Return true and advance to the move_disc function if the destination peg is either empty or its last disc is larger than the one we are trying to move.
    return true
  else
    puts "Invalid entry. Larger blocks cannot be moved on top of smaller blocks."
    return false
  end
end

def move_disc(from,to,pegs)
  current_disc = pegs[from-1].pop
  pegs[to-1] << current_disc
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
