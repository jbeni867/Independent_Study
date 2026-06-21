-- QUESTION 1
-- Write a function called ends_in_3(num) that returns true if the final digit of num is 3, and false otherwise.
function ends_in_3(num)
    local last_digit = num % 10
    if last_digit == 3 then
        return true
    else
        return false
    end
end

-- QUESTION 2
-- Now, write a similar function called is_prime(num) to test if a number is prime (that is, it’s divisible only by itself and 1).
function is_prime(num)
    if num < 2 then
        return false
    end
    
    for i = 2, num - 1 do
        if num % i == 0 then
            return false
        end
    end
    return true
end

-- QUESTION 3
-- Create a program to print the first n prime numbers that end in 3.
function print_primes_ending_in_3(n)
    local count = 0
    local current_num = 1
    
    while count < n do
        if ends_in_3(current_num) and is_prime(current_num) then
            print(current_num)
            count = count + 1
        end
        current_num = current_num + 1
    end
end

-- print_primes_ending_in_3(5)

-- QUESTION 4
-- What if Lua didn’t have a for loop? Using if and while, write a function for_loop(a, b, f) that calls f() on each integer from a to b (inclusive).
function for_loop(a, b, f)
    local current = a
    
    while current <= b do
        f(current)
        current = current + 1
    end
end