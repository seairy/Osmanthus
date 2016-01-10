class User < ActiveRecord::Base
  include Identifierable, AASM
  mount_uploader :portrait, UserPortraitUploader
  aasm column: 'state' do
    state :unactivated
    state :activated, initial: true
    state :prohibited
  end

  def update_basic_attributes_from_wechat options = {}
    uri = URI("https://api.weixin.qq.com/sns/userinfo?access_token=#{options[:access_token]}&openid=#{options[:open_id]}&lang=zh_CN")
    request = Net::HTTP::Get.new(uri)
    response = JSON.parse(response = Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      http.ssl_version = :SSLv3
      http.request(request)
    end.body)
    self.nickname = response['nickname'] if self.nickname.blank?
    self.remote_portrait_url = response['headimgurl'] if self.portrait.blank?
    self.save!
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