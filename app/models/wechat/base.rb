class Wechat::Base < ActiveRecord::Base
  self.table_name = 'wechat'

  def expired?
    self.expired_at < Time.now
  end

  class << self
    def access_token
      if Rails.env.production?
        global_variable(:access_token)
      else
        request_and_response_as_json("http://luggagep.com/api/v1/wechat/access_token?secret=#{Setting.key[:application][:secret]}")['access_token']
      end
    end

    def jsapi_ticket
      if Rails.env.production?
        global_variable(:jsapi_ticket)
      else
        request_and_response_as_json("http://luggagep.com/api/v1/wechat/jsapi_ticket?secret=#{Setting.key[:application][:secret]}")['jsapi_ticket']
      end
    end

    def find_access_token
      response = request_with_ssl_and_response_as_json("https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid=#{Setting.key[:wechat][:appid]}&secret=#{Setting.key[:wechat][:secret]}")
      where(name: :access_token).first.tap do |access_token|
        access_token.try(:update!, { value: response['access_token'], expired_at: Time.now + response['expires_in'].seconds })
      end || create!(name: 'access_token', value: response['access_token'], expired_at: Time.now + response['expires_in'].seconds)
    end

    def find_jsapi_ticket
      response = request_with_ssl_and_response_as_json("https://api.weixin.qq.com/cgi-bin/ticket/getticket?access_token=#{Wechat::Base.access_token}&type=jsapi")
      where(name: :jsapi_ticket).first.tap do |jsapi_ticket|
        access_token.try(:update!, { value: response['ticket'], expired_at: Time.now + response['expires_in'].seconds })
      end || create!(name: 'jsapi_ticket', value: response['ticket'], expired_at: Time.now + response['expires_in'].seconds)
    end

    def find_authorization_data code
      request_with_ssl_and_response_as_json("https://api.weixin.qq.com/sns/oauth2/access_token?appid=#{Setting.key[:wechat][:appid]}&secret=#{Setting.key[:wechat][:secret]}&code=#{code}&grant_type=authorization_code")
    end

    def find_user_basic_attributes options = {}
      request_with_ssl_and_response_as_json("https://api.weixin.qq.com/sns/userinfo?access_token=#{options[:access_token]}&openid=#{options[:open_id]}&lang=zh_CN")
    end

    def find_user_attributes options = {}
      request_with_ssl_and_response_as_json("https://api.weixin.qq.com/cgi-bin/user/info?access_token=#{Wechat::Base.access_token}&openid=#{options[:open_id]}&lang=zh_CN")
    end

    def global_variable name
      current_variable = where(name: name).first
      if current_variable.nil? or current_variable.expired?
        send("find_#{name}")
      else
        current_variable
      end.value
    end

    def request_with_ssl_and_response_as_json uri, options = {}
      uri = URI(uri)
      request = Net::HTTP::Get.new(uri)
      JSON.parse(response = Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE
        http.ssl_version = :SSLv3
        http.request(request)
      end.body)
    end

    def request_and_response_as_json uri, options = {}
      uri = URI(uri)
      request = Net::HTTP::Get.new(uri)
      JSON.parse(response = Net::HTTP.start(uri.host, uri.port) do |http|
        http.request(request)
      end.body)
    end

    def cleanup
      self.destroy_all
    end
  end
end