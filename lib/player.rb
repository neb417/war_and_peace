class Player
  attr_reader :name, :deck, :has_lost

  def initialize(name, deck)
    @name = name
    @deck = deck
    @has_lost = false
  end

  def has_lost?
    @has_lost = true if deck.cards.empty?

    @has_lost
  end

  def rank_of_card_at(index)
    deck.rank_of_cards(index)
  end
end
