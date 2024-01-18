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
    elsif mutually_assured_destruction_play?
      :mutually_assured_destruction
    end
  end

  def winner
    case type
    when :basic
      @players.max_by { |player| player.rank_of_card_at(0) }
    when :war
      @players.max_by { |player| player.rank_of_card_at(2) }
    else
      'No Winner'
    end
  end

  def pile_cards
    case type
    when :basic
      add_cards_to_spoils(player1, player2)
    else
      3.times do
        add_cards_to_spoils(player1, player2)
      end
    end
  end

  def award_spoils(winner)
    return unless winner.is_a?(Player)

    winner.deck.cards << @spoils_of_war
    winner.deck.cards.flatten!
  end

  def basic_play?
    player1.rank_of_card_at(0) != player2.rank_of_card_at(0)
  end

  def war_play?
    player1.rank_of_card_at(0) == player2.rank_of_card_at(0) &&
      player1.rank_of_card_at(2) != player2.rank_of_card_at(2)
  end

  def mutually_assured_destruction_play?
    player1.rank_of_card_at(0) == player2.rank_of_card_at(0) &&
      player1.rank_of_card_at(2) == player2.rank_of_card_at(2)
  end

  def add_cards_to_spoils(player1, player2)
    @spoils_of_war << player1.deck.remove_card << player2.deck.remove_card
  end
end
