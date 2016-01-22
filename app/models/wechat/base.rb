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
      request = Net::HTTP::Get.new(uri)
      response = JSON.parse(response = Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE
        http.ssl_version = :SSLv3
        http.request(request)
      end.body)
      first ? update_all(access_token: response['access_token'], expired_at: Time.now + response['expires_in'].seconds) : create!(access_token: response['access_token'], expired_at: Time.now + response['expires_in'].seconds)
      first
    end

    def find_authorization_data code
      uri = URI("https://api.weixin.qq.com/sns/oauth2/access_token?appid=#{Setting.key[:wechat][:appid]}&secret=#{Setting.key[:wechat][:secret]}&code=#{code}&grant_type=authorization_code")
      request = Net::HTTP::Get.new(uri)
      JSON.parse(response = Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE
        http.ssl_version = :SSLv3
        http.request(request)
      end.body)
    end

    def find_basic_attributes options = {}
      uri = URI("https://api.weixin.qq.com/cgi-bin/user/info?access_token=#{options[:access_token]}&openid=#{options[:open_id]}&lang=zh_CN")
      Rails.logger.info "**************** uri: #{uri}"
      request = Net::HTTP::Get.new(uri)
      response = Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE
        http.ssl_version = :SSLv3
        http.request(request)
      end.body
      Rails.logger.info "*************** #{response}"
    end
  end
end