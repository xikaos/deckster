class Shop
  attr_accessor :name, :cards

  def initialize name
    @name = name
    @cards = []
  end

  def add card
    self.cards << card unless card.nil?
  end

  def all
    self.cards.map{|card| card.name }
  end

  def self.all
    ObjectSpace.each_object(self).to_a
  end
end
