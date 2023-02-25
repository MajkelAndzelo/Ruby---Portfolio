# We initialize the board
board = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]

# We display the board
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "---+---+---"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "---+---+---"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

# We check if any of the players won
def check_win(board, player)
  if (board[0] == player && board[1] == player && board[2] == player) ||
     (board[3] == player && board[4] == player && board[5] == player) ||
     (board[6] == player && board[7] == player && board[8] == player) ||
     (board[0] == player && board[3] == player && board[6] == player) ||
     (board[1] == player && board[4] == player && board[7] == player) ||
     (board[2] == player && board[5] == player && board[8] == player) ||
     (board[0] == player && board[4] == player && board[8] == player) ||
     (board[2] == player && board[4] == player && board[6] == player)
    return true
  else
    return false
  end
end

# We start the game
puts "Welcome to Tic Tac Toe!"

# We collect player names
print "Player 1, please enter your name: "
player1_name = gets.chomp
print "Player 2, please enter your name: "
player2_name = gets.chomp

# We initialize the auxiliary variables
player1_turn = true
game_over = false

# We start the game loop
while !game_over
  # We display the board
  display_board(board)

  # We take the player's movement
  if player1_turn
    print "#{player1_name}, please select a number: "
    player = "X"
  else
    print "#{player2_name}, please select a number: "
    player = "O"
  end
  move = gets.chomp.to_i - 1

  # We check that the movement is correct
  if board[move] != "X" && board[move] != "O"
    board[move] = player
  else
    puts "Invalid move. Please try again."
    next
  end

  # We check if any of the players won
  if check_win(board, player)
    display_board(board)
    if player1_turn
      puts "#{player1_name} wins!"
    else
      puts "#{player2_name} wins!"
    end
    game_over = true
  elsif board.all? {|x| x == "X" || x == "O"}
    display_board(board)
    puts "It's a tie!"
    game_over = true
  else
    player1_turn = !player1_turn
  end
end