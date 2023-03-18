def reverse_only_letters(s)
  letters = s.gsub(/[^a-zA-Z]/, '').reverse.chars
  result = []

  s.each_char do |char|
    if char.match?(/[a-zA-Z]/)
      result << letters.shift
    else
      result << char
    end
  end

  result.join
end

input1 = gets.chomp.to_s
example = "ldap@1z1j!-djta#fg3lgj.3la!ks"

output1 = reverse_only_letters(input1)
example_output = reverse_only_letters(example)

puts "Input: '#{input1}', Output: '#{output1}'"

puts "Example input: '#{example}', Example output: '#{example_output}'"