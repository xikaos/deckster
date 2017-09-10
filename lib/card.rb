require "./lib/helpers"
class Card
  attr_accessor :name, :price

  def initialize name
    self.name = name;
  end

  def parameterize
    return self.name.gsub(' ', '+')
  end

  def pre_flight
    return Helpers::BASE_URL + parameterize
  end
end
