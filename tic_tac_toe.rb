require_relative 'colors'

module Validate
    #Determine whether a position is taken or not
    def is_position_taken?(board, index, token)
        if (board[index] == token[0] || board[index] == token[1])
            true        
        else
            false
        end
    end

    #validate the user’s input index is between 0 and 8 and position in not taken
    def is_move_valid?(board, index, token)
        if (index.between?(0,8) && !is_position_taken?(board, index, token))
            true
        end
    end

    #Check if the board is full
    def is_board_full?(board, token)
        board.all? {|slots| slots == token[0] || slots == token[1]}
    end

    #clear screen
    def clear
        print "\e[2J\e[f"
    end
end

class Game
    include Validate
    
    @@board = [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ']
    WIN_COMBINATIONS = [ [0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [6,4,2] ]
    X =  "X".send(:green).send(:bold)
    O = "O".send(:red).send(:bold)

    def initialize
        @token = [ X, O ]
        @winning_token = ""
        load_game()
    end

    #Game setup
    def load_game
        self.clear
        print "--------------Welcome to Tic Tac Toe--------------\n\n".send(:yellow).send(:bold)
        sleep 1
        puts "Player 1 = " + X
        puts "Player 2 = " + O
        print "\nThe board consist of numbers 1 to 9 representing the location \n"
        puts "          where a player's token will be placed\n\n"

        puts "                     1 | 2 | 3 ".send(:bold).send(:yellow)
        puts "                    ____________".send(:bold).send(:yellow)
        puts "                     4 | 5 | 6 ".send(:bold).send(:yellow)
        puts "                    ____________".send(:bold).send(:yellow)
        puts "                     7 | 8 | 9 ".send(:bold).send(:yellow)
        print "\n\n"
        get_input()
    end

    protected

    #Play game
    def get_input()
        puts "\nMake a move: Enter a number between 1-9"
        input = gets.strip
        index = input.to_i - 1

        if self.is_move_valid?(@@board, index, @token)
            self.clear
            make_a_move(@@board, index, player_turn(@@board, @token))
            display_board(@@board)
            continue?(@@board)
        else
            puts "--------------Invalid move!!!--------------".send(:red).send(:bold)
            get_input()
        end
    end

    #Display the board to show a 3x3 board
    def display_board(board)
        print "                 ---Tic Tac Toe--- \n\n".send(:yellow).send(:bold)
        print "             -------------------------\n\n".send(:yellow).send(:bold)
        puts "                     #{board[0]} | #{board[1]} | #{board[2]} "
        puts "                    ___________"
        puts "                     #{board[3]} | #{board[4]} | #{board[5]} "
        puts "                    ___________"
        puts "                     #{board[6]} | #{board[7]} | #{board[8]} "
        print "\n             -------------------------\n".send(:yellow).send(:bold)
    end  

    #Make a move by validating player then placing the player’s token into chosen square
    def make_a_move(board, index, player)
        board[index] = player
    end

    #Keeping track of player turns
    def player_turn(board, token)
        count = 0

        board.each do |slot|
            if slot == token[0] || slot == token[1]
                count += 1
            end
        end

        count % 2 == 0 ? token[0] : token[1]
    end

    #Determine if winning conditons are met or continue
    def continue?(board)
        if any_win?(@token)
            sleep 1
            puts "\n----------------Congratulations!!!--------------".send(:green).send(:bold)
            puts "                      Player #{@winning_token}"
            puts "                     YOU WIN!!!\n".send(:yellow).send(:bold)
            play_again?()
        elsif self.is_board_full?(board, @token)
            sleep 1
            puts "\n--------------------It's a tie!-----------------".send(:red).send(:bold)
            puts "                    Game Over!!!\n".send(:yellow).send(:bold)
            play_again?()
        else
            get_input()
        end
    end

    #Play game again after previous game is over
    def play_again?()
        sleep 2
        puts "\nDo you wish to play again?: Y/N"
        input = gets.chomp.upcase

        if input == "Y"
            clear_board()
            sleep 1
            self.clear
            display_board(@@board)
            get_input()
        else
            sleep 1
            self.clear
            puts "\n\n\n                 ---GOODBYE!!!---\n\n\n".send(:yellow).send(:bold)
        end
    end

    #Check for win combinations on board
    def any_win?(token)
        set = Array.new
        length = WIN_COMBINATIONS.length
        i = 0

        length.times do
            set[0] = @@board[WIN_COMBINATIONS[i][0]]
            set[1] = @@board[WIN_COMBINATIONS[i][1]]
            set[2] = @@board[WIN_COMBINATIONS[i][2]]
            tokens = [ [token[0], token[0], token[0]], [token[1], token[1], token[1]]]

            if set == tokens[0] || set == tokens[1]
                @winning_token = set[0]
                return true
            end
            i += 1
        end
        
        return false
    end

    #Clear board
    def clear_board()
        @@board = [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ']
        @winning_token = ""
    end
end

tic_tac_toe = Game.new()