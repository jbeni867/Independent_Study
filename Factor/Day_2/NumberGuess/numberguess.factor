IN: examples.numberguess
USING: io math math.parser random formatting ;

: read-guess ( -- n )
    readln string>number ;

: guess-loop ( target -- )
    "Enter your guess: " write flush
    read-guess
    
    dup not [
        drop "Please enter a valid number!" print
        guess-loop
    ] [
        over over = [
            "Winner!" print drop drop
        ] [
            over over < [
                "Lower" print drop guess-loop
            ] [
                "Higher" print drop guess-loop
            ] if
        ] if
    ] if ;

: run-game ( -- )
    "I am thinking of a number between 1 and 100..." print
    100 random 1 +
    guess-loop ;

MAIN: run-game