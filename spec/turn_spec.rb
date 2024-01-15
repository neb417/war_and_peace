require './lib/card'
require './lib/deck'
require './lib/player'
require './lib/turn'
require 'pry'

RSpec.describe Turn do
  let(:card1) { Card.new(:heart, 'Jack', 11) }
  let(:card2) { Card.new(:heart, '10', 10) }
  let(:card3) { Card.new(:heart, '9', 9) }
  let(:card4) { Card.new(:diamond, 'Jack', 11) }
  let(:card5) { Card.new(:heart, '8', 8) }
  let(:card6) { Card.new(:diamond, 'Queen', 12) }
  let(:card7) { Card.new(:heart, '3', 3) }
  let(:card8) { Card.new(:diamond, '2', 2) }
  let(:deck1) { Deck.new([card1, card2, card5, card8]) }
  let(:deck2) { Deck.new([card3, card4, card6, card7]) }
  let(:player1) { Player.new('Megan', deck1) }
  let(:player2) { Player.new('Aurora', deck2) }
  let(:turn) { Turn.new(player1, player2) }

  context 'is a turn with attributes' do
    it { expect(turn).to be_a Turn }
    it { expect(turn.player1).to eq player1 }
    it { expect(turn.player2).to eq player2 }
    it { expect(turn.spoils_of_war).to eq [] }
  end

  context 'instance methods when turn type is basic' do
    it { expect(turn.type).to eq :basic }
    it { expect(turn.winner).to eq player1 }

    it '#pile_cards should add played cards to spoils_of_war' do
      expect(turn.spoils_of_war).to eq []

      turn.pile_cards

      expect(turn.spoils_of_war).to eq [card1, card3]
    end

    it '#award_spoils should add spoils_of_war to winning player deck' do
      winner = turn.winner
      turn.pile_cards
      turn.spoils_of_war
      turn.award_spoils(winner)

      expect(player1.deck.cards).to match_array [card1, card2, card5, card8, card3]
      expect(player2.deck.cards).to match_array [card4, card6, card7]
    end
  end

  context 'instance methods when turn type is war' do
    let(:deck2) { Deck.new([card4, card3, card6, card7]) }
    let(:turn) { Turn.new(player1, player2) }

    it { expect(turn.type).to eq :war }
    it { expect(turn.winner).to eq player2 }

    it '#pile_cards should add played cards to spoils_of_war' do
      expect(turn.spoils_of_war).to eq []

      turn.pile_cards

      expect(turn.spoils_of_war).to eq [card1, card4, card2, card3, card5, card6]
    end

    it '#award_spoils should add spoils_of_war to winning player deck' do
      winner = turn.winner
      turn.pile_cards
      turn.spoils_of_war
      turn.award_spoils(winner)

      expect(player1.deck.cards).to match_array [card8]
      expect(player2.deck.cards).to match_array [card1, card2, card3, card4, card5, card6, card7]
    end
  end
end
