module Validate
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

    #Check if the board is full
    def is_board_full?(board)
        board.all? {|slots| slots == "X" || slots == "O"}
    end
end

class Game
    include Validate
    #Define the variable board
    @@board = [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ']
    #Define win combinations
    WIN_COMBINATIONS = [ [0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [6,4,2] ]
    #Winning token
    @@winning_token = ""

    #Play game
    def play_game()
        puts "\nMake a move: Enter a number between 1-9"
        input = gets.strip
        index = input.to_i - 1

        if self.is_move_valid?(@@board, index)
            self.make_a_move(@@board, index, self.player_turn(@@board))
            self.display_board(@@board)
            self.continue?(@@board)
        else
            puts "\nInvalid move!!!"
            play_game()
        end
    end

    protected

    #Display the board to show a 3x3 board
    def display_board(board)

        line = "___________"

        puts " #{board[0]} | #{board[1]} | #{board[2]} "
        puts line
        puts " #{board[3]} | #{board[4]} | #{board[5]} "
        puts line
        puts " #{board[6]} | #{board[7]} | #{board[8]} "
        
    end

    #Make a move by validating player then placing the player’s token into chosen square
    def make_a_move(board, index, player)
        board[index] = player
    end

    #Keeping track of player turns
    def player_turn(board)
        count = 0
        board.each do |box|
            if box == "X" || box == "O"
                count += 1
            end
        end

        count % 2 == 0 ? "X": "O"
    end

    #Determine if winning conditons are met or continue
    def continue?(board)
        if any_win?()
            puts "\nCongratulations! player #{@@winning_token}.\nYOU WIN!!!"
            play_again?()
        elsif self.is_board_full?(board)
            puts "\nIt's a tie!"
            puts "Game Over!!!"
            play_again?()
        else
            self.play_game()
        end
    end

    #Play game again after previous game is over
    def play_again?()
        puts "\nDo you wish to play again?: Y/N"
        input = gets.chomp.upcase

        if input == "Y"
            clear()
            self.play_game()
        else
            puts "\nGOODBYE!!!"
        end
    end

    #Check for win combinations on board
    def any_win?()
        @@set = []
        @@length = WIN_COMBINATIONS.length
        @@i = 0

        @@length.times do
            @@set[0] = @@board[WIN_COMBINATIONS[@@i][0]]
            @@set[1] = @@board[WIN_COMBINATIONS[@@i][1]]
            @@set[2] = @@board[WIN_COMBINATIONS[@@i][2]]
            @@tokens = [ ["X", "X", "X"], ["O", "O", "O"]]

            if @@set == @@tokens[0] || @@set == @@tokens[1]
                @@winning_token = @@set[0]
                return true
            end
            @@i += 1
        end
        
        return false
    end

    #Clear board
    def clear()
        @@board = [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ']
        @@winning_token = ""
    end
end

tic_tac_toe = Game.new()
tic_tac_toe.play_game()