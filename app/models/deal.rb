class Deal < ActiveRecord::Base
  include Identifierable, AASM
  attr_accessor :photograph_media_ids, :acceptable_price_value, :acceptable_price_currency_id, :actual_price_value, :actual_price_currency_id
  belongs_to :travel
  belongs_to :user
  belongs_to :acceptable_price, class_name: 'Price', dependent: :destroy
  belongs_to :actual_price, class_name: 'Price', dependent: :destroy
  has_many :photographs, class_name: 'DealPhotograph'
  before_create :set_acceptable_price
  after_create :set_photographs
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
  validates :content, presence: true
  validates :expected_quantity, presence: true

  def update_acceptable_price!
    self.acceptable_price.try(:destroy!)
    self.set_acceptable_price
    self.save!
  end

  def buy attributes
    actual_price_value = attributes[:actual_price_value].to_f
    actual_price_currency = Currency.find(attributes[:actual_price_currency_id])
    unless self.acceptable_price.blank?
      if self.acceptable_price.currency.blank?
        raise UnacceptablePrice.new if actual_price_currency.exchange_to_local(actual_price_value) > self.acceptable_price.in_local
      else
        raise DifferentCurrency.new if actual_price_currency.id != self.acceptable_price.currency.id
        raise UnacceptablePrice.new if actual_price_value > self.acceptable_price.in_foreign
      end
    end
    self.update!(attributes.merge(actual_price: Price.create!(currency: actual_price_currency, raw_value: actual_price_value)))
    self.finish!
  end

  protected
    def set_photographs
      photograph_media_ids.each do |photograph_media_id|
        self.photographs.create_with_wechat!(type: :sample, media_id: photograph_media_id)
      end unless photograph_media_ids.blank?
    end

    def set_acceptable_price
      self.acceptable_price = Price.create!(currency: Currency.where(id: self.acceptable_price_currency_id).first, raw_value: self.acceptable_price_value) unless self.acceptable_price_value.blank?
    end
end