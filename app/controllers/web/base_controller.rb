# -*- encoding : utf-8 -*-
class Web::BaseController < ApplicationController
  layout 'web'

  skip_before_action :verify_authenticity_token
  before_action :set_previous_path, except: %w{verify}
  before_action :authenticate, except: %w{verify}
  before_action :set_current_user, except: %w{verify}
  before_action :check_follower, except: %w{verify}

  unless Rails.application.config.consider_all_requests_local
    rescue_from Exception, with: lambda { |exception| render_error 500, exception }
    rescue_from ActionController::RoutingError, ActionController::UnknownController, ::AbstractController::ActionNotFound, ActiveRecord::RecordNotFound, with: lambda { |exception| render_error 404, exception }
  end

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
            User.find_or_create_by_open_id(notification['FromUserName']).active!
            result = reply_text_message(open_id: notification['FromUserName'], content: "欢迎使用小信鸽！分享您的旅行箱，结交更多好朋友~👫\r\n<a href=\"http://luggagep.com/web/restore\">点击此处</a>返回到之前的页面")
          when 'unsubscribe'
            User.where(open_id: notification['FromUserName']).first.try(:deactive!)
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
    def render_error status, exception
      ServiceException.create(module: :web, caller_id: (session['user'].try(:[], 'id') || 0), name: exception.class.to_s, message: exception.message, backtrace: "<p>#{exception.backtrace.try(:join, '</p><p>')}</p>")
      render template: "web/errors/error_#{status}", status: status
    end

    def authenticate
      redirect_to "https://open.weixin.qq.com/connect/oauth2/authorize?appid=#{Setting.key[:wechat][:appid]}&redirect_uri=#{URI.encode("http://#{Setting.key[:application][:host_name]}/web/sign_in", ':/')}&response_type=code&scope=snsapi_userinfo&state=authenticate#wechat_redirect" unless session['user']
    end

    def set_current_user
      @current_user = User.find(session['user']['id'])
    end

    def set_previous_path
      session['previous_path'] = request.path
    end

    def check_follower
      redirect_to web_follow_path if @current_user.unactivated?
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