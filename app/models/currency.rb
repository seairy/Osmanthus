class Currency < ActiveRecord::Base
  include Identifierable

  def name_with_code
    "#{name}(#{iso_code})"
  end

  class << self
    def circulation_in destinations
      destinations.map do |destination|
        destination.country.currencies.to_a
      end.flatten.uniq{|currency| currency.id}
    end
  end
end