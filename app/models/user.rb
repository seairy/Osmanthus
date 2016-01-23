class User < ActiveRecord::Base
  include Identifierable, AASM
  mount_uploader :portrait, UserPortraitUploader
  as_enum :gender, [:unknown, :male, :female], prefix: true, map: :string
  has_many :travels
  has_many :deals
  aasm column: 'state' do
    state :unactivated, initial: true
    state :activated
    state :prohibited
    event :active do
      transitions from: [:unactivated, :activated], to: :activated
    end
    event :deactive do
      transitions from: [:unactivated, :activated], to: :unactivated
    end
  end

  def update_attributes_from_wechat options = {}
    if self.nickname.blank?
      Wechat::Base.find_user_basic_attributes(options).tap do |base_attributes|
        self.nickname = base_attributes['nickname'] 
        self.remote_portrait_url = base_attributes['headimgurl']
        self.gender = case base_attributes['sex']
          when '0' then :unknown
          when '1' then :male
          when '2' then :female
        end
        self.active if Wechat::Base.find_user_attributes(options)['subscribe'] == 1
        self.save!
      end
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

    def find_open_id open_id
      where(open_id: open_id).first || raise(ActiveRecord::RecordNotFound)
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