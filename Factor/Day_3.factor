! QUESTION 1
! Define a constructor for cart-item that accepts a price and returns a cart-item with a default name and quantity.
TUPLE: cart-item name price quantity ;

: <cart-item-default> ( price -- cart-item )
    "Generic Item"
    swap
    1
    cart-item boa ;

! QUESTION 2
! Write a word that discounts the price of a cart-item by a percentage that is given as a parameter.
: discount-item ( cart-item percentage -- updated-cart-item )
    swap
    dup price>>
    rot
    
    1 swap -
    *
    
    swap
    >>price ;