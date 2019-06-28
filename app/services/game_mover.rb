class GameMover
  attr_reader :error

  def initialize(game:, subgame:, cell:)
    @game = game
    @subgame = subgame
    @cell = cell
    @error = nil
  end

  def execute!
    return self unless valid_parameters?
    return self unless game_valid?
    return self unless subgame_valid?
    return self unless cell_available?

    update_board!
    self
  end

  def update_board!
    board = @game.board
    board[@subgame][@cell] = @game.turn
    turn = @game.turn == 'X' ? 'O' : 'X'
    @game.update!(board: board, turn: turn)
    # @game.update!(board: board, turn: turn, valid_subgames: valid_subgames)
    # noticed my mistake too late!!! should be saving valid_subgames
    # currently my valid subgames I send back are just unfinished subgames
    # would swap out that method to instead just send back this attribute
  end

  def valid_subgames
    if @game.subgame_complete(@game.board[@cell])
      return @game.valid_subgames
    else
      return [@cell]
    end
  end


  def valid_parameters?
    return true if @game && [@subgame, @cell].all? { |idx| idx.between?(0, 8) }
    @error = 'Invalid parameters'
    false
  end

  def game_valid?
    return true unless @game.winner.present?
    @error = 'This game is already over'
    false
  end

  def subgame_valid?
    return true unless @game.subgame_complete?(@game.board[@subgame])
    @error = 'Subgame selected is already complete'
    false
  end

  def cell_available?
    return true unless @game.board[@subgame][@cell].present?
    @error = "Cell already taken"
    false
  end
end
