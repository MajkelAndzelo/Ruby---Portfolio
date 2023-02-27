CONTACTS_FILE = "contacts.txt"
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
  
 
  def save_contacts(contacts)
    File.open(CONTACTS_FILE, "w") do |file|
      contacts.each do |contact|
        file.puts("#{contact.first_name},#{contact.last_name},#{contact.address},#{contact.phone_number}\n")
      end
    end
    puts "Contacts saved to #{CONTACTS_FILE}."
  end
  


  def load_contacts
    @contacts = []
    if File.exist?(CONTACTS_FILE)
      File.readlines(CONTACTS_FILE).each do |line|
        first_name, last_name, address, phone_number = line.chomp.split(",")
        @contacts << Contact.new(first_name, last_name, address, phone_number)
      end
      puts "Contacts loaded from #{CONTACTS_FILE}."
    else
      puts "#{CONTACTS_FILE} does not exist. Starting with an empty contact list."
    end
    @contacts
  end
  
 
  # Define a DataManagement class to manage contacts
  class DataManagement
    def initialize
      @contacts = load_contacts
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
        puts "\nSelect an option:\n1. Add person\n2. Delete person\n3. Sort people by\n4. Display people\n5. Save contacts\n6. Load contacts\n7. Quit"
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
          save_contacts(@contacts)
        when 6
          load_contacts = @contacts
        when 7
          puts "Good bye!"
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
  
