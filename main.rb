require "set"

class Main
  attr_reader :board
  attr_reader :taken
  attr_reader :turn

  def initialize
    @verticals = "     |     |     \n"
    @horizontals = "-----+-----+-----\n"
    @board = Array.new
    @turn = "X"
    @taken = Array.new(9, ".")
    @taken_x = Set.new
    @taken_o = Set.new
    @winner = false

    2.times do
      3.times { @board.push(@verticals.dup) }

      @board.push(@horizontals.dup)
    end

    3.times { @board.push(@verticals.dup) }
  end

  private

  def refresh_board
    i = 1
    n = 1

    loop do
      3.times do
        @board[i].sub!(/\s\s\s\s\s/, "\s\s#{@taken[n - 1]}\s\s")

        n += 1

        puts n
      end

      i += 4

      if i == 13
        break
      end
    end
  end

  def check_win
    win_conditions = [[1, 2, 3], [4, 5, 6], [7, 8, 9], [1, 4, 7], [2, 5, 8],
      [3, 6, 9], [1, 5, 9], [3, 5, 7]]
    for condition in win_conditions
      if condition.subset?(@taken_x)

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

    refresh_board
  end
end

game = Main.new