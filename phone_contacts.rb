# Define a Contact class to hold personal data
class Contact
    attr_accessor :first_name, :last_name, :address, :phone_number
  
    def initialize(first_name, last_name, address, phone_number)
      @first_name = first_name
      @last_name = last_name
      @address = address
      @phone_number = phone_number
    end
  
    def to_s
      "#{@first_name} #{@last_name}\n#{@address}\n#{@phone_number}"
    end
  end
  
  # Define a DataManagement class to manage contacts
  class DataManagement
    def initialize
      @contacts = []
    end
  
    def add_person
      puts "\nEnter first name:"
      first_name = gets.chomp
      puts "Enter last name:"
      last_name = gets.chomp
      puts "Enter address:"
      address = gets.chomp
      puts "Enter phone number:"
      phone_number = gets.chomp
      @contacts << Contact.new(first_name, last_name, address, phone_number)
    end
  
    def delete_person
      puts "\nEnter the number of the contact you want to delete:"
      display_people
      index = gets.chomp.to_i - 1
      @contacts.delete_at(index)
    end
  
    def sort_people_by
      puts "\nSort contacts by:\n1. First name\n2. Last name\n3. Address\n4. Phone number"
      choice = gets.chomp.to_i
      case choice
      when 1
        @contacts.sort_by! { |contact| contact.first_name.downcase }
      when 2
        @contacts.sort_by! { |contact| contact.last_name.downcase }
      when 3
        @contacts.sort_by! { |contact| contact.address.downcase }
      when 4
        @contacts.sort_by! { |contact| contact.phone_number.downcase }
      else
        puts "Invalid choice"
      end
      display_people
    end
  
    def display_people
      if @contacts.empty?
        puts "No contacts to display"
      else
        @contacts.each_with_index { |contact, index| puts "===========\n#{index+1}. #{contact}\n===========" }
      end
    end
  
    def run
      loop do
        puts "\nSelect an option:\n1. Add person\n2. Delete person\n3. Sort people by\n4. Display people\n5. Quit"
        choice = gets.chomp.to_i
        case choice
        when 1
          add_person
        when 2
          delete_person
        when 3
          sort_people_by
        when 4
          display_people
        when 5
          break
        else
          puts "Invalid choice"
        end
      end
    end
  end
  
  # Run the program
  data_management = DataManagement.new
  data_management.run
  