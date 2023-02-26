def calculate_statistics(filename)
    begin
      numbers = File.read(filename).split(",").map(&:to_f)
    rescue Errno::ENOENT
      puts "Error: File not found."
      return nil
    rescue Errno::EACCES
      puts "Error: Permission denied to read file."
      return nil
    end
    
    n = numbers.length
    sum = numbers.sum
    mean = sum / n
    variance = numbers.map { |x| (x - mean)**2 }.sum / n
    std_dev = Math.sqrt(variance)
    max_num = numbers.max
    min_num = numbers.min
    return max_num, min_num, mean, std_dev
  end
  
  print "Enter filename: "
  filename = gets.chomp
  
  stats = calculate_statistics(filename)
  
  if stats != nil
    max_num, min_num, mean, std_dev = stats
    puts "Max number: #{max_num}"
    puts "Min number: #{min_num}"
    puts "Mean: #{mean}"
    puts "Standard deviation: #{std_dev}"
  end
  