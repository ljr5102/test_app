class Game < ApplicationRecord
  def winner
    winner_count = { "X" => 0, "O" => 0 }

    return '' unless finished_subgames.length == 9
    board.each do |subgame|
      winner = subgame_winner(subgame)
      if winner
        winner_count[winner] += 1
      end
    end
    winner_count.max_by { |_char, count| count }.first
  end

  def finished_subgames
    board.select { |subgame| Subgame.new(subgame).complete? }
  end

  def valid_subgames
    board.each_with_index.reject do |subgame, _idx|
      Subgame.new(subgame).complete?
    end.map(&:last)
  end

  def subgame_complete?(subgame)
    Subgame.new(subgame).complete?
  end

  def subgame_winner(subgame)
    Subgame.new(subgame).winner
  end
end
