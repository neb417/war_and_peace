require 'pry'
class Turn
  attr_reader :player1, :player2, :spoils_of_war

  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
    @players = [player1, player2]
    @spoils_of_war = []
  end

  def type
    if basic_play?
      :basic
    elsif war_play?
      :war
    end
  end

  def winner
    if basic_play?
      @players.max_by { |player| player.rank_of_card_at(0) }
    else
      @players.max_by { |player| player.rank_of_card_at(2) }
    end
  end

  def pile_cards
    if basic_play?
      add_cards_to_spoils(player1, player2)
    else
      3.times do
        add_cards_to_spoils(player1, player2)
      end
    end
  end

  def award_spoils(winner)
    winner.deck.cards << @spoils_of_war
    winner.deck.cards.flatten!
  end

  def basic_play?
    player1.rank_of_card_at(0) != player2.rank_of_card_at(0)
  end

  def war_play?
    player1.rank_of_card_at(0) == player2.rank_of_card_at(0)
  end

  def add_cards_to_spoils(player1, player2)
    @spoils_of_war << player1.deck.remove_card << player2.deck.remove_card
  end
end
