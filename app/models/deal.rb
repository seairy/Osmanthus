class Deal < ActiveRecord::Base
  include Identifierable, AASM
  belongs_to :travel
  belongs_to :acceptable_price, class_name: 'Price'
  belongs_to :actual_price, class_name: 'Price'
  aasm column: 'state' do
    state :pending, initial: true
    state :unfinished
    state :finished
    event :agree do
      transitions from: :pending, to: :unfinished
    end
    event :finish do
      transitions from: :unfinished, to: :finished
    end
  end
end