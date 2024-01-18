require 'pry'

class Deck
  attr_reader :cards

  def initialize(cards)
    @cards = cards
  end

  def rank_of_cards(index)
    cards[index].rank
  end

  def high_ranking_cards
    cards.select { |card| card.rank >= 11 }
  end

  def percent_high_ranking
    (high_ranking_cards.count.to_f / cards.count).round(4) * 100
  end

  def remove_card
    cards.shift unless cards.empty?
  end

  def add_card(card)
    cards << card
  end
end
