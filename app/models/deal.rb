class Deal < ActiveRecord::Base
  include Identifierable, AASM
  attr_accessor :acceptable_price_value, :acceptable_price_currency_id
  belongs_to :travel
  belongs_to :user
  belongs_to :acceptable_price, class_name: 'Price', dependent: :destroy
  belongs_to :actual_price, class_name: 'Price', dependent: :destroy
  before_create :set_acceptable_price
  aasm column: 'state' do
    state :pending
    state :in_process, initial: true
    state :success
    state :failure
    event :agree do
      transitions from: :pending, to: :in_process
    end
    event :finish do
      transitions from: :in_process, to: :success
    end
    event :abort do
      transitions from: :in_process, to: :failure
    end
    event :disagree do
      transitions from: :pending, to: :declined
    end
  end

  def update_acceptable_price!
    self.acceptable_price.try(:destroy!)
    self.set_acceptable_price
    self.save!
  end

  protected
    def set_acceptable_price
      self.acceptable_price = Price.create!(currency: Currency.where(id: self.acceptable_price_currency_id).first, raw_value: self.acceptable_price_value) unless self.acceptable_price_value.blank?
    end
end