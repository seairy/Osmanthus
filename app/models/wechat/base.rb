class Wechat::Base < ActiveRecord::Base
  self.table_name = 'wechat'

  def expired?
    self.expired_at < Time.now
  end

  class << self
    def access_token
      current_access_token = first
      if current_access_token.nil? or current_access_token.expired?
        find_access_token
      else
        current_access_token
      end.access_token
    end

    def find_access_token
      uri = URI.parse("https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid=#{Setting.key[:wechat][:appid]}&secret=#{Setting.key[:wechat][:secret]}")
      http = Net::HTTP.new(uri.host, 443)
      http.use_ssl = true
      request = Net::HTTP::Get.new(uri.request_uri)
      response = http.request(request)
      json = JSON.parse(response.body)
      first ? update_all(access_token: json['access_token'], expired_at: Time.now + json['expires_in'].seconds) : create!(access_token: json['access_token'], expired_at: Time.now + json['expires_in'].seconds)
      first
    end

    def find_open_id code
      uri = URI("https://api.weixin.qq.com/sns/oauth2/access_token?appid=#{Setting.key[:wechat][:appid]}&secret=#{Setting.key[:wechat][:secret]}&code=#{code}&grant_type=authorization_code")
      request = Net::HTTP::Get.new(uri)
      JSON.parse(response = Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE
        http.ssl_version = :SSLv3
        http.request(request)
      end.body)['openid']
    end
  end
end