require 'pgn'

load 'opening.rb'
load 'search_tree.rb'

class ECO

  attr_accessor :moves, :game

  def initialize
    @game = PGN.parse(File.read("./pgn_files/3821.pgn")).first
    @moves = @game.moves
    @tree = SearchTree.new

    @tree.load_openings
  end

  def get_move(move_num, player)
    move = move_num - 1
    player == "white" ? @game.moves[move * 2] : @game.moves[(move * 2) + 1]
  end

  def get_eco_code
    # return @eco_tree.search("b4")
    # return @eco_tree.search(["d4", "d5", "Nf3", "Nf6", "r3"])
    # return @eco_tree.search(["d4", "d5", "c4", "Bxf5"])
    return @tree.get @moves
  end

  def to_s
    @tree.to_s
  end

  private

end

eco_game = ECO.new
# puts eco_game.to_s
if eco_game.get_eco_code.nil?
  puts "No opening found"
else
  puts eco_game.get_eco_code.name
  puts eco_game.get_eco_code.eco_code
end