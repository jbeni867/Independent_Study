# Print the string “Hello, world.”
irb(main):001:0> puts 'Hello, world.'
Hello, world.
=> nil

# For the string “Hello, Ruby,” find the index of the word “Ruby.”
irb(main):001:0> puts 'Hello, world.'
Hello, world.
=> nil
irb(main):002:0> find_index = "Hello, Ruby,"
=> "Hello, Ruby,"
irb(main):003:0> find_index.class
=> String
irb(main):004:0> find_index.index('Ruby.')
=> nil

# Print your name ten times.
irb(main):001:0> puts 'Hello, world.'
Hello, world.
=> nil
irb(main):002:0> find_index = "Hello, Ruby,"
=> "Hello, Ruby,"
irb(main):003:0> find_index.class
=> String
irb(main):004:0> find_index.index('Ruby.')
=> nil
irb(main):005:0> name = 'Jordy'
=> "Jordy"
irb(main):006:0> i = 0
=> 0
irb(main):007:0> while i < 10
irb(main):008:1> puts name
irb(main):009:1> i = i.next
irb(main):010:1> end
Jordy
Jordy
Jordy
Jordy
Jordy
Jordy
Jordy
Jordy
Jordy
Jordy
=> nil

# Print the string “This is sentence number 1,” where the number 1 changes from 1 to 10.
irb(main):001:0> puts 'Hello, world.'
Hello, world.
=> nil
irb(main):002:0> find_index = "Hello, Ruby,"
=> "Hello, Ruby,"
irb(main):003:0> find_index.class
=> String
irb(main):004:0> find_index.index('Ruby.')
=> nil
irb(main):005:0> name = 'Jordy'
=> "Jordy"
irb(main):006:0> i = 0
=> 0
irb(main):007:0> while i < 10
irb(main):008:1> puts name
irb(main):009:1> i = i.next
irb(main):010:1> end
Jordy
Jordy
Jordy
Jordy
Jordy
Jordy
Jordy
Jordy
Jordy
Jordy
=> nil
irb(main):011:0> puts i
10
=> nil
irb(main):012:0> i = 1
=> 1
irb(main):013:0> while i < 11
irb(main):014:1> puts "This is sentence number #{i},"
irb(main):015:1> i = i.next
irb(main):016:1> end
This is sentence number 1,
This is sentence number 2,
This is sentence number 3,
This is sentence number 4,
This is sentence number 5,
This is sentence number 6,
This is sentence number 7,
This is sentence number 8,
This is sentence number 9,
This is sentence number 10,
=> nil

# Run a Ruby program from a file. (Did the bonus question for this one since I needed a program to run)
irb(main):001:0> puts 'Hello, world.'
Hello, world.
=> nil
irb(main):002:0> find_index = "Hello, Ruby,"
=> "Hello, Ruby,"
irb(main):003:0> find_index.class
=> String
irb(main):004:0> find_index.index('Ruby.')
=> nil
irb(main):005:0> name = 'Jordy'
=> "Jordy"
irb(main):006:0> i = 0
=> 0
irb(main):007:0> while i < 10
irb(main):008:1> puts name
irb(main):009:1> i = i.next
irb(main):010:1> end
Jordy
Jordy
Jordy
Jordy
Jordy
Jordy
Jordy
Jordy
Jordy
Jordy
=> nil
irb(main):011:0> puts i
10
=> nil
irb(main):012:0> i = 1
=> 1
irb(main):013:0> while i < 11
irb(main):014:1> puts "This is sentence number #{i},"
irb(main):015:1> i = i.next
irb(main):016:1> end
This is sentence number 1,
This is sentence number 2,
This is sentence number 3,
This is sentence number 4,
This is sentence number 5,
This is sentence number 6,
This is sentence number 7,
This is sentence number 8,
This is sentence number 9,
This is sentence number 10,
=> nil
irb(main):017:0> load 'Day_1_bonus_question.rb'
Guess the correct number between 0-9: 10
Guess was above the max(0-9), try again.
Guess the correct number: 0
Guess was below the min(0-9), try again.
Guess the correct number: 8
Guess was too high, try again.
Guess the correct number: 2
Guess was too low, try again.
Guess the correct number: 4
Congrats!! You guessed the correct number 4!!
=> true
irb(main):018:0>

# Bonus problem: If you’re feeling the need for a little more, write a program that picks a random number. Let a player guess the number, telling the player whether the guess is too low or too high.
# (Hint: rand(10) will generate a random number from 0 to 9, and gets will read a string from the keyboard that you can translate to an integer.)

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