# Request to add comma separated lists
puts "Enter a list of numbers separated by commas:"
input = gets.chomp

# Convert input to a list of numbers
numbers = input.split(",").map(&:to_i)

# Sorting the list
sorted_numbers = numbers.sort

# View of a sorted list
puts "Posortowana lista: #{sorted_numbers.join(", ")}"
