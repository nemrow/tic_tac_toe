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

  def begin
    intro
    until conclusion = game_over do
      print_board
      whose_turn == 2 ? bot_move : user_move
    end
    finish_game(conclusion)
  end

  def inspect_line_for_win(line)
    ['X','O'].each do |player|
      return {:conclusion => 'win', :player => player} if line.uniq == [player.to_s]
    end
    false
  end

  def game_over
    winner = check_for_winner
    return winner if winner
    draw = check_for_draw
    return draw if draw
    false
  end

  def check_for_draw
    if !@board.map{ |cell, value| value[:val] }.include?(' ')
      return {:conclusion => 'draw'}
    end
    false
  end

  def check_for_winner
    possible_wins.each_with_index do |line, index|
      streak = line.map { |cell| @board[cell][:val] }
      winning_player = inspect_line_for_win(streak)
      return winning_player if winning_player
    end
    false
  end

  def finish_game(conclusion)
    print_board
    if conclusion[:conclusion] == 'draw'
      print_to_board("It's a draw!")
    else
      print_to_board((conclusion[:player] == 'X' ? "You are the winner!" : "I am the winner!" ))
    end
  end
end

game = TicTacToe.new
game.begin