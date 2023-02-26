# Initialize an empty array to store tasks
tasks = []

# Define a method to create a task
def create_task(tasks)
    puts "Enter task description:"
    description = gets.chomp
    
    priority = nil
    loop do
      puts "Enter task priority (1-5):"
      priority = gets.chomp.to_i
      break if (1..5).include?(priority)
      puts "Invalid priority. Please enter a number between 1 and 5."
    end
    
    task = { description: description, priority: priority }
    tasks << task
    puts "Task created successfully."
  end

# Define a method to delete a task
def delete_task(tasks)
  puts "Enter task index to delete:"
  index = gets.chomp.to_i - 1
  tasks.delete_at(index)
  puts "Task deleted successfully."
end

# Define a method to sort tasks by priority
def sort_tasks(tasks)
    sorted_tasks = tasks.sort_by { |task| -task[:priority] }
    sorted_tasks.each_with_index do |task, index|
      puts "\n#{index + 1}. #{task[:description]} (priority: #{task[:priority]})"
    end
  end

# Define a method to show all tasks
def show_tasks(tasks)
  tasks.each_with_index do |task, index|
    puts "\n#{index + 1}. #{task[:description]} (priority: #{task[:priority]})"
  end
end

# Define a method to display the menu and get user's choice
def display_menu
  puts "\nTODO List Menu:"
  puts "1. Create a task"
  puts "2. Delete a task"
  puts "3. Sort tasks by priority"
  puts "4. Show all tasks"
  puts "5. Quit"
  puts "\nEnter your choice (1-5):"
  gets.chomp.to_i
end

# Display the menu and get user's choice
choice = display_menu

# Loop until the user chooses to quit
while choice != 5
  case choice
  when 1
    create_task(tasks)
  when 2
    delete_task(tasks)
  when 3
    sort_tasks(tasks)
  when 4
    show_tasks(tasks)
  else
    puts "Invalid choice. Please enter a number between 1 and 5."
  end

  # Display the menu and get user's choice again
  choice = display_menu
end

puts "Goodbye!"