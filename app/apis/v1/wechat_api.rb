# -*- encoding : utf-8 -*-
module V1
  class WechatAPI < Grape::API
    before do
      api_error_or_exception(10004) if params[:secret] != Setting.key[:application][:secret]
    end

    resource :wechat do
      params do
        requires :secret, type: String
      end
      get :access_token do
        present(access_token: Wechat::Base.access_token)
      end

      params do
        requires :secret, type: String
      end
      get :jsapi_ticket do
        present(jsapi_ticket: Wechat::Base.jsapi_ticket)
      end
    end
  end
end