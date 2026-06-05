# PROBLEM 1
# Print the contents of an array of sixteen numbers, four numbers at a time, using just each. Now, do the same with each_slice in Enumerable.
# WITH EACH
numbers = (1..16).to_a

(0...numbers.length).step(4).each {|start_index|
  line = numbers[start_index, 4]
  puts line.join(" ") }

# WITH EACH_SLICE
numbers.each_slice(4).each {|line| puts line.join(" ") }

# PROBLEM 2
# The Tree class was interesting, but it did not allow you to specify a new tree with a clean user interface.
# Let the initializer accept a nested structure of hashes.
# You should be able to specify a tree like this: {’grandpa’ => { ’dad’ => {’child 1’ => {}, ’child 2’ => {} }, ’uncle’ => {’child 3’ => {}, ’child 4’ => {} } } }.
class Tree
  attr_accessor :children, :node_name
  
  def initialize(root_hash)
    @node_name = root_hash.keys.first
    children_hash = root_hash[@node_name] || {}
    @children = children_hash.map { |key, value| Tree.new(key => value) }
  end
  
  def visit_all(&block)
    visit &block
    children.each {|c| c.visit_all &block}
  end
  
  def visit(&block)
    block.call self
  end
end

tree_to_be_specified = Tree.new({'grandpa' => { 'dad' => {'child 1' => {}, 'child 2' => {} }, 'uncle' => {'child 3' => {}, 'child 4' => {} } } })
# ruby_tree = Tree.new( "Ruby", 
#   [Tree.new("Reia"), 
#    Tree.new("MacRuby")] )

puts "Visiting a node"
tree_to_be_specified.visit {|node| puts node.node_name}
puts

puts "visiting entire tree"
tree_to_be_specified.visit_all {|node| puts node.node_name}

# PROBLEM 3
# Write a simple grep that will print the lines of a file having any occurrences of a phrase anywhere in that line.
# You will need to do a simple regular expression match and read lines from a file.
# (This is surprisingly simple in Ruby.) If you want, include line numbers. 

File.open('sample_text_Ruby_d2_q3.txt', 'r') do |file|
  file.each_line do |line|
    puts "#{file.lineno()} #{line}" if line =~ /an|on|er/
  end
end