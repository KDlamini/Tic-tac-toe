#Define the variable board
board = [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ']

#Display the board to show a 3x3 board
def display_board(board)

    line = "___________"

    puts " #{board[0]} | #{board[1]} | #{board[2]} "
    puts line
    puts " #{board[3]} | #{board[4]} | #{board[5]} "
    puts line
    puts " #{board[6]} | #{board[7]} | #{board[8]} "
    
end

#Convert the user input into an integer and index
def user_input_index(input)
    input.to_i - 1
end

#Make a move by validating then placing the player’s token into chosen square
def make_a_move(board, index, player)
    board[index] = player
end

#Determine whether a position is taken or not
def is_position_taken?(board, index)
    if (board[index] == " " || board[index] == ""|| board[index] == nil)
        false        
    else
        true
    end
end

#validate the user’s input index is between 0 and 8 and position in not taken
def is_move_valid?(board, index)
    if (index.between?(0,8) && !is_position_taken?(board, index))
        true
    end
end