module Helpers
  BASE_URL = "http://www.ligamagic.com.br/?view=cards%2Fsearch&card="

  def self.pre_flight card_name
    return BASE_URL + card_name.gsub(" ", "+")
  end

end
