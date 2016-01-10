class User < ActiveRecord::Base
  include Identifierable, AASM
  aasm column: 'state' do
    state :unactivated
    state :activated, initial: true
    state :prohibited
  end

  class << self
    def find_or_create_by_open_id open_id
      where(open_id: open_id).first.tap do |user|
        # user.try(:behaviors).try(:sign_in!)
      end || create!(open_id: open_id).tap do |user|
        # user.behaviors.touch!
      end
    end

    def faker
      create!(open_id: "faker_#{SecureRandom.urlsafe_base64}").tap do |user|
        # user.behaviors.touch!
      end
    end
  end
end