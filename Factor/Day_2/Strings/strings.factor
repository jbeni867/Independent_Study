IN: examples.strings

USING: sequences ;

: palindrome? ( str -- ? )
    dup reverse = ;