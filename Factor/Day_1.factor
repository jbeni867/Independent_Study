! QUESTION 1
! Using only * and +, how would you calculate 32 + 42 with Factor?
3 3 * 4 4 * +

! QUESTION 2
! Enter USE: math.functions in the Listener. Now, with sq and sqrt, calculate the square root of 32 + 42.
USE: math.functions
3 sq 4 sq + sqrt

! QUESTION 3
! If you had the numbers 1 2 on the stack, what code could you use to end up with 1 1 2 on the stack?
over
over swap

! QUESTION 4
! Enter USE: ascii in the Listener. Put your name on the stack, and write a line of code that puts "Hello, " in front of your name and converts the whole string to uppercase. Use the append word to concatenate two strings and >upper to convert to uppercase. Did you have to do any stack shuffling to get the desired result?
USE: ascii
"Alice" "Hello, " swap append >upper

! QUESTION 5
! The reduce word takes a sequence, an initial value, and a quotation and returns the result of applying the quotation to the initial value and the first element of the sequence, then the result of applying the quotation to the result and the next element of the sequence, and so on. Using reduce, write a line of code that returns the sum of the numbers 1, 4, 17, 9, 11. Try it out on your own first, but if you are truly stuck, look back carefully over the pages you’ve just read. There is a hint hiding somewhere.
{ 1 4 17 9 11 } 0 [ + ] reduce

! QUESTION 6
! Now calculate the sum of the numbers 1 to 100 in a similar fashion. Do not manually write the sequence of numbers. Instead, enter USE: math.ranges in the Listener, and use the [1,b] word to produce the sequence.
USE: math.ranges
1 100 [1,b] 0 [ + ] reduce

! QUESTION 7
! The map word takes a sequence and a quotation, and returns a sequence of results of applying the quotation to each value. Using map and the words that you have learned so far, write a line of code that returns the squares of the numbers 1 to 10.
1 10 [1,b] [ sq ] map