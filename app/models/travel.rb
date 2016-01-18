class Travel < ActiveRecord::Base
  include Identifierable, AASM
  belongs_to :user
  belongs_to :country
  has_many :destinations
  has_many :deals
  default_scope { includes(:deals) }
  validates :departure_at, presence: true
  validates :return_at, presence: true

  aasm column: 'state' do
    state :preparing, initial: true
    state :departured
    state :returned
    event :departure do
      transitions from: :preparing, to: :departured
    end
    event :return do
      transitions from: :departured, to: :returned
    end
  end

  def set_destinations! countries
    countries.each do |country|
      self.destinations.create!(country: country)
    end
  end
end