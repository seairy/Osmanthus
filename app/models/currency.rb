class Currency < ActiveRecord::Base
  include Identifierable

  def name_with_code
    "#{name}(#{iso_code})"
  end

  def exchange_to_local foreign_price
    (foreign_price / self.rate_of_exchange).round
  end

  class << self
    def circulation_in destinations
      destinations.map do |destination|
        destination.country.currencies.to_a
      end.flatten.uniq{|currency| currency.id}
    end
  end
end