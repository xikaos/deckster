class Shop
  attr_accessor :name, :cards

  def initialize name
    self.name = name
    self.cards = []
  end

  def add card
    self.cards << card unless card.nil?
  end

  def all
    self.cards.map{|card| card.name }
  end
end
