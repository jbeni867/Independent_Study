# QUESTION 1
# Express some geometry objects using tuples: a two-dimensional point, a line, a circle, a polygon, and a triangle.
point = {:point, 3, 4}
line = {:line, {0, 0}, {5, 5}}
circle = {:circle, {0, 0}, 10}
polygon = {:polygon, [{0, 0}, {4, 0}, {4, 3}, {0, 3}]}
triangle = {:triangle, {0, 0}, {3, 0}, {0, 4}}

# QUESTION 2
# Write a function to compute the hypotenuse of a right triangle given the length of two sides.
defmodule Geometry do
  def calculate_hypotenuse(a, b) do
    sum_of_squares = (a * a) + (b * b)
    :math.sqrt(sum_of_squares)
  end
end

# QUESTION 3
# Convert a string to an atom.
my_string = "hello"
my_atom = String.to_atom(my_string)

# QUESTION 4
# Test to see if an expression is an atom.
is_atom(:elixir)
is_atom("elixir")

# QUESTION 5
# Given a list of numbers, use recursion to find (1) the size of the list, (2) the maximum value, and (3) the minimum value.
defmodule ListMath do
  def list_size([]) do
    0
  end

  def list_size([_head | tail]) do
    1 + list_size(tail)
  end

  def max_value([head | tail]) do
    find_max(tail, head)
  end

  def find_max([], current_max) do
    current_max
  end

  def find_max([head | tail], current_max) when head > current_max do
    find_max(tail, head)
  end

  def find_max([_head | tail], current_max) do
    find_max(tail, current_max)
  end

  def min_value([head | tail]) do
    find_min(tail, head)
  end

  def find_min([], current_min) do
    current_min
  end

  def find_min([head | tail], current_min) when head < current_min do
    find_min(tail, head)
  end

  def find_min([_head | tail], current_min) do
    find_min(tail, current_min)
  end
end

# QUESTION 6
# Given a list of atoms, build a function called word_count that returns a keyword list, where the keys are atoms from the list and the values are the number of occurrences of that word in the list. For example, word_count([:one, :two, :two]) returns [one: 1, two: 2].
defmodule WordCounter do
  def word_count(list) do
    count_words(list, [])
  end

  def count_words([], current_counts) do
    current_counts
  end

  def count_words([head | tail], current_counts) do
    case Keyword.get(current_counts, head) do
      nil ->
        new_counts = Keyword.put(current_counts, head, 1)
        count_words(tail, new_counts)

      existing_count ->
        new_counts = Keyword.put(current_counts, head, existing_count + 1)
        count_words(tail, new_counts)
    end
  end
end
