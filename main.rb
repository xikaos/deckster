require "typhoeus"
require "nokogiri"
require "bigdecimal"
require "pry"
require "./lib/card"
require "./lib/shop"

def setup txt_path
  @BASE_URL = "http://www.ligamagic.com.br/?view=cards%2Fsearch&card=the_card"
  @cards_txt = File.open(txt_path).map{|card| card.chomp }
  @shops = []
  @cards = @cards_txt.map{|card_name| Card.new(card_name) }
end


setup "card2.txt"

hydra = Typhoeus::Hydra.hydra

#careful!
#@cards = [@cards.first]
#careful

@cards.each do |card|
  request = Typhoeus::Request.new(card.pre_flight, followlocation: true)
  request.on_complete do |response|
    page = Nokogiri::HTML(response.body)
    shops = page.css(".banner-loja a img").map{|banner| banner.attr("title") }
    prices = page.css("#cotacao-1 > tbody > tr > td > p.lj.b")
    shops.each_with_index do |shop_name, index|
      if prices[index].element_children.empty?
        card.price = prices[index].inner_text.strip
      else
        card.price = prices[index].children[4].inner_text.strip
      end

      unless Shop.all.map{|s| s.name }.include?(shop_name)
        shop = Shop.new(shop_name)
      end

      shop.add(card)
      @shops << Shop.new(shop)
    end
  end
  hydra.queue(request)
end
hydra.run




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
