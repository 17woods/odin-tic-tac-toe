require 'set'

class Board
  attr_reader :board

  def initialize
    white_space = "\s\s\s\s\s\s\s\s\s\s\s\s\s\s\s\s\s\s\s\s\s\s\s\s\s\s\s\s\s\s\s\s"
    line_row = "#{white_space}---+---+---\n"
    @board = "#{white_space} 1 | 2 | 3 \n" + line_row +
    "#{white_space} 4 | 5 | 6 \n" + line_row +
    "#{white_space} 7 | 8 | 9 \n"
  end

  public

  def change(spot, turn)
    @board.sub!(spot, turn)
  end
end

class Main
  attr_reader :board
  attr_reader :turn

  def initialize
    @board = Board.new
    @turn = "X"
    @winner = false
    choice = false
    @taken_x = Set.new
    @taken_o = Set.new
  end

  public

  def play
    until @winner
      puts "Player #{@turn}, it's your turn!"

      puts @board.board

      choice = gets.chomp

      if @taken_x.include?(choice)
        puts "Uh oh! That spot is already taken!"
        next
      end

      @board.change(choice, @turn)

      if @turn == "X"
        @turn = "O"
        @taken_x.add(Integer(choice))
      else
        @turn = "X"
        @taken_o.add(Integer(choice))
      end
      check_win
    end
  end

  def check_win
    win_conditions = [Set[1, 2, 3], Set[4, 5, 6], Set[7, 8, 9], Set[1, 4, 7], Set[2, 5, 8],
    Set[3, 6, 9], Set[1, 5, 9], Set[3, 5, 7]]

    for condition in win_conditions
      #puts condition, condition.subset?(@taken_x), condition.subset?(@taken_o), @taken_o, @taken_x
      if condition.subset?(@taken_x)
        @winner = "X"
      elsif condition.subset?(@taken_o)
        @winner = "O"
      end
    end
    
    unless @winner == false
      end_game
    end
  end

  def end_game
    puts "Congradulations player #{@turn}, you win!"
    exit
  end
end

game = Main.new
game.play