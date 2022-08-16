require "set"

class Board
  attr_accessor :taken_x
  attr_accessor :taken_o
  attr_reader :board
  attr_reader :taken

  def initialize
    @verticals = "\s\s\s\s\s|\s\s\s\s\s|\s\s\s\s\s\n"
    @horizontals = "-----+-----+-----\n"
    @board = Array.new
    @taken = Array.new(9, ".")
    @taken_x = Set.new
    @taken_o = Set.new

    2.times do
      3.times { @board.push(@verticals.dup) }

      @board.push(@horizontals.dup)
    end

    3.times { @board.push(@verticals.dup) }

    @board
  end

  private

  def refresh
    i = 1
    n = 1

    loop do
      3.times do
        @board[i].sub!(/\s\s.\s\s/, "\s\s#{@taken[n - 1]}\s\s")

        n += 1

        puts n
      end

      i += 4

      if i == 13
        break
      end
    end
  end

  public

  def change(spot)
    @taken[spot - 1] = @turn

    if @turn == "X"
      @turn = "O"

      @taken_x.add(spot)

    else
      @turn = "X"

      @taken_o.add(spot)

    end

    refresh
  end
end

class Main
  attr_reader :board
  attr_reader :turn

  def initialize
    @turn = "X"
    @winner = false
    @board = Board.new
    @taken_x = @board.taken_x
    @taken_o = @board.taken_o
  end

  private

  def check_win
    win_conditions = [[1, 2, 3], [4, 5, 6], [7, 8, 9], [1, 4, 7], [2, 5, 8],
      [3, 6, 9], [1, 5, 9], [3, 5, 7]]
    for condition in win_conditions
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
    "Congrats Player #{@winner}! You Win!"
    exit
  end

  public

  def play
    until @winner
      puts "Player #{@turn}, your turn!"
      @board.change(Integer(gets.chomp))
      puts @board.board
    end
  end
end

game = Main.new
board = game.board.board
game.play