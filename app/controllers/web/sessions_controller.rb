# -*- encoding : utf-8 -*-
class Web::SessionsController < Web::BaseController
  skip_before_action :authenticate
  skip_before_action :set_current_user
  skip_before_action :check_follower

  def force_new
    render layout: false
  end

  def force_create
    user = User.find_or_create_by_open_id(params[:open_id])
    session[:user] = { id: user.id }
    redirect_to web_home_path
  end

  def create
    Wechat::Base.find_authorization_data(params[:code]).tap do |authorization_data|
      user = User.find_or_create_by_open_id(authorization_data['openid'])
      user.update_attributes_from_wechat(access_token: authorization_data['access_token'], open_id: authorization_data['openid'])
      session[:user] = { id: user.id }
    end
    redirect_to(session['previous_path'] || web_home_path)
  end

  def destroy
    reset_session
    redirect_to web_home_path
  end
end