require "typhoeus"
require "nokogiri"
require "bigdecimal"
require "./lib/card"
require "./lib/shop"

def setup txt_path
  @cards_txt = File.open(txt_path).map{|card| card.chomp }
  @shops = []
end






# c1 = Card.new "Grasp of Darknes"
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
