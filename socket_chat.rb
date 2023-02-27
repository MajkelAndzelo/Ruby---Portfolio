require 'socket'

# Set up the server
server = TCPServer.new('localhost', 3000)
puts "Server started on port 3000"

# Set up an empty hash to hold client names and sockets
clients = {}

# Accept new connections
loop do
  client = server.accept
  puts "New client connected: #{client}"

  # Ask the client for their name
  client.puts "Type your name:\r"
  name = client.gets.chomp

  # Add the client to the hash of clients
  clients[name] = client

  # Listen for messages from the client
  Thread.new do
    begin
      loop do
        message = client.gets.chomp
        sender = name

        # Determine the sender of the message
        clients.each do |n, c|
          if c == client
            sender = n
            break
          end
        end

        # Send the message to all connected clients
        clients.each do |n, c|
          if c == client
            c.puts "You: #{message}\r"
          else
            c.puts "#{sender}: #{message}\r"
          end
        end
        puts "[LOG] #{sender}: #{message}"
      end
    rescue IOError, Errno::EPIPE => e
      # Handle client disconnect
      puts "Client disconnected: #{client}"

      # Remove the client from the hash of clients
      clients.delete(name)

      # Notify remaining clients
      clients.each do |n, c|
        c.puts "#{name} has left the chat.\n\r"
      end
    end
  end
end