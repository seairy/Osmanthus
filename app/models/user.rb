class User < ActiveRecord::Base
  include Identifierable, AASM
  mount_uploader :portrait, UserPortraitUploader
  has_many :travels
  has_many :deals
  aasm column: 'state' do
    state :unactivated
    state :activated, initial: true
    state :prohibited
  end

  def update_basic_attributes_from_wechat options = {}
    Wechat::Base.find_basic_attributes(options).tap do |base_attributes|
      self.nickname = base_attributes['nickname'] if self.nickname.blank?
      self.remote_portrait_url = base_attributes['headimgurl'] if self.portrait.blank?
      self.save!
    end
  end

  class << self
    def find_or_create_by_open_id open_id
      where(open_id: open_id).first.tap do |user|
        # user.try(:behaviors).try(:sign_in!)
      end || create!(open_id: open_id).tap do |user|
        # user.behaviors.touch!
      end
    end

    def create_faker options = {}
      create!(open_id: "faker_#{SecureRandom.urlsafe_base64}").tap do |user|
        user.update!(nickname: Faker::Name.name)
        user.update!(portrait: File.open(File.join(Rails.root, 'public', 'abstract_images', "#{rand(1..200).to_s.rjust(3, '0')}.jpg"))) if options[:with_portrait]
        # user.behaviors.touch!
      end
    end
  end
end