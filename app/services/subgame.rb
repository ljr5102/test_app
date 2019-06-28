class Subgame
  WINNER_COMBOS = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    [0, 4, 8],
    [2, 4, 6],
  ].freeze

  attr_reader :subgame

  def initialize(subgame)
    @subgame = subgame
  end

  def complete?
    !!(winner || full?)
  end

  def full?
    subgame.none?(&:empty?)
  end

  def winner
    WINNER_COMBOS.each do |start_idx, mid_idx, fin_idx|
      start = subgame[start_idx]
      mid = subgame[mid_idx]
      fin = subgame[fin_idx]
      if [start, mid, fin].all? { |el| el == 'X' || el == 'O' }
        return start
      end
    end
    nil
  end
end
