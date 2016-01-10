# -*- encoding : utf-8 -*-
class Web::SessionsController < Web::BaseController
  skip_before_action :authenticate
  skip_before_action :set_current_user

  def create
    user = User.find_or_create_by_open_id(Wechat::Base.find_open_id(params[:code]))
    session[:user] = { id: user.id }
    redirect_to wechat_dashboard_path
  end
end