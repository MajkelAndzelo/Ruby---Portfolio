# We ask the user for the length of the base of the triangle
print "Enter the length of the base of the triangle: "
base = gets.chomp.to_f

# We ask the user for the height of the triangle
print "Enter the height of the triangle: "
height = gets.chomp.to_f

# We calculate the area of the triangle
area = 0.5 * base * height

# We display the result on the screen
puts "The area of the triangle with base #{base} and height #{height} is #{area}."
