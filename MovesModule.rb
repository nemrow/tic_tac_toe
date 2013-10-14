module MovesModule
  def user_move
    input_valid = false
    print_to_board("Please enter your move (You are X's)")
    until input_valid do
      cell = gets.chomp
      input_valid = validate_user_input(cell)
      print_to_board("That is not a valid cell") if !input_valid
    end
    @board[cell][:val] = 'X'
  end

  def validate_user_input(cell)
    return false if !@board.has_key?(cell) || @board[cell][:val] != ' '
    true
  end

  def bot_move
    print_to_board("Here I go")
    sleep(1)
    return true if check_for_win_move || check_for_block_move
    attack_move
  end

  def check_for_win_move
    possible_wins.each_with_index do |line, index|
      full_line = line.map { |cell| @board[cell][:val] }
      if full_line.count("O") == 2 && full_line.count("X") == 0
        make_bots_kill_move(index)
        return true
      end
    end
    false
  end

  def make_bots_kill_move(index)
    possible_wins[index].each do |cell|
      @board[cell][:val] = 'O' if @board[cell][:val] == ' '
    end
  end

  def check_for_block_move
    possible_wins.each_with_index do |line, index|
      row = line.map { |cell| @board[cell][:val] }
      if row.count("X") == 2 && row.count("O") == 0
        make_bots_block_move(index)
        return true
      end
    end
    false
  end

  def make_bots_block_move(index)
    possible_wins[index].each do |cell|
      @board[cell][:val] = 'O' if @board[cell][:val] == ' '
    end
  end

  def make_bots_attack_move(index)
    spot = possible_wins[index].detect {  |cell| @board[cell][:val] == ' ' }
    @board[spot][:val] = "O"
  end

  def attack_move
    [[0,1],[0,0],[1,1]].each do |num_set|
      possible_wins.each_with_index do |line, index|
        row = line.map { |cell| @board[cell][:val] }
        if row.count("X") == num_set[0] && row.count("O") == num_set[1]
          make_bots_attack_move(index)
          return false
        end
      end
    end
  end
end