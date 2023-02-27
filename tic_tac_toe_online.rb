require 'socket'

class TicTacToe
  WINNING_COMBINATIONS = [
    [0, 1, 2], [3, 4, 5], [6, 7, 8], # wiersze
    [0, 3, 6], [1, 4, 7], [2, 5, 8], # kolumny
    [0, 4, 8], [2, 4, 6] # przekątne
  ]

  def initialize
    @board = Array.new(9, ' ')
    @current_player = 'X'
  end

  def run
    server = TCPServer.new('localhost', 2000)
    puts 'Server started'

    clients = []
    2.times do
      client = server.accept
      clients << client
      puts "Client #{clients.length} connected"
      client.print "You are Player #{clients.length}\n\r"
    end

    send_board_to_clients(clients)

    loop do
      client_index = @current_player == 'X' ? 0 : 1
      client = clients[client_index]
      other_client = clients[1 - client_index]

      move = get_move(client)

      if valid_move?(move)
        @board[move] = @current_player
        send_board_to_clients(clients)

        if winner?(@current_player)
          client.print "Congratulations! You win!"
          other_client.print "Player #{@current_player} wins!"
          break
        elsif tie?
          clients.each { |i| client.puts 'Tie game.' }
          break
        end

        @current_player = @current_player == 'X' ? 'O' : 'X'
      else
        client.print "Invalid move. Try again.\n\r"
      end
    end

    clients.each(&:close)
    server.close
    puts 'Server stopped'
  rescue StandardError => e
    puts "Error: #{e.message}"
    clients.each(&:close)
    server.close
  end

  private

  def get_move(client)
    client.print "Make your move (1-9): "
    move = client.gets.chomp.to_i - 1
    #obsługa typowych błędów
    raise ArgumentError, 'Invalid move. Enter a number between 0 and 8.' unless (0..8).include?(move)
    raise ArgumentError, 'Invalid move. That position is already taken.' unless @board[move] == ' ' || @board[move] == 'X' || @board[move] == 'O'

    move
  end

  def valid_move?(move)
    (0..8).include?(move) && @board[move] == ' '
  end

  def winner?(player)
    WINNING_COMBINATIONS.any? { |combo| combo.all? { |pos| @board[pos] == player } }
  end

  def tie?
    @board.all? { |pos| pos != ' ' }
  end

  def send_board_to_clients(clients)
    board_string = board_to_string
    clients.each do |client|
      client.puts board_string
    end
  end
  

  def board_to_string 
    " #{@board[0]} | #{@board[1]} | #{@board[2]}\n\r" +
    "---+---+---\n\r" +
    " #{@board[3]} | #{@board[4]} | #{@board[5]}\n\r" +
    "---+---+---\n\r" +
    " #{@board[6]} | #{@board[7]} | #{@board[8]}\n\r" +
    "\n\r"
  end
  


  game = TicTacToe.new
  game.run
end

#by zagrać odpal ruby tic_tac_toe_online.rb
#odpal dwa terminale i wpisz telnet localhost 2000
#potrzebny zainstalowany telnet oraz Control Panel>Programs>Turn Windows features on or off. Zaznaczyć "Telnet Client" i zapisać