require './lib/card'
require './lib/deck'
require './lib/game'
require './lib/player'
require './lib/turn'
require 'pry'

card_types = %i[clubs diamonds hearts spades]

cards = []

card_types.each do |card_type|
  cards << Card.new(card_type, '2', 2)
  cards << Card.new(card_type, '3', 3)
  cards << Card.new(card_type, '4', 4)
  cards << Card.new(card_type, '5', 5)
  cards << Card.new(card_type, '6', 6)
  cards << Card.new(card_type, '7', 7)
  cards << Card.new(card_type, '8', 8)
  cards << Card.new(card_type, '9', 9)
  cards << Card.new(card_type, '10', 10)
  cards << Card.new(card_type, 'Jack', 11)
  cards << Card.new(card_type, 'Queen', 12)
  cards << Card.new(card_type, 'King', 13)
  cards << Card.new(card_type, 'Ace', 14)
end
shuffled_cards = cards.shuffle.each_slice(26).to_a

deck_1 = Deck.new(shuffled_cards[0])
deck_2 = Deck.new(shuffled_cards[1])

player_1 = Player.new('Megan', deck_1)
player_2 = Player.new('Aurora', deck_2)

Game.new(player_1, player_2).start