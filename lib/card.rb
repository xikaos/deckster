class Card
  attr_accessor :name, :price

  def initialize name
    self.name = name;
  end

  def parameterize
    return self.name.gsub(' ', '+')
  end
end
