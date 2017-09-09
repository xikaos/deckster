require "typhoeus"
require "nokogiri"
require "pry"
require "./lib/card"
require "./lib/shop"

def setup txt_path
  @cards_txt = File.open(txt_path).map{|card| card.chomp }
  @shops = []
end

setup "cards.txt"
binding.pry
puts "I #{"<3".red} YOU!"




# c1 = Card.new "Grasp of Darkness"
# c2 = Card.new "Hearless Summoning"
# c3 = Card.new "Chaos Warp"
#
# shop = Shop.new "Cards of Paradise"
#
# shop.add(c1)
# shop.add(c2)
# shop.add(c3)
#
# puts shop.name
# puts shop.all
