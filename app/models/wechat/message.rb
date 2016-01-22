class Wechat::Message < Wechat::Base
  class << self
    def get_auto_reply
      uri = URI("https://api.weixin.qq.com/cgi-bin/get_current_autoreply_info?access_token=#{Wechat::Base.access_token}")
      request = Net::HTTP::Get.new(uri)
      JSON.parse(response = Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE
        http.ssl_version = :SSLv3
        http.request(request)
      end.body)
    end

    def delete
      uri = URI("https://api.weixin.qq.com/cgi-bin/menu/delete?access_token=#{Wechat::Base.access_token}")
      request = Net::HTTP::Post.new(uri)
      response = Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE
        http.ssl_version = :SSLv3
        http.request(request)
      end.body
    end
  end
end