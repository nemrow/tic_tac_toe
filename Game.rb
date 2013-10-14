require_relative 'MovesModule'
require_relative 'BoardModule'


class TicTacToe

  include MovesModule
  include BoardModule

  def initialize
    @board = init_board
    @turn = choose_starter
  end

  def whose_turn
    @turn = (@turn == 1 ? 2 : 1) 
  end

  def choose_starter
    rand() < 0.5 ? 1 : 2
  end

  def game_over
    possible_wins.each_with_index do |line, index|
      streak = line.map { |cell| @board[cell][:val] }
      winning_player = inspect_line_for_win(streak)
      return winning_player if winning_player
    end
    return check_for_draw if check_for_draw
    false
  end

  def finish_game(conclusion)
    print_board
    if conclusion[:conclusion] == 'draw'
      p "It's a draw!"
    else
      p (conclusion[:player] == 'X' ? "You are the winner!" : "I am the winner!" )
    end
  end

  def begin
    intro
    until conclusion = game_over do
      print_board
      whose_turn == 2 ? bot_move : user_move
    end
    finish_game(conclusion)
  end
end

game = TicTacToe.new
game.begin