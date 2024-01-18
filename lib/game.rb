require 'pry'
class Game
  attr_reader :player1, :player2, :turn
  attr_accessor :turn_count

  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
    @turn_count = 0
    # @turn = Turn.new(player1, player2)
  end

  def start

    puts "
     _________      _________
    |         |    |         |
    |   10    |    |   Q     |
    |    ♥    |    |    ♠    |
    |         |    |         |
    |_________|    |_________|
         /\             /\
        /  \           /  \
       |    |    vs   |    |
        \  /           \  /
         \/             \/"

    puts "Welcome to War! (or Peace) This game will be played with 52 cards."
    puts " Enter 'p' to play. Enter 'q' to quit. \n"

    start_response = gets.downcase.chomp
    if start_response == "p"
      play
    elsif start_response == "q"
      puts "\n Thanks for playing \n"
    else
      start
    end
  end

  def play
    until game_over
      @turn_count += 1

      [@player1, @player2].each do |player|
        player.deck.cards.shuffle
      end

      turn = create_new_turn

      turn_type_return(turn)

      evaluate_winner(player1, player2)
    end
  end

  private

  def create_new_turn
    Turn.new(player1, player2)
  end

  def game_over
    player1.has_lost? || player2.has_lost? || @turn_count >= 1_000_000
  end

  def evaluate_winner(player1, player2)
    if player1.has_lost?
      puts "*~*~*~* #{player2.name} has won the game! *~*~*~*"
    elsif player2.has_lost?
      puts "*~*~*~* #{player1.name} has won the game! *~*~*~*"
    elsif turn_count == 1_000_000
      puts '---- DRAW ----'
    end
  end

  def turn_type_return(turn)
    winner = turn.winner
    case turn.type
    when :basic
      puts "Turn #{@turn_count}: #{turn.winner.name} won 2 cards"
      turn.pile_cards
      turn.award_spoils(winner)
    when :war
      puts "Turn #{@turn_count}: WAR - #{turn.winner.name} won 6 cards"
      turn.pile_cards
      turn.award_spoils(winner)
    else
      puts "Turn #{@turn_count}: *mutually assured destruction* 6 cards removed from play"
      turn.pile_cards
    end
  end
end
