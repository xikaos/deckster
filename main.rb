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
  @cards =[]
end


setup "card2.txt"

hydra = Typhoeus::Hydra.hydra

#careful!
#@cards = [@cards.first,@cards[3], @cards[6], @cards.last]
@shop_total = []
#careful

@cards_txt.each do |card_name|
  request = Typhoeus::Request.new(Helpers.pre_flight(card_name), followlocation: true)
  request.on_complete do |response|
    puts "Parse #{card_name}"
    page = Nokogiri::HTML(response.body)
    shops = page.css(".banner-loja a img").map{|banner| banner.attr("title") }
    prices = page.css("#cotacao-1 > tbody > tr > td > p.lj.b")

    shops.each_with_index do |shop_name, index|
      if prices[index].element_children.empty?
        card_price = prices[index].inner_text.strip
      else
        card_price = prices[index].children[4].inner_text.strip
      end
      card = Card.new(card_name, card_price)
      if existing_shop = @shops.find{|shop| shop.name == shop_name }
        next if existing_shop.cards.find{|c| c.name == card.name }
        shop = existing_shop
        shop.add(card)
      else
        shop = Shop.new(shop_name)
        shop.add(card)
        @shops << shop
      end
    end
  end
  hydra.queue(request)
end
hydra.run

@shops.each do |shop|
  @shop_total << shop_total = {
    name: shop.name,
    cards: shop.cards.length,
    missing: @cards_txt - (@shops.find{|s| s.name == shop.name}.cards.map{|c| c.name}),
      price: shop.cards.inject(0){|price, card| price + card.real_price }
  }
end

binding.pry

puts "I #{"<3".red} YOU!"

#@shop_total.sort{|a,b| b[:cards] <=> a[:cards] }
# shop.cards.sort{|a,b| b.real_price <=> a.real_price}.select{|c| c.real_price >= 10}

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
