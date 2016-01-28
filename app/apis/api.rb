# -*- encoding : utf-8 -*-
module DocFormatter
  def self.call object, env
    object.to_json
  end
end

module ErrorFormatter
  def self.call message, backtrace, options, env
    if message.to_s =~ /\d{5}/
      if message < 20000
        { error_code: message, message: APIError.message(message) }.to_json
      else
        { exception_code: message, message: APIException.message(message) }.to_json
      end
    else
      { error_code: 10000, message: message }.to_json
    end
  end
end

class API < Grape::API
  version :v1
  format :json
  prefix :api
  error_formatter :json, ErrorFormatter
  content_type :json, 'application/json; charset=utf8'

  helpers do
    def api_error_or_exception code
      if code < 20000
        error!(code, APIError.send("code_#{code}")[:status])
      else
        error!(code, 200)
      end
    end

    def api_success
      { result: :success }
    end
  end

  mount V1::WechatAPI

  namespace :doc do
    formatter :json, DocFormatter 
    add_swagger_documentation api_version: 'v1'
  end
end