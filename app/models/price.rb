class Price < ActiveRecord::Base
  attr_accessor :raw_value
  belongs_to :currency
  before_create :set_before_create
  validates :raw_value, presence: true

  protected
    def set_before_create
      if self.currency.blank?
        self.in_local = self.raw_value
      else
        self.rate_of_exchange = self.currency.rate_of_exchange
        self.in_foreign = self.raw_value
        self.in_local = (self.in_foreign / self.rate_of_exchange).round
      end
    end
end