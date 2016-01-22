# -*- encoding : utf-8 -*-
class Web::BaseController < ApplicationController
  layout 'web'

  skip_before_action :verify_authenticity_token
  before_action :authenticate, except: %w{verify}
  before_action :set_current_user, except: %w{verify}

  def verify
    if params[:signature] and params[:timestamp] and params[:nonce] and Digest::SHA1.hexdigest([params[:timestamp], params[:nonce], Setting.key[:wechat][:token]].sort.join) == params[:signature]
      if request.post?
        notification, result = MultiXml.parse(request.raw_post)['xml'], nil
        case notification['MsgType']
        when 'text'
          
        when 'image'
          
        when 'location'
          
        when 'link'
          
        when 'event'
          case notification['Event']
          when 'SCAN'
          when 'subscribe'
            User.find_open_id(notification['FromUserName']).active!
            result = reply_text_message(open_id: notification['FromUserName'], content: '欢迎使用小信鸽！<a href="http://luggagep.com/web/restore">点击此处</a>返回到之前的页面')
          when 'unsubscribe'
            User.find_open_id(notification['FromUserName']).deactive!
          end
        when 'voice'
          
        when 'video'
          
        when 'shortvideo'
          
        else
          raise ArgumentError, 'Unknown Weixin Message'
        end
      end
      render plain: (params[:echostr] || result || 'success')
    else
      render plain: 'failure'
    end
  end

  def error
  end

  protected
    def authenticate
      redirect_to "https://open.weixin.qq.com/connect/oauth2/authorize?appid=#{Setting.key[:wechat][:appid]}&redirect_uri=http%3A%2F%2Fluggagep.com%2Fweb%2Fsign_in&response_type=code&scope=snsapi_userinfo&state=authenticate#wechat_redirect" unless session['user']
    end

    def set_current_user
      @current_user = User.find(session['user']['id'])
    end

    def set_previous_path
      session['previous_path'] = request.path
    end

    def reply_text_message options = {}
      '<xml>'\
      "<ToUserName><![CDATA[#{options[:open_id]}]]></ToUserName>"\
      "<FromUserName><![CDATA[#{Setting.key[:wechat][:origin_id]}]]></FromUserName>"\
      "<CreateTime>#{Time.now.to_i}</CreateTime>"\
      '<MsgType><![CDATA[text]]></MsgType>'\
      "<Content><![CDATA[#{options[:content]}]]></Content>"\
      "</xml>"
    end
end