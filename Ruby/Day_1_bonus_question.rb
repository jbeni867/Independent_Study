max = 10
min = 0
correct_guess = rand(max)
print 'Guess the correct number between 0-9: '
player_guess = gets.chomp.to_i
while player_guess != correct_guess
    print "Guess was above the max(0-9), try again.\nGuess the correct number: " if player_guess > max.pred
    print "Guess was below the min(0-9), try again.\nGuess the correct number: " if player_guess <= min
    print "Guess was too low, try again.\nGuess the correct number: " if player_guess < correct_guess && player_guess > min
    print "Guess was too high, try again.\nGuess the correct number: " if player_guess > correct_guess && player_guess < max

    player_guess = gets.chomp.to_i
end
puts "Congrats!! You guessed the correct number #{correct_guess}!!"