require "./lib/helpers"
class Card
  attr_accessor :name, :price
  def initialize(name, price)
    self.name = name;
    self.price = price
  end

  def parameterize
    return self.name.gsub(' ', '+')
  end

  def real_price
    if @real_price.nil?
     @real_price = BigDecimal.new(self.price.match(/\d+,\d+/).to_s.gsub(",","."))
   else
     @real_price
   end
  end
end
