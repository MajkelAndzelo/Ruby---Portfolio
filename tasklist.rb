TASKS_FILE = "tasks.txt"

# Define a function to create a task
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

  tasks << {description: description, priority: priority}
  puts "Task created successfully."
end

# Define a function to delete a task
def delete_task(tasks)
  puts "Enter task index to delete:"
  index = gets.chomp.to_i
  if (1..tasks.length).include?(index)
    tasks.delete_at(index - 1)
    puts "Task deleted successfully."
  else
    puts "Invalid index. Please enter a number between 1 and #{tasks.length}."
  end
end

# Define a function to sort tasks by priority
def sort_tasks(tasks)
  sorted_tasks = tasks.sort_by { |task| -task[:priority] }
  puts "Sorted tasks by priority:"
  sorted_tasks.each_with_index do |task, index|
    puts "#{index + 1}. #{task[:description]} (priority: #{task[:priority]})"
  end
end

# Define a function to show all tasks
def show_tasks(tasks)
  puts "All tasks:"
  tasks.each_with_index do |task, index|
    puts "#{index + 1}. #{task[:description]} (priority: #{task[:priority]})"
  end
end

# Define a function to save tasks to a file
def save_tasks(tasks)
  File.open(TASKS_FILE, "w") do |file|
    tasks.each do |task|
      file.puts("#{task[:description]},#{task[:priority]}")
    end
  end
  puts "Tasks saved to #{TASKS_FILE}."
end

# Define a function to load tasks from a file
def load_tasks
  tasks = []
  if File.exists?(TASKS_FILE)
    File.readlines(TASKS_FILE).each do |line|
      description, priority = line.chomp.split(",")
      tasks << {description: description, priority: priority.to_i}
    end
    puts "Tasks loaded from #{TASKS_FILE}."
  else
    puts "#{TASKS_FILE} does not exist. Starting with an empty task list."
  end
  tasks
end

# Load tasks from file or start with an empty list
tasks = load_tasks

# Define a function to display the menu and get user's choice
def display_menu
  puts "\nTODO List Menu:"
  puts "1. Create a task"
  puts "2. Delete a task"
  puts "3. Sort tasks by priority"
  puts "4. Show all tasks"
  puts "5. Save tasks to file"
  puts "6. Load tasks from file"
  puts "7. Quit"
  puts "\nEnter your choice (1-7):"

  choice = gets.chomp.to_i
end

# Main loop
loop do
  choice = display_menu

  case choice
  when 1
    create_task(tasks)
  when 2
    delete_task(tasks)
  when 3
    sort_tasks(tasks)
  when 4
    show_tasks(tasks)
  when 5
    save_tasks(tasks)
  when 6
    tasks = load_tasks
  when 7
    save_tasks(tasks)
  break
else
    puts "Invalid choice. Please enter a number between 1 and 7."
    end
end